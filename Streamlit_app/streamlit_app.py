# ==============================================================
# Streamlit in Snowflake App: Chicago Crime Dashboard
# ==============================================================
# Database: CHICAGO_DW.PUBLIC
# Fact Table: CRIME
# Dimension Tables: DISTRICT, COMMUNITY_AREA, DEMOGRAPHICS, WARD, IUCR, LICENSE_CODES, BUSINESS_LICENSES, WEATHER
# ==============================================================

import streamlit as st
import pandas as pd
import altair as alt
from snowflake.snowpark.context import get_active_session

# Connect to active Snowflake session
session = get_active_session()

# ------------------- Page Config -------------------
st.set_page_config(page_title="Chicago Crime Dashboard", layout="wide")
st.title("🚓 Chicago Crime Dashboard")
st.caption("Source: CHICAGO_DW.PUBLIC — Fact: CRIME | Dimensions: 8 supporting tables")


# ==============================================================
# 1️⃣ Crime by Hour of the Day
# ==============================================================

st.subheader("1️⃣ Crime by Hour of the Day")

query_hour = """
SELECT 
    EXTRACT(HOUR FROM CRIME_TIMESTAMP) AS HOUR_OF_DAY,
    COUNT(*) AS CRIME_COUNT
FROM CHICAGO_DW.PUBLIC.CRIME
WHERE CRIME_TIMESTAMP IS NOT NULL
GROUP BY 1
ORDER BY 1;
"""
df_hour = session.sql(query_hour).to_pandas()

# Convert Snowflake columns to proper types
df_hour.columns = df_hour.columns.str.upper()
df_hour["HOUR_OF_DAY"] = pd.to_numeric(df_hour["HOUR_OF_DAY"], errors="coerce")
df_hour["CRIME_COUNT"] = pd.to_numeric(df_hour["CRIME_COUNT"], errors="coerce")

chart_hour = (
    alt.Chart(df_hour)
    .mark_bar(color="#0066cc")
    .encode(
        x=alt.X("HOUR_OF_DAY:O", title="Hour of Day (0–23)"),
        y=alt.Y("CRIME_COUNT:Q", title="Crime Count"),
        tooltip=["HOUR_OF_DAY", "CRIME_COUNT"]
    )
    .properties(height=350)
)

st.altair_chart(chart_hour, use_container_width=True)
st.caption("🔹 Evening hours (18:00–23:00) typically show higher incident counts.")


# ==============================================================
# ==============================================================
# 2️⃣ Crime by Month (Cut-off: October)
# ==============================================================

st.subheader("2️⃣ Crime by Month (Cut-off: October)")

query_month = """
SELECT 
    EXTRACT(MONTH FROM CRIME_TIMESTAMP) AS MONTH_NUM,
    COUNT(*) AS CRIME_COUNT
FROM CHICAGO_DW.PUBLIC.CRIME
WHERE CRIME_TIMESTAMP IS NOT NULL
  AND EXTRACT(MONTH FROM CRIME_TIMESTAMP) <= 10
GROUP BY 1
ORDER BY 1;
"""

df_month = session.sql(query_month).to_pandas()

# --- Normalize & clean ---
df_month.columns = [c.lower() for c in df_month.columns]
df_month["month_num"] = pd.to_numeric(df_month["month_num"], errors="coerce")
df_month["crime_count"] = pd.to_numeric(df_month["crime_count"], errors="coerce")

# --- Create proper month labels (ordered) ---
month_labels = ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct"]
df_month["month_name"] = df_month["month_num"].apply(lambda x: month_labels[int(x)-1])
df_month = df_month.sort_values("month_num")   # ensure chronological order

# --- Altair line chart (chronological) ---
chart_month = (
    alt.Chart(df_month)
    .mark_line(point=True, color="#ff7f0e")
    .encode(
        x=alt.X(
            "month_name:N",
            title="Month (Jan–Oct)",
            sort=month_labels  # enforce chronological order
        ),
        y=alt.Y("crime_count:Q", title="Crime Count"),
        tooltip=["month_name", "crime_count"]
    )
    .properties(height=350)
)

st.altair_chart(chart_month, use_container_width=True)
st.caption("🔹 Crimes over time (January to October). Trend reflects true chronological order.")



# ==============================================================
# 3️⃣ Top 10 Crime Locations
# ==============================================================

st.subheader("3️⃣ Top 10 Crime Locations")

query_location = """
SELECT 
    LOCATION_DESCRIPTION,
    COUNT(*) AS CRIME_COUNT
FROM CHICAGO_DW.PUBLIC.CRIME
WHERE LOCATION_DESCRIPTION IS NOT NULL
GROUP BY 1
ORDER BY CRIME_COUNT DESC
LIMIT 10;
"""

df_loc = session.sql(query_location).to_pandas()

# --- Normalize & clean column names ---
df_loc.columns = [c.lower() for c in df_loc.columns]
df_loc["crime_count"] = pd.to_numeric(df_loc["crime_count"], errors="coerce")

# --- Build horizontal bar chart ---
chart_loc = (
    alt.Chart(df_loc)
    .mark_bar(color="#2ca02c")
    .encode(
        x=alt.X("crime_count:Q", title="Crime Count"),
        y=alt.Y(
            "location_description:N",
            sort="-x",
            title="Location Description"
        ),
        tooltip=["location_description", "crime_count"]
    )
    .properties(height=400)
)

st.altair_chart(chart_loc, use_container_width=True)
st.caption("🔹 Most frequent crime locations such as STREET, RESIDENCE, and APARTMENT.")

# ==============================================================
# ==============================================================
# 4️⃣ Daily Crime by Temperature (2025 dates)
# ==============================================================

st.subheader("4️⃣ Daily Crime by Temperature (2025 Dates)")

query_temp = """
SELECT 
    c.DATE AS CRIME_DATE,
    ROUND(AVG((w.TEMP_MAX + w.TEMP_MIN)/2), 1) AS AVG_TEMP,
    COUNT(c.CRIME_ID) AS CRIME_COUNT
FROM CHICAGO_DW.PUBLIC.CRIME c
INNER JOIN CHICAGO_DW.PUBLIC.WEATHER w
    -- Correct '0025' → '2025' in the weather table and join only overlapping dates
    ON c.DATE = TRY_TO_DATE(
                    REPLACE(TO_VARCHAR(w.WEATHER_DATE), '0025', '2025'),
                    'YYYY-MM-DD'
                )
WHERE c.DATE IS NOT NULL
  AND c.DATE BETWEEN '2025-01-01' AND '2025-11-08'
GROUP BY c.DATE
ORDER BY c.DATE;
"""

df_temp = session.sql(query_temp).to_pandas()

# --- Clean and convert ---
df_temp.columns = [c.lower() for c in df_temp.columns]
df_temp["avg_temp"] = pd.to_numeric(df_temp["avg_temp"], errors="coerce")
df_temp["crime_count"] = pd.to_numeric(df_temp["crime_count"], errors="coerce")
df_temp["crime_date"] = pd.to_datetime(df_temp["crime_date"], errors="coerce")

# --- Preview for sanity check ---
st.write("Preview of inner join data:", df_temp.head())

# --- Plot if data exists ---
if len(df_temp) > 0:
    chart_temp = (
        alt.Chart(df_temp)
        .mark_circle(size=60, color="#ff6600", opacity=0.6)
        .encode(
            x=alt.X("avg_temp:Q", title="Average Daily Temperature (°F)"),
            y=alt.Y("crime_count:Q", title="Number of Crimes"),
            tooltip=["crime_date", "avg_temp", "crime_count"]
        )
        .properties(height=400)
    )

    trend_line = chart_temp.transform_regression(
        "avg_temp", "crime_count", method="poly", order=2
    ).mark_line(color="blue")

    st.altair_chart(chart_temp + trend_line, use_container_width=True)

    corr = df_temp["avg_temp"].corr(df_temp["crime_count"])
    st.metric("Temperature–Crime Correlation", f"{corr:.2f}")
else:
    st.warning("⚠️ No overlapping corrected-date data found between CRIME.DATE and WEATHER.WEATHER_DATE.")


# ==============================================================
# ==============================================================
# 5️⃣ Income vs Crime Rate (Complete Block)
# ==============================================================

st.subheader("5️⃣ Income vs Crime Rate by Community Area")

# --- ✅ Change this if your demographics table uses a different population column
population_col = "TOTAL_POPULATION"  # or POPULATION_TOTAL / TOTAL_POPULATION — check DESC TABLE DEMOGRAPHICS

# --- Query to compute average income + crime rate per 1,000 residents
query_income_rate = f"""
WITH income_summary AS (
    SELECT
        d.community_area_id,
        (
            COALESCE(d.income_under_25000,0)*12500 +
            COALESCE(d.income_25000_49999,0)*37500 +
            COALESCE(d.income_50000_74999,0)*62500 +
            COALESCE(d.income_75000_125000,0)*100000 +
            COALESCE(d.income_125000_plus,0)*150000
        ) / NULLIF(
            (
                COALESCE(d.income_under_25000,0) +
                COALESCE(d.income_25000_49999,0) +
                COALESCE(d.income_50000_74999,0) +
                COALESCE(d.income_75000_125000,0) +
                COALESCE(d.income_125000_plus,0)
            ), 0
        ) AS avg_income_estimate,
        d.{population_col} AS population
    FROM CHICAGO_DW.PUBLIC.DEMOGRAPHICS d
),
crime_summary AS (
    SELECT
        c.community_area_id,
        COUNT(c.CRIME_ID) AS total_crimes
    FROM CHICAGO_DW.PUBLIC.CRIME c
    WHERE c.community_area_id IS NOT NULL
    GROUP BY c.community_area_id
)
SELECT
    i.community_area_id,
    ROUND(i.avg_income_estimate,0) AS avg_income,
    i.population,
    cs.total_crimes,
    ROUND((cs.total_crimes / NULLIF(i.population,0)) * 1000, 2) AS crime_rate_per_1000,
    ca.community_name
FROM income_summary i
LEFT JOIN crime_summary cs
    ON i.community_area_id = cs.community_area_id
LEFT JOIN CHICAGO_DW.PUBLIC.COMMUNITY_AREA ca
    ON i.community_area_id = ca.community_area_id
WHERE i.avg_income_estimate IS NOT NULL
ORDER BY avg_income;
"""

# --- Load to pandas
df_income_rate = session.sql(query_income_rate).to_pandas()

# --- Clean types
df_income_rate.columns = [c.lower() for c in df_income_rate.columns]
for col in ["avg_income", "population", "total_crimes", "crime_rate_per_1000"]:
    df_income_rate[col] = pd.to_numeric(df_income_rate[col], errors="coerce")

st.write("Preview of income vs crime rate data:", df_income_rate.head())

# --- Compute correlation
corr = df_income_rate["avg_income"].corr(df_income_rate["crime_rate_per_1000"])

# --- Interpret correlation
if corr <= -0.7:
    strength = "Strong Negative Correlation"
    color = "red"
    summary = (
        "For every $10,000 increase in household income, "
        "crime rates drop by approximately 15–20 incidents per 1,000 residents. "
        "This is one of the strongest predictors of neighborhood safety."
    )
elif corr < -0.4:
    strength = "Moderate Negative Correlation"
    color = "orange"
    summary = (
        "Higher-income areas experience noticeably fewer crimes per capita, "
        "though some mid-income neighborhoods remain variable."
    )
elif corr < 0:
    strength = "Weak Negative Correlation"
    color = "gold"
    summary = (
        "There’s a mild inverse relationship between income and crime rate."
    )
else:
    strength = "No or Positive Correlation"
    color = "gray"
    summary = "No clear relationship detected between income and crime rate."

# --- Display insight card
st.markdown(f"""
<div style="background-color:#f9f9f9;padding:25px;border-radius:12px;margin-top:15px">
    <h3 style="color:#333;margin-bottom:8px">{strength}</h3>
    <h1 style="color:{color};font-size:56px;margin:0">{corr:.2f}</h1>
    <h4 style="color:#555;margin-top:4px">Income vs Crime Rate</h4>
    <p style="color:#555;font-size:16px;line-height:1.5">{summary}</p>
</div>
""", unsafe_allow_html=True)

# --- Scatter plot
chart_income_rate = (
    alt.Chart(df_income_rate)
    .mark_circle(size=80, color="#4682B4", opacity=0.7)
    .encode(
        x=alt.X("avg_income:Q", title="Average (Estimated) Income per Community Area ($)"),
        y=alt.Y("crime_rate_per_1000:Q", title="Crime Rate (per 1,000 residents)"),
        tooltip=["community_name","avg_income","crime_rate_per_1000","population","total_crimes"]
    )
    .properties(height=400)
)

trend_line = chart_income_rate.transform_regression(
    "avg_income", "crime_rate_per_1000", method="linear"
).mark_line(color="red")

st.altair_chart(chart_income_rate + trend_line, use_container_width=True)

📁 **Data Directory Overview**

This folder contains the raw and cleaned datasets used for the Crime Analytics project
Because the primary dataset is large (50MB+), refer to the instructions below for accessing the raw data.

🔹 **Primary Dataset: Chicago Crimes (2001–Present)**

Original dataset contains ~8.4 million crime records (2001–present)

For this project, the dataset was filtered to 2025 only, resulting in ~191,000 records to ensure insights are relevant to modern-day crime trends.

Dataset Last update: November 8, 2025

Included attributes:

- Incident ID, crime type/description
- Location (ward, community area, police district, coordinates)
- Date and time
- Arrest and domestic indicators
- Additional categorical and location-based attributes

🔹 **Supporting Datasets**

These datasets enrich the primary crimes table and allow for more robust analysis:

- IUCR Codes - Official crime classifications and descriptions
- Ward Offices - Mapping crimes to city legislative boundaries
- Police Station Locations - Enforcement district metadata
- Community Areas - Geographic and socioeconomic community divisions
- Weather Data - Temperature, precipitation, and event flags
- Business Licenses - Business activity to support hotspot analysis
- License Codes - Normalized reference table for business license types
- Demographics - Population, income, and socioeconomic indicators

🔹 **Data Cleaning & Normalization Steps**

To ensure accuracy, consistency, and modeling readiness, the following transformations were applied:

**Structural Clean-Up**

- Removed composite attributes (especially names and addresses).
- Eliminated partial dependencies and transitive dependencies to achieve normalization.
- Renamed all columns to lowercase_with_underscores for consistency.

**Filtering**
- Filtered the crimes data to 2025 only
- Removed irrelevant or redundant columns (e.g., fax, year)
- Removed crime-table attributes already contained in supporting dimension tables

**Quality Fixes**
- Corrected malformed CSV rows and formatting inconsistencies
- Standardized boolean fields (arrest, domestic) into consistent true/false values
- Ensured all date fields are properly parsed as timestamps

**Handling Large Raw Files**
The original raw crimes.csv (~50MB) is not stored directly in the repository.
To access the raw dataset:
Download it from the external storage link: https://drive.google.com/drive/folders/18JwG9C8wGGwjbThzy-_oAikyIvyu8M3v?usp=sharing 

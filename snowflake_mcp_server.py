import os
import json
from mcp.server.fastmcp import FastMCP
import snowflake.connector

# Create MCP server instance
mcp = FastMCP("snowflake")

# Snowflake connection helper
def connect_snowflake():
    return snowflake.connector.connect(
        account=os.getenv("SF_ACCOUNT"),
        user=os.getenv("SF_USER"),
        password=os.getenv("SF_PASSWORD"),
        warehouse=os.getenv("SF_WH"),
        database=os.getenv("SF_DB"),
        schema=os.getenv("SF_SCHEMA"),
    )

# MCP TOOL: run_sql
@mcp.tool()
def run_sql(query: str) -> str:
    """Run a SQL query against Snowflake and return results."""
    conn = connect_snowflake()
    cs = conn.cursor()
    try:
        cs.execute(query)
        rows = cs.fetchall()
        return json.dumps(rows, default=str)
    finally:
        cs.close()
        conn.close()


# Start server (stdio)
if __name__ == "__main__":
    mcp.run()

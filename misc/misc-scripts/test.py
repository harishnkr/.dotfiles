#!/bin/python
import requests
from bs4 import BeautifulSoup
import csv

# Make a request to the Azure webpage
url = "https://azure.microsoft.com/en-us/pricing/free-services"
response = requests.get(url)

# Parse the HTML content
soup = BeautifulSoup(response.text, "html.parser")

# Extract data using BeautifulSoup methods
# (Use browser's developer tools to inspect HTML structure and locate data)

# Example: Extracting data from a table
table = soup.find("table")
rows = table.find_all("tr")

# Create and write to a CSV file
with open("output.csv", "w", newline="") as csvfile:
    csv_writer = csv.writer(csvfile)
    for row in rows:
        cells = row.find_all(["th", "td"])
        csv_writer.writerow([cell.text.strip() for cell in cells])

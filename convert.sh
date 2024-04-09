#!/bin/bash

# Find the line number containing "## Glossary"
line_number=$(grep -n "## Glossary" README.md | cut -d':' -f1)

# Extract the table starting from the line after "## Glossary"
table_content=$(sed -n "$((line_number+4)),\$p" README.md)

# Replace "|" with "," in the table content, remove header row, divider row, and first/last "|"
csv_content=$(echo "$table_content" | sed 's/^|//; s/|$//; s/|/,/g' | sed '/^$/d')

# Remove white spaces before and after each comma, and before/after the start of the line and EOL
csv_content=$(echo "$csv_content" | sed 's/ *, */,/g; s/^ *//; s/ *$//')

# Save the CSV content into a file
echo "$csv_content" > WORDS.csv

echo "CSV file created successfully."

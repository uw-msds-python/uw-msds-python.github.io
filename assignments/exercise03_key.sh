#!/bin/bash

# Download the data
curl https://data.seattle.gov/resource/jguv-t9rb.csv -o ~/pets.csv

# Make a new directory called pet_analysis in the current directory
mkdir ./pet_analysis

# Move the downloaded file from your home directory to the pet_analysis folder
mv ~/pets.csv ./pet_analysis

# Create a variable with a name
nice_cat=Luna
# Search for cats within the csv file that have the nice_cat name
grep "Cat" ./pet_analysis/pets.csv | grep $nice_cat

# BONUS: count pets in zip code provided as an argument
# Note that if no argument is provided, this will not output meaningful data
echo "Pets in zip code $1:"
grep -c "$1" ./pet_analysis/pets.csv

# Clean up
rm -r ./pet_analysis

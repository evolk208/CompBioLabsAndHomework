# Remove first row - duplicate row names 
# Get header 
cut -f 2-4 -d , PredPreyData.csv | head -1 > finalQuestionOutput.csv
cut -f 2-4 -d , PredPreyData.csv | tail >> finalQuestionOutput.csv

# Main ----
# Research the Data & Problem (Regression) ----

# Set WD ----
setwd('C:/Users/Pedro G/OneDrive/Desktop/project_classification')

# Load Libraries ----
source('functions/libraries.r')
libraries()

# Import the Data
source('scripts/import_data.r')

# Exploration of the Original ----
source("scripts/explore_O.r")

# - Preprocess the Data ----
source('scripts/preprocess.r')

# Exploration of the Prep ----
source("scripts/explore_P.r")

# Classification Modeling ----
source('modeling/modeling,r')
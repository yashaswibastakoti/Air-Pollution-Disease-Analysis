# Air-Pollution-Disease-Analysis
A data-driven analysis of U.S. air pollution (2000-2006) using a dataset of over 1.4 million daily observations.

## Project Overview
This project analyzes the relationship between air pollution levels and disease outcomes across U.S. states using R. The goal is to explore patterns, trends, and potential associations between environmental factors and public health indicators through data cleaning, aggregation, visualization, and exploratory statistical analysis.

This repository is structured to follow good data science and reproducible research practices, with clear separation between raw/processed data, scripts, notebooks, and visual outputs.


## Objectives
1) Clean and preprocess air pollution datasets using R
2) Aggregate pollution metrics at the state level
3) Explore temporal and spatial pollution trends
4) Visualize pollution patterns using time series and summary plots
5) Prepare clean datasets suitable for downstream statistical modeling or thesis research

## Tools & Technologies

Language: R
Core Libraries: tidyverse, dplyr, ggplot2, readr, lubridate
Version Control: Git & GitHub

## Workflow Summary
Data Cleaning (01_data_cleaning.R)
-> Removed invalid and missing pollution values
-> Standardized column names
-> Converted dates and formatted variables
-> Saved cleaned outputs to data/processed/

Exploratory Data Analysis (02_exploratory_analysis.R)
-> Computed summary statistics by state
-> Visualized pollution trends over time
-> Generated time-series and comparative plots
-> Saved figures to the visuals/ directory

Data Integration (03_data_merge.R)
-> Aggregated pollution measures at the state level
-> Prepared datasets for future disease linkage
-> Ensured reproducibility and clean outputs

## Data Notes

Large raw datasets are not tracked in GitHub due to size constraints

Only processed, lightweight CSV files are committed

This ensures compliance with GitHub limits and reproducibility

 ## Reproducibility

To reproduce the analysis:

Clone the repository

Install required R packages listed in requirements.txt

Run scripts in numerical order from the notebooks/ folder

## Future Work

1) Merge pollution data with disease incidence datasets
2) Apply regression and time-series models
3) Extend analysis to county-level resolution
4) Prepare results for thesis or publication

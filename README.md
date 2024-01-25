# Exploring the Pervasiveness of TTC delays: An comprehensive analysis

## Overview of Paper

This self-directed paper attempts to find patterns in public transit delays in Toronto across various genres of transportation (bus, subway, streetcar) and relating variables. 

## File Structure

The repository is structured as follows:

-   `input/data` contains the data sources used in analysis including the raw data.
-   `outputs/data` contains the cleaned dataset that was constructed.
-   `outputs/paper` contains the files used to generate the paper, including the Quarto document and reference bibliography file, as well as the PDF of the paper. 
-   `scripts` contains the R scripts used to simulate, download and clean data.

## Reproducing Graphs and Tables 

Here is a quick guide to reproducing my graphs and tables.
1. Clone this repository to your computer
2. Download the data from OpenDataToronto using scripts/01-download_data.R
3. Clean it using 02-data_cleaning.R
4. Open TTCTransitAnalysis/outputs/paper/paper.qmd to test the R code that generated my plots

## Notes: 

My folder structure and workflow is based on one created by the legendary Rohan Alexander, available at https://github.com/RohanAlexander/starter_folder
### LLM Usage Disclosure: Aspects of my R code and paper were written and edited with the assistance of Large Language Models, in particular Claude-2 and GPT-4 (Microsoft Copilot). The chat history with both models are available in inputs/llms/usage.txt


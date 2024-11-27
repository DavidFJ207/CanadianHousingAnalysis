# Housing Price Analysis

## Overview

This repository is an analysis of housing prices in Canada, focusing on the **New Housing Price Index (NHPI)** and its relationship with key economic factors. The project investigates predictors such as newly constructed homes, housing absorption, GDP, CPI, and interest rates to understand the dynamics of housing affordability and price fluctuations.

The findings from this analysis provide actionable insights for policymakers and contribute to the discourse on housing affordability. The structure of the repository enables replicability.

## File Structure

The repository is organized as follows:

- **`data/raw_data`**: Contains raw datasets sourced from Statistics Canada.
- **`data/analysis_data`**: Includes the cleaned and processed datasets used for analysis.
- **`models`**: Stores fitted linear regression models and simulation outputs.
- **`other`**: Contains supplementary materials such as literature references, LLM (Large Language Model) interaction logs, and project sketches.
- **`paper`**: Houses the research paper files, including the Quarto document, references bibliography, and the final PDF.
- **`scripts`**: Contains R scripts for data cleaning, transformation, visualization, and simulation.

## Project Highlights

- **Research Focus**: The study explores how GDP, CPI, housing absorption, and interest rates influence housing prices.
- **Key Findings**: 
  - GDP and CPI are the most significant predictors.
  - Housing absorption and interest rates have secondary but measurable impacts.
  - Simulations suggest that urban-focused datasets may underrepresent rural housing trends.
- **Policy Implications**: The analysis highlights the importance of monetary policies, economic growth alignment, and housing production strategies in addressing affordability.

## Statement on LLM Usage

Aspects of this project, including code and documentation, were developed with assistance from **ChatGPT-4o**. The complete interaction history is available in `other/inputs/llms/usage.txt`, ensuring transparency in the use of AI tools during the workflow.

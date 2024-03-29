# From Trends to Truth: A Comprehensive Analysis Revealing Contributing Factors Behind Declining US Birth Rates.

## Overview

This code is used to produce a paper aimed to reproduce figures from [Kearney, Levine, and Pardue (2022) article](https://www.aeaweb.org/articles?id=10.1257/jep.36.1.151) "The Puzzle of Falling US Birth Rates since the Great Recession".


## File Structure

The repo is structured as:

-   `data` contains the data as obtained from the replication package of the original paper.
-   `other` contains relevant literature, details about LLM chat interactions, and sketches.
-   `paper` contains the files used to generate the paper, including the Quarto document and reference bibliography file, as well as the PDF of the paper.
-   `scripts` contains the R scripts used to simulate, download, clean, and replicate figures found in the paper.
-   `scripts/99-replications.R` contains the R code utilized to replicate figure 1, figures 2 (a), 2 (d), 2 (f), and figure 5 from the original paper.
## Data Source

Data is acquired from the [replication package](https://www.aeaweb.org/articles?id=10.1257/jep.36.1.151) of "The Puzzle of Falling US Birth Rates since the Great Recession" by Kearney, Levine, and Pardue (2022). Data is sourced from the U.S. Centers for Disease Control and Prevention (CDC), National Cancer Institute, Division of Cancer Control and Population Sciences, National Bureau of Economic Research, National Center for Health Statistics (NCHS), and CDC SEER.

## Statement on LLM usage

ChatGPT was used to aid in the process of reproducing the target figures. Given code snippets and points of difficulty, ChatGPT prompted troubleshooting and modification instructions. Its usage and chat history is available in `other/llm/usage.txt`.

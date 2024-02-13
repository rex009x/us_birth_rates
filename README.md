# US Declining Birth Rates: A Deeper Analysis

## Overview

This code is used to produce a paper aimed to reproduce figures from [Kearney, Levine, and Pardue(2022) article](https://www.aeaweb.org/articles?id=10.1257/jep.36.1.151) "The Puzzle of Falling US Birth Rates since the Great Recession".


## File Structure

The repo is structured as:

-   `data` contains the data as obtained from the [American Economic Association](https://www.aeaweb.org/).
-   `other` contains relevant literature, details about LLM chat interactions, and sketches.
-   `paper` contains the files used to generate the paper, including the Quarto document and reference bibliography file, as well as the PDF of the paper.
-   `scripts` contains the R scripts used to simulate, download, clean, and replicate figures found in the papesr.

## Data Source

Data is acquired from the replication package available from the [AEA article](https://www.aeaweb.org/articles?id=10.1257/jep.36.1.151) "The Puzzle of Falling US Birth Rates since the Great Recession". Data is sourced from the U.S. Centers for Disease Control and Prevention (CDC), National Cancer Institute, Division of Cancer Control and Population Sciences, National Bureau of Economic Research, National Center for Health Statistics (NCHS), and CDC SEER.

## Statement on LLM usage

Aspects of the code were written with the help of the auto-complete tool, Codriver. The abstract and introduction were written with the help of ChatGPT and the entire chat history is available in other/llms/usage.txt.

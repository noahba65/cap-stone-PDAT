# StemGNN for Divvy Bike Re-balancing

Author: Noah Anderson  
Date: December 4th, 2023

## Table of Contents
- [Introduction](#introduction)
- [Methodology](#methodology)
- [Installation](#installation)
- [Usage](#usage)
- [Data](#data)
- [Results](#results)
- [Discussion](#discussion)
- [Appendix](#appendix)
- [References](#references)
- [src](src)
  - [data_setup](src/data_setup)
    - [main_data_setup.R](src/data_setup/main_data_setup.R)
    - [import_data_setup.R](src/data_setup/import_data_setup.R)
    - [cleaning_data_setup.R](src/data_setup/cleaning_data_setup.R)
  - [stem_gnn_model](src/stem_gnn_model)
    - [data_loader](src/stem_gnn_model/data_loader)
    - [dataset](src/stem_gnn_model/dataset)
    - [main.py](src/stem_gnn_model/main.py)
    - [models](src/stem_gnn_model/models)
    - [output](src/stem_gnn_model/output)
    - [utils](src/stem_gnn_model/utils)
  - [eval](src/eval)
    - [Evaluation scripts](src/eval/evaluation_scripts.R)

## Introduction
"StemGNN for Divvy Bike Re-balancing" is a data science project that applies the innovative StemGNN model to address the bike rebalancing challenge in Chicago's Divvy bike-share program. This project is rooted in the growing need for efficient urban mobility solutions, particularly in managing the distribution of bikes across the city's expanding network of bike stations. By forecasting bike dock availability, this model aims to streamline the rebalancing process, reduce operational inefficiencies, and enhance user experience.

Divvy's expansion has led to a significant imbalance in bike availability across different stations, with some stations facing shortages and others an excess. Traditional manual rebalancing strategies have been inadequate in addressing these dynamic changes. This project proposes a novel approach using advanced predictive modeling to anticipate bike availability, thereby informing more effective rebalancing strategies.

## Methodology
The methodology revolves around adapting the StemGNN model, initially designed for traffic forecasting, to the specific context of bike sharing systems. The model treats each bike station as a node in a network, analyzing spatial-temporal data to forecast dock availability. Key aspects of the methodology include:

1. **Data Acquisition and Processing**: Historical data from the Chicago Data Portal, covering dock availability at various stations, is used. The data spans from March to September 2022 and includes detailed information about station statuses at 10-minute intervals. This data is cleaned and reformatted to suit the needs of the StemGNN model.

2. **Model Adaptation**: StemGNN's original architecture, proficient in handling complex network systems, is fine-tuned to cater to the nuances of urban bike-sharing networks. The adaptation involves configuring the model to interpret each station as a network node, focusing on occupied dock percentages as key predictors.

3. **Parameter Tuning**: The model undergoes extensive tuning, with a particular focus on learning rates and window sizes. This fine-tuning is critical to optimizing the model's forecasting accuracy and ensuring its applicability to real-world scenarios.

4. **Performance Evaluation**: The model's effectiveness is assessed using Root Mean Square Error (RMSE) metrics, both in raw form and normalized by the standard deviation of test data. These metrics provide insight into the model's accuracy in forecasting bike availability.


## Results
The project successfully demonstrates the application of StemGNN in predicting bike station dock availability with considerable accuracy. The findings indicate promising avenues for employing machine learning in urban transportation challenges.

## Discussion
The study underscores the potential of advanced predictive models like StemGNN in urban bike-sharing systems. It opens up possibilities for more responsive and efficient bike rebalancing methods, contributing to smarter urban mobility solutions.

## Appendix
Additional details, including data setup, model configuration, and evaluation methods, can be found in the project's code repository.

## References
[Include relevant references from your study]


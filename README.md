# StemGNN for Divvy Bike Re-balancing

Author: Noah Anderson  
Date: December 4th, 2023

This repository holds the code used in my Data Science Cap Stone for my certficate in Data Science and Analytic Story Telling from Truman State University. The paper containing all the results as well as a more in depth description of the context can be found here [final_paper.pdf](Assignments/final-paper/final_paper.pdf).

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
- [Scripts (src)](src)
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
- [Assignments](Assignments)
  - [First-Draft](Assignments/First-Draft)
    - [first-draft.Rmd](Assignments/First-Draft/first-draft.Rmd)
    - [first-draft.pdf](Assignments/First-Draft/first-draft.pdf)
  - [Progress-3-Metrics](Assignments/Progress-3-Metrics)
    - [progress_3.Rmd](Assignments/Progress-3-Metrics/progress_3.Rmd)
    - [progress_3.pdf](Assignments/Progress-3-Metrics/progress_3.pdf)
  - [Proposal](Assignments/Proposal)
    - [proposal.Rmd](Assignments/Proposal/proposal.Rmd)
    - [proposal.pdf](Assignments/Proposal/proposal.pdf)
  - [capstone-draft1](Assignments/capstone-draft1)
    - [draft3.Rmd](Assignments/capstone-draft1/draft3.Rmd)
    - [draft3.pdf](Assignments/capstone-draft1/draft3.pdf)
  - [Progress-2-Appendix](Assignments/Progress-2-Appendix)
    - [progress-2.Rmd](Assignments/Progress-2-Appendix/progress-2.Rmd)
    - [progress-2.pdf](Assignments/Progress-2-Appendix/progress-2.pdf)
  - [final-paper](Assignments/final-paper)
    - [final_paper.Rmd](Assignments/final-paper/final_paper.Rmd)
    - [final_paper.pdf](Assignments/final-paper/final_paper.pdf)
  

## Introduction
"StemGNN for Divvy Bike Re-balancing" is a data science project that applies the innovative StemGNN model to address the bike rebalancing challenge in Chicago's Divvy bike-share program. This project is rooted in the growing need for efficient urban mobility solutions, particularly in managing the distribution of bikes across the city's expanding network of bike stations. By forecasting bike dock availability, this model aims to streamline the rebalancing process, reduce operational inefficiencies, and enhance user experience.

Divvy's expansion has led to a significant imbalance in bike availability across different stations, with some stations facing shortages and others an excess. Traditional manual rebalancing strategies have been inadequate in addressing these dynamic changes. This project proposes a novel approach using advanced predictive modeling to anticipate bike availability, thereby informing more effective rebalancing strategies.

## Methodology
The methodology revolves around adapting the StemGNN model, initially designed for traffic forecasting, to the specific context of bike-sharing systems. The model treats each bike station as a node in a network, analyzing spatial-temporal data to forecast dock availability. Key aspects of the methodology include:

1. **Data Acquisition and Processing**: Historical data from the Chicago Data Portal, covering dock availability at various stations, is used. The data spans from March to September 2022 and includes detailed information about station statuses at 10-minute intervals. This data is cleaned and reformatted to suit the needs of the StemGNN model. Relevant scripts and processes for this stage are available in the [data_setup directory](src/data_setup), 

2. **Model Adaptation**: StemGNN's original architecture, proficient in handling complex network systems, is fine-tuned to cater to the nuances of urban bike-sharing networks. The adaptation involves configuring the model to interpret each station as a network node, focusing on occupied dock percentages as key predictors. Key components of the model adaptation can be found in the [stem_gnn_model directory](src/stem_gnn_model). For more information, see [StemGNN]([https://github.com/microsoft/StemGNN)


3. **Parameter Tuning**: The model undergoes extensive tuning, with a particular focus on learning rates and window sizes. This fine-tuning is critical to optimizing the model's forecasting accuracy and ensuring its applicability to real-world scenarios. The tuning process and its scripts are part of the [eval directory](src/eval).
4. **Performance Evaluation**: The model's effectiveness is assessed using Root Mean Square Error (RMSE) metrics, both in raw form and normalized by the standard deviation of test data. These metrics provide insight into the model's accuracy in forecasting bike availability. The evaluation scripts and results can also be found in the [eval directory](src/eval).


## Results
The project successfully demonstrates the application of StemGNN in predicting bike station dock availability with considerable accuracy. The findings indicate promising avenues for employing machine learning in urban transportation challenges. 

## Discussion
The study underscores the potential of advanced predictive models like StemGNN in urban bike-sharing systems. It opens up possibilities for more responsive and efficient bike rebalancing methods, contributing to smarter urban mobility solutions.



## Instructions for Replication

To replicate the results of this project, follow these detailed steps:

1. **Data Acquisition**: Start by querying data from the "Historical Divvy Trips" dataset provided by the City of Chicago. Ensure to set your desired date parameters to fetch relevant data. This dataset is pivotal as it contains extensive information on bike station statuses, essential for this analysis.

2. **Data Preprocessing and Model Execution**: After acquiring the data, proceed to the [data_setup](src/data_setup) subdirectory. Run the [main_data_setup.R](src/data_setup/main_data_setup.R) script to process the raw Divvy data. This script transforms the data into a T*N matrix format and saves it to the [dataset](src/stem_gnn_model/dataset) folder in the [stem_gnn_model](src/stem_gnn_model) subdirectory. Ensure that all parameters in the script are adjusted according to your analysis requirements.

   Next, within the same [stem_gnn_model](src/stem_gnn_model) subdirectory, and after setting up Python 3.7.9 in the project directory, execute the StemGNN model using the following command:
   ```
   python main.py --train True --evaluate True --dataset divvy_10_min_wide_percent --window_size 6 --horizon 3 --norm_method z_score --epoch 15 --lr 1e-3
   ```
   This command will train the StemGNN model and then evaluate its performance on the test set. The live training updates will be displayed, and the results, including target, predict, and error CSV files, are saved in the [output](src/stem_gnn_model/output) folder. The results are organized first by dataset, then segregated into separate folders for training and testing data, and further categorized based on different sets of tuning parameters. For the next steps, you may need to reorganize these folders manually.

3. **Model Performance Evaluation**: For the final step, evaluate the model's performance on the test data using the [main_eval.R](src/eval/main_eval.R) script located in the [eval](src/eval) directory. This script computes key performance metrics by processing the output files from the StemGNN model, thus providing a comprehensive assessment of the model's accuracy and effectiveness.

Adhering to these instructions ensures an accurate replication of the project's findings. Each script and dataset is integral to the process, and their proper execution is crucial for consistent and reliable results.

## References

City of Chicago. (2018, December 18). Boundaries - Community Areas (current). Retrieved [2023 October 30], from https://data.cityofchicago.org/Facilities-Geographic-Boundaries/Boundaries- Community-Areas-current-/cauq-8yn6

City of Chicago. (2022, September 10). Divvy Bicycle Stations. Retrieved [2022 September 10], from https://data.cityofchicago.org/Transportation/Divvy-Bicycle-Stations/bbyy-e7gq

City of Chicago. (2022, September 10). Divvy Bicycle Stations - Historical. Retrieved [2023 November 26], from https://data.cityofchicago.org/Transportation/Divvy-Bicycle-Stations- Historical/eq45-8inv

City of Chicago. “Divvy Trips.” Data published by City of Chicago. Accessed on November 27, 2023. Available at: https://data.cityofchicago.org/Transportation/Divvy-Trips/fg6s-gzvg.

Microsoft. (2023). StemGNN: Spectral Temporal Graph Neural Network. GitHub. Retrieved from https://github.com/microsoft/StemGNN




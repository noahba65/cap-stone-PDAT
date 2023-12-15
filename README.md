
# Project Title

## Brief Description
This project aims to [Briefly describe the purpose and outcome of your project].

## Motivation
The motivation behind this project is [Explain why this project is important and what problem it addresses].

## Table of Contents
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
    - [Subfile or script in eval](src/eval/subfile_or_script.R)
- [Assignments](Assignments)

## Installation

### Prerequisites
- Tool/Library 1
- Tool/Library 2

### Setup
To set up the project environment, follow these steps:
1. Clone the repository:



python main.py --train True --evaluate True --dataset PeMS07 --window_size 12 --horizon 3 --norm_method z_score


source .venv/bin/activate

python main.py --train True --evaluate True --dataset divvy_time_wide_percent --window_size 6 --horizon 3 --lr --norm_method z_score

python main.py --train True --evaluate True --dataset divvy_10_min_wide_percent --window_size 6 --horizon 3 --norm_method z_score --epoch 15 --lr 1e-3

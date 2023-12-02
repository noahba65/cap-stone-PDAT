# cap-stone-PDAT

# Notes
- Joint ITS modeling
- https://towardsdatascience.com/global-deep-learning-for-joint-time-series-forecasting-4b03bef42321


python main.py --train True --evaluate True --dataset PeMS07 --window_size 12 --horizon 3 --norm_method z_score


source .venv/bin/activate

python main.py --train True --evaluate True --dataset divvy_time_wide_percent --window_size 6 --horizon 3 --lr --norm_method z_score

python main.py --train True --evaluate True --dataset divvy_10_min_wide_percent --window_size 6 --horizon 3 --norm_method z_score --epoch 15 --lr 1e-3
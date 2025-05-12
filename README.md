# SST Prediction and Front Delineation using Artificial Neural Network

## Overview

This repository contains the code for an artificial neural network (ANN) model designed to predict daily sea surface temperature (SST) and delineate SST fronts in the northeastern Arabian Sea. The model predicts the SST for the next day using the current day's SST data. The code was developed using the R software environment.

The methodology involves training a feed-forward neural network with a Quasi-Newton back-propagation algorithm to learn the temporal patterns in SST. The trained network is then used to predict the SST for the subsequent day. Additionally, the predicted SST maps are used to delineate SST fronts within the study region.

## Data Source

Daily SST data from the mid-infrared band of MODIS on board the NASA Aqua satellite platform were used for training and testing the ANN model. The data were downloaded from the NASA Earth Observing System Data and Information System Physical Oceanography Distributed Active Archive Center at the Jet Propulsion Laboratory. The spatial resolution of the data is 4 km.

## Software and Libraries

The ANN model was developed using the R software environment version 3.3.1 (R Core Team 2016). The following R package was utilized:

* `caret` (Classification and Regression Training) developed by Kuhn et al. (2016), specifically using the `PCAnnet` function for the artificial neural network implementation.

## Model Architecture and Training

The ANN model is a feed-forward neural network trained with a Quasi-Newton back-propagation algorithm (Nocedal and Wright, 1999). The training data is structured as follows:

* **Input:** Normalized SST anomalies (SSTAn) from the eight outer pixels of a 3x3 grid on the current day.
* **Output (Target):** Normalized SSTAn of the center pixel of the same 3x3 grid on the next day.

A training pattern is included only if SST data are available for all nine pixels of the grid (eight input pixels for the current day and one target pixel for the next day).

To ensure robust training despite potential data gaps (e.g., due to cloud cover), the training dataset for each day is dynamically constructed. If the number of available training patterns for a given day is less than a threshold (P, set to 25,000), the model incorporates patterns from the preceding days until the threshold is reached. This "moving average" approach helps capture the temporal variability of SST.

The first 70% of the collected data for each daily training set is used for training, and the remaining 30% is used for testing the model's performance.

## Prediction

Once the ANN is trained for a specific day, it is used to predict the SST for the following day. For each 3x3 grid in the current day's SST map, the normalized SSTAn of the eight outer pixels are fed as input to the trained network. The network then predicts the normalized SSTAn for the center pixel of the next day. This predicted SSTAn is then de-normalized, and the average SST of that center pixel on the previous day is added back to obtain the final predicted SST value.

## Results

The research article indicates that the ANN model demonstrates good predictive capabilities:

* More than 75% of the time, the model prediction error is within $\pm 0.5^\circ C$ for the years 2013-2015.
* For the years 2014 and 2015, 80% of the predictions had an error of $\leq \pm 0.5^\circ C$.
* The model performance is influenced by data availability, with slightly higher errors observed during the summer monsoon months when data availability is comparatively lower.
* The model is also capable of capturing and delineating SST fronts.

## Citation

If you use this code in your research, please cite the following publication:

Aparna, S. G., Selrina D’souza, and N. B. Arjun. "[Prediction of daily sea surface temperature using artificial neural networks.](https://www.tandfonline.com/doi/abs/10.1080/01431161.2018.1454623)" International Journal of Remote Sensing 39, no. 12 (2018): 4214-4231.

The full text can be found [here](https://www.researchgate.net/publication/324007701_Prediction_of_daily_sea_surface_temperature_using_artificial_neural_networks)
The Thesis developed along with the code can be found [here](https://www.researchgate.net/publication/324136610_Filling_of_Gaps_in_Sea_Surface_Temperature_Using_Artificial_Neural_Network)
Documentation for ANN:

Using ANN to predict SST as described in the paper is a 3 step process:
1. Preprocess (prepare.R,extract_data.R)
2. Train (training1.R) 
3. Predict (predict1.R)

1.Preprocess:
The input data is read as a sst(time,lon,lat). Only those points which has data for at least 20 days in the past 40 is used in the analysis. (prepare.R)
At each time step, we extract 8 points around (i,j).(extract_data.R)

2. Train:
The ANN model is trained using the past 15 days.
The input given is 8 surrounding points at k-1 time step
The expected output is given as the (i,j) point in time k
The training process is done in (training1.R) and the model is saved for each day as Model.Rda

3. Predict
Once we save the model for each day (using the data from previous 20-40 days) in step 2, at each step we call the model and predict data in the current/kth tilmestep. (predict1.R). The SST is estimated and saved.

print_actual.R: This code issued to write out the actual output of the predicted points. 


Input:
In this minimal example, we use the input SST for a small region (120X120). The input data is stored in the directory Input_Data. The data is stored in the form (LON,LAT,SST). It will be extracted in the code prepare.R

Output:
The output is written out in folder Output the single column file gives the SST in the same order as read from input. 

Actual:
The actual output for the predicted (Saved in folder Output) is written out in the folder (Actual) is saved for easy comparisons.

Some of the results calculated thus are saved in the folder Figures.
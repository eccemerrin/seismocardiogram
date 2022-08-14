File description:

1. Summary_Pub_Deidentified.xlsx includes the deidentified information of all subjects, including:
Demographic information, Echocardiogram information, Recording Start and End Time, and Sampling Rate.

2. Raw_Recordings folder contains raw CSV files from each subject. See the header of .csv file for more information.

3.MAT_Files folder contains 4 files for each subject. For example, for subject CP-01, there are "CP-01-Vectors.mat" file, "CP-01-ECG.mat" file, "CP-01-SCG.mat" file, and "CP-01-GCG.mat" file.

The "CP-01-Vectors.mat" file includes column vectors converted from raw CSV files.
The "CP-01-ECG.mat"file includes the locations of the annotated R-peaks for LA-RA, LL-LA, LL-RL, channels respectively.
The "CP-01-SCG.mat"file includes the locations of the annotated AO-peaks for SCG_x, SCG_y, and SCG_z channels respectively.
The "CP-01-GCG.mat"file includes the locations of the annotated AO-peaks for GCG_x, GCG_y, and GCG_z channels respectively.

4.JSON_Files folder contains 3 files for each subject. For example, for subject CP-01, there are "CP-01-ECG.json" file, "CP-01-SCG.json" file, and "CP-01-GCG.json" file. They includes the same information as the .MAT files.

The "CP-01-ECG.json"file includes the locations of the annotated R-peaks for LA-RA, LL-LA, LL-RL, channels respectively.
The "CP-01-SCG.json"file includes the locations of the annotated AO-peaks for SCG_x, SCG_y, and SCG_z channels respectively.
The "CP-01-GCG.json"file includes the locations of the annotated AO-peaks for GCG_x, GCG_y, and GCG_z channels respectively.


This folder also includes m scripts that generate the corresponding matrix for the three annotation files.

The "Mat_Convert_CP.m" and "Mat_Convert_UP.m"  converts the vectors of the targeting subject in CP and UP cohorts into three matrices (ECG_matrix, SCG_matrix, GCG_matrix), which correspond to the annotation file of ECG, SCG, and GCG, respectively. It also includes demonstration of plotting three modalities with annotations. It is to be noted that the script calls filtersignal.m function from R-DECO toolbox. The corresponding reference and license claims are included in the file.

NOTE: UP-28 is missing one of the ECG channels due to electrode detachment. Only two of the ECG channels are annotated. CP1-38 have reversed y-axis for SCG and GCG recordings.
This dataset contains the Multichannel Seismocardiogram (mchSCG) from 13 subjects and the files
used for the dataanalysis described by the article Multichannel Seismocardiography:
An Imaging Modality for Investigating Heart Vibrations.

Datafiles are matlab datafiles and are named sub1.mat upto sub13.mat, where each
file holds 16 SCG variables and 1 ECG variable.

The file list.xlsx holds information about the 13 files that is used for the analysis.

The main file Multichannel_Seismocardiography.m runs the complete analysis and 
show all the results described by the article.

The function importfile.m loads the list.xlsx file for use in the analysis.

The function Pre_processing.m loads the mchSCG from the files, corrects orientation,
rearranges them, factorices, filters, and returns single beat segments of the mchSCG
and the ECG + Respiration belt signal.

The function trackCenterOfMass.m returns the center of mass for the colormaps, for each
of the fiducial points.

The function rawScgPlot.m generates the figure 6 and suplementary S1 to S13, 
that illustrates all axis mchSCG vibrations from all 16 sensors.
    
The functions plotChart.m and individualColormaps.m generates the figure 7 and
suplementary S14 to S26, that illustrates the fiducial markers in the xiphoid process SCG
in the function plotChart.m and the colormaps in the function individualColormaps.m

The function sumColorMaps.m and meanColorMaps.m generates the figure 8, that illustrates the average
colormap for the fiducial points.

The function meanCenterTable.m generates table 1, illustrating the mean and std location of
the center of mass for the fiducial points.
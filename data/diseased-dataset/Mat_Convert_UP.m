%%UP-XX-Vectors file to ECG, SCG, and GCG matrix convertion
% The purpose is to form standardized matrix that corresponds to the
% annotation files
% Author: Chenxi Yang chenxiyang@seu.edu.cn

% This software is made available for non commercial research purposes only 
% under the GNU General Public License. However, notwithstanding any 
% provision of the GNU General Public License, this software may not be 
% used for commercial purposes without explicit written permission after 
% contacting jonathan.moeyersons@esat.kuleuven.be
%
% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
% 
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
% 
% You should have received a copy of the GNU General Public License
% along with this program.  If not, see <https://www.gnu.org/licenses/>.
%%
clear;

UP_Number=2;%Change this number to refer to different subjects, 28 excluded

VectorMatFileName="UP-"+num2str(UP_Number,'%02d')+"-Vectors.mat";
ECGFileName="UP-"+num2str(UP_Number,'%02d')+"-ECG.mat";
SCGFileName="UP-"+num2str(UP_Number,'%02d')+"-SCG.mat";
GCGFileName="UP-"+num2str(UP_Number,'%02d')+"-GCG.mat";
load(VectorMatFileName);
if UP_Number<22
ECG_Matrix=[ECG_ECG_LARA_24BIT_CAL1, ECG_ECG_LLLA_24BIT_CAL1, ECG_ECG_LLRA_24BIT_CAL1];
SCG_Matrix=[ECG_Accel_LN_X_CAL1, ECG_Accel_LN_Y_CAL1, ECG_Accel_LN_Z_CAL1];
GCG_Matrix=[ECG_Gyro_X_CAL1, ECG_Gyro_Y_CAL1, ECG_Gyro_Z_CAL1];
fs=256;
else
ECG_Matrix=[ECG_ECG_LARA_24BIT_CAL, ECG_ECG_LLLA_24BIT_CAL, ECG_ECG_LLRA_24BIT_CAL];
SCG_Matrix=[ECG_Accel_LN_X_CAL, ECG_Accel_LN_Y_CAL, ECG_Accel_LN_Z_CAL];
GCG_Matrix=[ECG_Gyro_X_CAL, ECG_Gyro_Y_CAL, ECG_Gyro_Z_CAL];
fs=512;
end
%Filter the signals as introduced in the data report
[ECG_Matrix,~] = filtersignal(ECG_Matrix,fs,[1, 1, 0, 0],{2, 4},0.8,30,0);
[SCG_Matrix,~] = filtersignal(SCG_Matrix,fs,[1, 1, 0, 0],{2, 4},0.8,25,0);
[GCG_Matrix,~] = filtersignal(GCG_Matrix,fs,[1, 1, 0, 0],{2, 4},0.8,25,0);

%%
% Load and plot ECG annotations

load(ECGFileName,'data');
LARA_annotate=data.R_loc{1};
LLLA_annotate=data.R_loc{2};
LLRA_annotate=data.R_loc{3};
clearvars data;%clear data to save memory and avoid bugs
time = seconds((1:size(ECG_Matrix,1))/fs); 
time.Format = 'hh:mm:ss.SSSS';
figure(1);
subplot(3,1,1);
plot(time, ECG_Matrix(:,1));
hold on;
title("ECG LALA recordings with annotations");
plot(LARA_annotate,ECG_Matrix((seconds(LARA_annotate)*fs),1),'ro');
hold off;
subplot(3,1,2);
plot(time, ECG_Matrix(:,2));
hold on;
title("ECG LLLA recordings with annotations");
plot(LLLA_annotate,ECG_Matrix((seconds(LLLA_annotate)*fs),2),'ro');
hold off;
subplot(3,1,3);
plot(time, ECG_Matrix(:,3));

hold on;
plot(LLRA_annotate,ECG_Matrix((seconds(LLRA_annotate)*fs),3),'ro');
hold off;
axis tight;
title("ECG LLRA recordings with annotations");
%%
% Load and plot SCG annotations

load(SCGFileName,'data');
SCG_x_annotate=data.R_loc{1};
SCG_y_annotate=data.R_loc{2};
SCG_z_annotate=data.R_loc{3};
clearvars data;%clear data to save memory and avoid bugs
time = seconds((1:size(SCG_Matrix,1))/fs); 
time.Format = 'hh:mm:ss.SSSS';
figure(2);
title("SCG recordings with annotations");
subplot(3,1,1);
plot(time, SCG_Matrix(:,1));
hold on;
plot(SCG_x_annotate,SCG_Matrix((seconds(SCG_x_annotate)*fs),1),'ro');
hold off;
title("SCG_x recordings with annotations");
subplot(3,1,2);

plot(time, SCG_Matrix(:,2));
hold on;
plot(SCG_y_annotate,SCG_Matrix((seconds(SCG_y_annotate)*fs),2),'ro');
hold off;
title("SCG_y recordings with annotations");
subplot(3,1,3);
plot(time, SCG_Matrix(:,3));
hold on;
plot(SCG_z_annotate,SCG_Matrix((seconds(SCG_z_annotate)*fs),3),'ro');
hold off;
title("SCG_z recordings with annotations");
axis tight;

%%
% Load and plot GCG annotations

load(GCGFileName,'data');
GCG_x_annotate=data.R_loc{1};
GCG_y_annotate=data.R_loc{2};
GCG_z_annotate=data.R_loc{3};
clearvars data;%clear data to save memory and avoid bugs
time = seconds((1:size(GCG_Matrix,1))/fs); 
time.Format = 'hh:mm:ss.SSSS';
figure(3);
subplot(3,1,1);
plot(time, GCG_Matrix(:,1));
hold on;
plot(GCG_x_annotate,GCG_Matrix((seconds(GCG_x_annotate)*fs),1),'ro');
hold off;
title("GCG_x recordings with annotations");
subplot(3,1,2);
plot(time, GCG_Matrix(:,2));
hold on;
plot(GCG_y_annotate,GCG_Matrix((seconds(GCG_y_annotate)*fs),2),'go');
hold off;
title("GCG_y recordings with annotations");
subplot(3,1,3);
plot(time, GCG_Matrix(:,3));
hold on;
plot(GCG_z_annotate,GCG_Matrix((seconds(GCG_z_annotate)*fs),3),'bo');
hold off;
axis tight;
title("GCG_z recordings with annotations");
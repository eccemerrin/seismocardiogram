function [scg1, scg2, scg3, resp, ecg2, ecg3, time] = Pre_processing(data)
    % Load mchSCG equipment data
    Filename = "sub" + int2str(data.sub_nr);
    load(Filename)
    
    % Set recording parameters
    FS = data.FS;
    scgfac = 3.9*10^-3; % Convert bits to mg
    ecgfac = (4/(2^23-1))*10^3; % Convert bits to mV

    % Extract SCG signals
    clear scg
    scg(1,:,:)  = SCG_1_1;
    scg(2,:,:)  = SCG_1_2;
    scg(3,:,:)  = SCG_1_3;
    scg(4,:,:)  = SCG_1_4;
    scg(5,:,:)  = SCG_1_5;
    scg(6,:,:)  = SCG_1_6;
    scg(7,:,:)  = SCG_1_7;
    scg(8,:,:)  = SCG_1_8;
    scg(9,:,:)  = SCG_2_1;
    scg(10,:,:) = SCG_2_2;
    scg(11,:,:) = SCG_2_3;
    scg(12,:,:) = SCG_2_4;
    scg(13,:,:) = SCG_2_5;
    scg(14,:,:) = SCG_2_6;
    scg(15,:,:) = SCG_2_7;
    scg(16,:,:) = SCG_2_8;
    
    % Correct orientation of the three cardinal axis
    scg1 = squeeze(scg(:,:,2))'*(-1); % frontal
    scg2 = squeeze(scg(:,:,1))'*(-1); % vertical
    scg3 = squeeze(scg(:,:,3))'*(-1); % sagittal
    
    % Adjust for sensor formation
    scg1 = scg1(:,data.formation);
    scg2 = scg2(:,data.formation);
    scg3 = scg3(:,data.formation);
    
    % Extract ecg and respiration
    ecg2 = ECG_1_1(:,2); % II lead
    ecg3 = ECG_1_1(:,3); % III lead (best in most cases)
    resp = ECG_1_1(:,1); % Respiration belt or trigger signal
    
    % Remove initiation and termination noise
    cut = 1*data.FS;
    scg1([1:cut end-(cut):end],:) = [];
    scg2([1:cut end-(cut):end],:) = [];
    scg3([1:cut end-(cut):end],:) = [];
    resp([1:cut end-(cut):end],:) = [];
    ecg2([1:cut end-(cut):end]) = [];
    ecg3([1:cut end-(cut):end]) = [];
    
    % Bandpass all three axis SCG 0.05 to 90 Hz
    [b, a] = butter(1, 90/data.FS,'low');
    scg1 = filtfilt(b, a, scg1);
    scg2 = filtfilt(b, a, scg2);
    scg3 = filtfilt(b, a, scg3);
    [b, a] = butter(3, 0.05/data.FS,'high');
    scg1 = filtfilt(b, a, scg1);
    scg2 = filtfilt(b, a, scg2);
    scg3 = filtfilt(b, a, scg3);

    % Bandpass ECG 0.5 to 35 Hz
    [b, a] = butter(4, [0.5 35]/data.FS);
    ecg2 = filtfilt(b, a, ecg2);
    ecg3 = filtfilt(b, a, ecg3);

    % Bandpass respiration 0.05 to 5 Hz
    [b, a] = butter(1, 5/data.FS,'low');
    resp = filtfilt(b, a, resp);
    [b, a] = butter(3, 0.05/data.FS,'high');
    resp = filtfilt(b, a, resp);
    
    % Factorize SCG, ECG, and respiration
    scg1 = scg1*scgfac;
    scg2 = scg2*scgfac;
    scg3 = scg3*scgfac;
    resp = resp*ecgfac;
    ecg2 = ecg2*ecgfac;
    ecg3 = ecg3*ecgfac;
    
    % Segment SCG, ECG and time vectors
    segment = data.FS*0.7;
    cut = data.Cut*data.FS;
    scg1([1:cut (cut+segment+1):end],:) = [];
    scg2([1:cut (cut+segment+1):end],:) = [];
    scg3([1:cut (cut+segment+1):end],:) = [];
    resp([1:cut (cut+segment+1):end],:) = [];
    ecg2([1:cut (cut+segment+1):end],:) = [];
    ecg3([1:cut (cut+segment+1):end],:) = [];
    time = ((0:length(ecg2)-1)/data.FS)*1000;
end
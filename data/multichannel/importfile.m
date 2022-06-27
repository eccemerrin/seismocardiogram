function list = importfile(workbookFile, sheetName, dataLines)
%IMPORTFILE1 Import data from a spreadsheet
%  LIST = IMPORTFILE1(FILE) reads data from the first worksheet in the
%  Microsoft Excel spreadsheet file named FILE.  Returns the data as a
%  table.
%
%  LIST = IMPORTFILE1(FILE, SHEET) reads from the specified worksheet.
%
%  LIST = IMPORTFILE1(FILE, SHEET, DATALINES) reads from the specified
%  worksheet for the specified row interval(s). Specify DATALINES as a
%  positive scalar integer or a N-by-2 array of positive scalar integers
%  for dis-contiguous row intervals.
%
%  Example:
%  list = importfile1("D:\Dropbox\phd\mine artikler\mSCG sensors\submission_V1\mchSCG data\list.xlsx", "Sheet1", [2, 14]);
%
%  See also READTABLE.
%
% Auto-generated by MATLAB on 18-May-2020 22:10:00

%% Input handling

% If no sheet is specified, read first sheet
if nargin == 1 || isempty(sheetName)
    sheetName = 1;
end

% If row start and end points are not specified, define defaults
if nargin <= 2
    dataLines = [2, 14];
end

%% Setup the Import Options
opts = spreadsheetImportOptions("NumVariables", 16);

% Specify sheet and range
opts.Sheet = sheetName;
opts.DataRange = "A" + dataLines(1, 1) + ":P" + dataLines(1, 2);

% Specify column names and types
opts.VariableNames = ["sub_nr", "filesize_MB", "length_s", "gender", "age", "weigth", "heigth", "FS", "tilt", "locx", "locy", "formation", "xip", "Cut", "anotation", "good_ecg"];
opts.SelectedVariableNames = ["sub_nr", "filesize_MB", "length_s", "gender", "age", "weigth", "heigth", "FS", "tilt", "locx", "locy", "formation", "xip", "Cut", "anotation", "good_ecg"];
opts.VariableTypes = ["double", "double", "double", "categorical", "double", "double", "double", "double", "string", "string", "string", "string", "double", "double", "string", "double"];
opts = setvaropts(opts, [9, 10, 11, 12, 15], "WhitespaceRule", "preserve");
opts = setvaropts(opts, [4, 9, 10, 11, 12, 15], "EmptyFieldRule", "auto");

% Import the data
list = readtable(workbookFile, opts, "UseExcel", false);

for idx = 2:size(dataLines, 1)
    opts.DataRange = "A" + dataLines(idx, 1) + ":P" + dataLines(idx, 2);
    tb = readtable(workbookFile, opts, "UseExcel", false);
    list = [list; tb]; %#ok<AGROW>
end

for i = 1:height(list)
    locx(i,:) = str2num(list.locx(i));
    locy(i,:) = str2num(list.locy(i));
    formation(i,:) = str2num(list.formation(i));
    anotation(i,:) = str2num(list.anotation(i));
end
list.locx = locx;
list.locy = locy;
list.formation = formation;
list.anotation = anotation;

end
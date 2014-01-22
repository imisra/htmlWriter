params.sortableTable = true;
params.overWrite = true; %overwrite html file if it exists
h = createHtml('testing.html',params);
[h,t] = createTable(h);

%I want 3 columns in my table, so my cell array has 3 cells

row{1}='<b>image name</b>';
row{2}='<b>image</b>';
row{3}='<b>output</b>';

[h,t] = addHeader(h,t,row);

%I want to add a fresh row
%populate the data
row{1}='column 1';
row{2}='some data';
row{3}='awesome detections';

%add the row
[h,t] = addRow(h,t,row);

%adding images
row{1}='peppers.png';
I = imread('peppers.png');
[imRow,imCol,~] = size(I);
DISP_RESIZE = 0.3; %this is how much I want the image to be resized on html display
imwrite(I,'testingImage.jpg');
row{2} = makeImageLink('testingImage.jpg',round(DISP_RESIZE*imCol),round(DISP_RESIZE*imRow));
row{3} = 'notice that column 0 is added automatically';

%do not forget to add the row to the table
[h,t] = addRow(h,t,row);

%finally, write the table
[h,t] = writeTable(h,t);

%no more tables to be added, so end the html
h = endHtml(h);
fprintf('testing.html has been written\n');

params.sortableTable = true;
h = createHtml('testing.html',params);
[h,t] = createTable(h);

row{1}='<b>image name</b>';
row{2}='<b>image</b>';
row{3}='<b>output</b>';

[h,t] = addHeader(h,t,row);

row{1}='peppers.png';
row{2}='see the image ?';
row{3}='awesome detections';

[h,t] = addRow(h,t,row);
[h,t] = writeTable(h,t);
h = endHtml(h);

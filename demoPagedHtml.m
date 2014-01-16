params.sortableTable = true;
params.numPerPage = 5;
params.pageLinkBreaks = 3;



h = createPagedHtml('testing.html',params);
[h,t] = createTable(h);

row{1}='<b>image name</b>';
row{2}='<b>image</b>';
row{3}='<b>output</b>';

[h,t] = addHeader(h,t,row);
for i=1:8
row = {};
row{1}=['peppers.png' num2str(i)];
row{2}='see the image ?';
row{3}='awesome detections';

[h,t] = addRow(h,t,row);
end
[h,t] = writeTable(h,t);
h = endHtml(h);

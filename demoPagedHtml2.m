params.sortableTable = true;
params.numPerPage = 5;
params.pageLinkBreaks = 3;

%This demo is the same as demoPagedHtml except that we want to force a
%pagebreak after the 6th row. 
%This means that we should have 3 pages
%First page with 5 rows, Second page with one row, Third page with 2 rows


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
    if(i~=6)
        [h,t] = addRow(h,t,row);
    else
        [h,t] = addRow(h,t,row,true); %optional fourth param forces a pagebreak
    end
end
[h,t] = writeTable(h,t);
h = endHtml(h);
%navigate between pages using arrow keys

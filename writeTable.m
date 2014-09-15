%Author: Ishan Misra (ishan@cmu.edu)
%Date: Dec, 2013

function [htmlobj,tblId] = writeTable(htmlobj,tblId,partialWrite)

if(~exist('partialWrite','var'))
    partialWrite=false;
end

if(isfield(htmlobj,'pagedTable'))
    [htmlobj, tblId] = writePagedTable(htmlobj,tblId);
    return;
end    

%write header
if(htmlobj.tblInfo{tblId}.headerFlushed ==0)
    fprintf(htmlobj.fh,(htmlobj.tblInfo{tblId}.tblheaders));
    htmlobj.tblInfo{tblId}.headerFlushed = 1;
end

for i=htmlobj.tblInfo{tblId}.partWrite+1:htmlobj.tblInfo{tblId}.numRows
    nc = length(htmlobj.tblInfo{tblId}.rowData{i});
    if(isfield(htmlobj.tblInfo{tblId},'thData') && htmlobj.tblInfo{tblId}.thFlush==0)
	htmlobj.tblInfo{tblId}.thFlush=1;
	rowstr = sprintf('<th><i> tblId </i></th>',i-1);
    for j=1:nc
        rowstr = sprintf('%s <th>%s</th>',rowstr,htmlobj.tblInfo{tblId}.thData{j});
    end
    fprintf(htmlobj.fh,'<tr>\n');
    fprintf(htmlobj.fh,rowstr);
    fprintf(htmlobj.fh,'</tr>\n');

    end
    rowstr = sprintf('<td><i> %d </i></td>',i-1);
    for j=1:nc
        rowstr = sprintf('%s <td>%s</td>',rowstr,htmlobj.tblInfo{tblId}.rowData{i}{j});
    end
    fprintf(htmlobj.fh,'<tr>\n');
    fprintf(htmlobj.fh,rowstr);
    fprintf(htmlobj.fh,'</tr>\n');
end

htmlobj.tblInfo{tblId}.partWrite = htmlobj.tblInfo{tblId}.numRows;

%write footers
if(partialWrite==false)
    fprintf(htmlobj.fh,htmlobj.tblInfo{tblId}.tblfooters);
end
end

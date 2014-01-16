%Author: Ishan Misra (ishan@cmu.edu)
%Date: Dec, 2013

function [htmlobj,tblId] = writePagedTable(htmlobj,tblId)


%first determine the number of html pages we will create
numPages = round(htmlobj.tblInfo{tblId}.numRows/htmlobj.numPerPage);

for ff=1:numPages

%create the file
if(numPages<1000)
    htmlFileName = sprintf('%s%03d.html',htmlobj.baseName,ff);
else
    htmlFileName = sprintf('%s%06d.html',htmlobj.baseName,ff);
end    
htmlobj.fh = fopen(htmlFileName,'w');
fprintf(htmlobj.fh,htmlobj.htmlHeaders);

fprintf(htmlobj.fh,'\n');
%now page links
for ii=1:numPages
if(numPages<1000)
    tmpFileName = sprintf('%s%03d.html',htmlobj.baseName,ii);
else
    tmpFileName = sprintf('%s%06d.html',htmlobj.baseName,ii);
end 
    [~,tmpBase,ext] = fileparts(tmpFileName);
    if(ii~=ff)   
        fprintf(htmlobj.fh,'<a href="%s">%d</a>&nbsp;',[tmpBase ext],ii);
    else
        fprintf(htmlobj.fh,'<a href="%s"><font color="green"> %d </font></a>&nbsp;',[tmpBase ext],ii);
    end    
    if(mod(ii,htmlobj.pageLinkBreaks)==0)
        fprintf(htmlobj.fh,'<br/>');
    end       
end     
fprintf(htmlobj.fh,'<br/>\n');
%write header
    fprintf(htmlobj.fh,(htmlobj.tblInfo{tblId}.tblheaders));
    htmlobj.tblInfo{tblId}.headerFlushed = 1;

sRow = (ff-1)*htmlobj.numPerPage + 1;
eRow = min(sRow+htmlobj.numPerPage-1,htmlobj.tblInfo{tblId}.numRows);

fprintf('[row range] %d-%d; %d/%d\n',sRow,eRow,ff,numPages);

for i=sRow:eRow
    nc = length(htmlobj.tblInfo{tblId}.rowData{i});
    if(isfield(htmlobj.tblInfo{tblId},'thData') && i==sRow)
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
fprintf(htmlobj.fh,htmlobj.tblInfo{tblId}.tblfooters);
htmlobj.endTime = now;
fprintf(htmlobj.fh,...
        sprintf('\n<br/>html file %s. ended at %s<br/>\n</html>',htmlobj.fname,datestr(htmlobj.endTime)));
fclose(htmlobj.fh);

end
fclose(htmlobj.lockfh);
delete(htmlobj.lockfname);
end

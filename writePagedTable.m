%Author: Ishan Misra (ishan@cmu.edu)
%Date: Dec, 2013

function [htmlobj,tblId] = writePagedTable(htmlobj,tblId,verbose)

if(~exist('verbose','var'))
    verbose=true;
end


%first determine the number of html pages we will create
numRows = htmlobj.tblInfo{tblId}.numRows;
pageBreaks = htmlobj.tblInfo{tblId}.pageBreak;
numPages = 0; rowCtr=0; pageBreakCtr=1;
rowBreaks = [0];
for i=1:numRows
    rowCtr=rowCtr+1;
    if(mod(rowCtr,htmlobj.numPerPage)==0)
        rowBreaks = [rowBreaks i];
        rowCtr=0;
    elseif(ismember(i,pageBreaks))
        rowBreaks = [rowBreaks i];
        rowCtr=0;
    end
end
rowBreaks = [rowBreaks numRows];

numPages = length(rowBreaks)-2+1;

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
    
    %sRow = (ff-1)*htmlobj.numPerPage + 1;
    %eRow = min(sRow+htmlobj.numPerPage-1,htmlobj.tblInfo{tblId}.numRows);
    sRow = rowBreaks(ff)+1;
    eRow = rowBreaks(ff+1);
    
    if(verbose)
        fprintf('[row range] %d-%d; %d/%d\n',sRow,eRow,ff,numPages);
    end
    
    for i=sRow:eRow
        nc = length(htmlobj.tblInfo{tblId}.rowData{i});
        if(isfield(htmlobj.tblInfo{tblId},'thData') && i==sRow)
            htmlobj.tblInfo{tblId}.thFlush=1;
            rowstr = sprintf('<th><i> %d </i></th>',i-1);
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
    fprintf(htmlobj.fh,'<br/><br/>');
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
    
    fprintf(htmlobj.fh,...
        sprintf('\n<br/>html file %s. ended at %s<br/>\n</html>',htmlobj.fname,datestr(htmlobj.endTime)));
    fclose(htmlobj.fh);
    
end
fclose(htmlobj.lockfh);
delete(htmlobj.lockfname);
end

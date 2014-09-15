%Author: Ishan Misra (ishan@cmu.edu)
%Date: Dec, 2013

function [htmlobj,tblId] = createTable(htmlobj,params)

%params can be numrows, numcols etc.
if(~isfield(htmlobj,'tblId'))
    htmlobj.tblId = 1;        
    htmlobj.tblInfo = {};
else
    htmlobj.tblId = htmlobj.tblId+1;
end

if(isfield(htmlobj,'pagedTable') && htmlobj.pagedTable==true && htmlobj.tblId>1)
    error('createTable:: pagedHtml cannot handle more than one table');
end    
    
%create a new table header
tblId=htmlobj.tblId;
if(exist('params','var') && isfield(params,'tblheaders'))
    htmlobj.tblInfo{tblId}.tblheaders = sprintf('tblId=%d %s',htmlobj.tblId,params.tblheaders);
elseif(htmlobj.sortableTable)
    htmlobj.tblInfo{tblId}.tblheaders = sprintf('tblId=%d <table class="sortable" id="anyid" border="1" >',htmlobj.tblId);
else    
    htmlobj.tblInfo{tblId}.tblheaders = sprintf('tblId=%d <table border="1" cellpadding="5" >',htmlobj.tblId);
end

htmlobj.tblInfo{tblId}.tblfooters = sprintf('</table>tblId=%d',htmlobj.tblId);
htmlobj.tblInfo{tblId}.numRows = 0;
htmlobj.tblInfo{tblId}.headerFlushed = 0;
htmlobj.tblInfo{tblId}.thFlush = 0;
htmlobj.tblInfo{tblId}.partWrite = 0;
htmlobj.tblInfo{tblId}.pageBreak = [];
htmlobj.tblInfo{tblId}.rowData = {};


end

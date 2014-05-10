%Author: Ishan Misra (ishan@cmu.edu)
%Date: Dec, 2013

function [htmlobj,tblId] = addRow(htmlobj,tblId,rowData,pageBreak)

htmlobj.tblInfo{tblId}.numRows = htmlobj.tblInfo{tblId}.numRows+1;
htmlobj.tblInfo{tblId}.rowData{htmlobj.tblInfo{tblId}.numRows} = rowData;
if(exist('pageBreak','var') && pageBreak==true) %works only for pagedTables
    htmlobj.tblInfo{tblId}.pageBreak =  [htmlobj.tblInfo{tblId}.pageBreak htmlobj.tblInfo{tblId}.numRows];
end

end

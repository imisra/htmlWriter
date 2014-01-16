%Author: Ishan Misra (ishan@cmu.edu)
%Date: Dec, 2013

function [htmlobj,tblId] = addRow(htmlobj,tblId,rowData,numCols)

htmlobj.tblInfo{tblId}.numRows = htmlobj.tblInfo{tblId}.numRows+1;
htmlobj.tblInfo{tblId}.rowData{htmlobj.tblInfo{tblId}.numRows} = rowData;

end

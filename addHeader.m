%Author: Ishan Misra (ishan@cmu.edu)
%Date: Dec, 2013

function [htmlobj,tblId] = addHeader(htmlobj,tblId,thData,numCols)

htmlobj.tblInfo{tblId}.thData = thData;

end

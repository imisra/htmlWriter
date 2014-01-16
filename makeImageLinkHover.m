%Author: Ishan Misra (ishan@cmu.edu)
%Date: Dec, 2013

function linkStr = makeImageLink(imgPath1,imgPath2,width,height,params)
if(~exist('params','var'))	
linkStr=sprintf('<a href="%s"><img src="%s" width=%d height=%d onmouseover="this.src=''%s''" onmouseout="this.src=''%s''" /></a>',imgPath1,imgPath1,width,height,imgPath2,imgPath1);
else
if(isfield(params,'bbox'))
linkStr=sprintf('<a href="%s"><img src="%s" width=%d height=%d /></a>',imgPath,imgPath,width,height);
end
end

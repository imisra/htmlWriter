%Author: Ishan Misra (ishan@cmu.edu)
%Date: Dec, 2013

function linkStr = makeImageLink(imgPath,width,height,altText,borderString)
if(~exist('altText','var'))
    linkStr=sprintf('<a href="%s"><img src="%s" width=%d height=%d /></a>',imgPath,imgPath,width,height);
else
    if(~exist('borderString','var'))
        linkStr=sprintf('<a href="%s"><img src="%s" width=%d height=%d Title="%s"/></a>',imgPath,imgPath,width,height,altText);
    else
        linkStr=sprintf('<a href="%s"><img src="%s" width=%d height=%d Title="%s" style="%s"/></a>',...
            imgPath,imgPath,width,height,altText,borderString);
    end
end

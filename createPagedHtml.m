%Author: Ishan Misra (ishan@cmu.edu)
%Date: Dec, 2013

function htmlobj = createPagedHtml(fname,params)

htmlobj = {};
if(~exist('params','var'))
	params.dummy=1;
end
if(~isfield(params,'numPerPage'))
    params.numPerPage = 50;
end 
if(~isfield(params,'pageLinkBreaks'))
    params.pageLinkBreaks = 10;
end      
%    htmlobj.fh = fopen(fname,'w');
    [dpath,baseName,~] = fileparts(fname);
    htmlobj.baseName = fullfile(dpath,baseName);
    htmlobj.base = baseName;
    htmlobj.pagedTable = true;
    htmlobj.numPerPage = params.numPerPage;
    htmlobj.pageLinkBreaks = params.pageLinkBreaks;
    htmlobj.lockfh = fopen([fname '.lock'],'w');    
    htmlobj.fname = fname;
    htmlobj.lockfname = [fname '.lock'];
    htmlobj.startTime = now;
    htmlobj.htmlHeaders = '<html>\n';
    if(isfield(params,'title'))
	title=params.title;
    else
    	title='';
    end
    if(isfield(params,'sortableTable') && params.sortableTable==true)

    htmlobj.sortableTable = true;

    if(isfield(params,'jspath'))
    	jspath = params.jspath;
    else
    	jspath = fullfile('/IUS/vmr104/imisra/research/redundant-exemplars/files/code/htmlWriter','sorttable.js');
    end

    htmlobj.htmlHeaders = [htmlobj.htmlHeaders ...
    sprintf('<head><script type="text/javascript" src="%s"></script>\n<title>%s</title></head>\n',jspath,title)];

    else
    htmlobj.htmlHeaders = [htmlobj.htmlHeaders sprintf('<head><title>%s</title></head>\n',title)];
    htmlobj.sortableTable = false;

    end
    htmlobj.htmlHeaders = [htmlobj.htmlHeaders ...
        sprintf('html file %s. started at %s<br/>\n',windowsPathEscape(htmlobj.fname),datestr(htmlobj.startTime))];
 
end

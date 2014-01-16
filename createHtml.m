%Author: Ishan Misra (ishan@cmu.edu)
%Date: Dec, 2013

function htmlobj = createHtml(fname,params)

htmlobj = {};
if(~exist('params','var'))
	params.dummy=1;
end

overWrite = isfield(params,'overWrite') && params.overWrite;

if(overWrite&& exist(fname,'file'))
	warning('createHtml- file exists. overwriting');
end
if(~overWrite && exist(fname,'file'))   
    warning('createHtml- file exists. creating another file');
    %basically append a number to fname and create that file
    [dirname,fname,ext] = fileparts(fname);
    nos = regexp(fname,'_[0-9]+');
    if(~isempty(nos) && nos>=1)
	nos = str2num(nos);
	fname = strrep(fname,sprintf('_%06d',nos),'');
	nos = nos + 1;
    else
    	nos = 1;
    end
    fname = sprintf('%s_%06d',fname,nos);
    fname = fullfile(dirname,[fname ext]);
end
    htmlobj.fh = fopen(fname,'w');
%    htmlobj.fh = 1;
    htmlobj.lockfh = fopen([fname '.lock'],'w');
    htmlobj.fname = fname;
    htmlobj.lockfname = [fname '.lock'];
    htmlobj.startTime = now;
    fprintf(htmlobj.fh,'<html>\n');
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
        %%CHANGE ME:: change the JS filepath to your local filesystem
    	jspath = fullfile('/IUS/vmr104/imisra/research/redundant-exemplars/files/code/htmlWriter','sorttable.js');
    end

    fprintf(htmlobj.fh,sprintf('<head><script type="text/javascript" src="%s"></script>\n<title>%s</title></head>\n',jspath,title));

    else
    fprintf(htmlobj.fh,sprintf('<head><title>%s</title></head>\n',title));
    htmlobj.sortableTable = false;

    end
    fprintf(htmlobj.fh,...
        sprintf('html file %s. started at %s<br/>\n',htmlobj.fname,datestr(htmlobj.startTime)));
 
end

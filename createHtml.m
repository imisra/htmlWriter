%Author: Ishan Misra (ishan@cmu.edu)
%Date: Dec, 2013

function htmlobj = createHtml(fname,params)

htmlobj = {};
if(~exist('params','var'))
	params.dummy=1;
end

overWrite = isfield(params,'overWrite') && params.overWrite;


jsImAspResize = ['function myImgAspResize(ele,maxWidth,maxHeight) {\n' ...
'var srcWidth = ele.naturalWidth;\n' ...
'var srcHeight = ele.naturalHeight;\n' ...
'var ratio = Math.min(maxWidth / srcWidth, maxHeight / srcHeight);\n' ...	
'ele.width = srcWidth*ratio;\n' ...
'ele.height = srcHeight*ratio;\n}\n'];

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
    fprintf(htmlobj.fh,jsImAspResize);
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
    	jspath = fullfile('./htmlWriter','sorttable.js');
    end
	fprintf(htmlobj.fh,sprintf('<head><title>%s</title>\n',title));
	fprintf(htmlobj.fh,'<script type="text/javascript" src="%s"></script>\n',jspath);
	fprintf(htmlobj.fh,'<script>\n');	
	fprintf(htmlobj.fh,jsImAspResize);
	fprintf(htmlobj.fh,'</script>\n</head>\n');

    %fprintf(htmlobj.fh,sprintf('<head><script type="text/javascript" src="%s"></script>\n<title>%s</title></head>\n',jspath,title));
    else
    fprintf(htmlobj.fh,sprintf('<head><title>%s</title>\n',title));
	fprintf(htmlobj.fh,'<script>\n');
	fprintf(htmlobj.fh,jsImAspResize);
	fprintf(htmlobj.fh,'</script>\n</head>\n');
    htmlobj.sortableTable = false;

    end
    fprintf(htmlobj.fh,...
        sprintf('html file %s. started at %s<br/>\n',windowsPathEscape(htmlobj.fname),datestr(htmlobj.startTime)));
 
end

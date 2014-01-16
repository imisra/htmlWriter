%Author: Ishan Misra (ishan@cmu.edu)
%Date: Dec, 2013

function htmlobj = endHtml(htmlobj)

if(isfield(htmlobj,'pagedTable'))
    return ;
end    

htmlobj.endTime = now;
fprintf(htmlobj.fh,...
        sprintf('\n<br/>html file %s. ended at %s<br/>\n</html>',htmlobj.fname,datestr(htmlobj.endTime)));

try    
fclose(htmlobj.fh);
fclose(htmlobj.lockfh);
delete(htmlobj.lockfname);
catch
    fprintf('some issues fclosing. too lazy to fix\n');
end
htmlobj.fh = -1;
htmlobj.lockfh = -1;

end

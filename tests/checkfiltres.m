function checkfiltres(filein, fileout)



fout = fopen(fileout);

pdattype = fread(fout, 1, 'uint32');
numlen = fread(fout, 1, 'uint32');
num = fread_array(fout, [1,numlen], pdattype);
denumlen = fread(fout, 1, 'uint32');
denum = fread_array(fout, [1,denumlen], pdattype);

datouttype = fread(fout, 1, 'uint32');
nchannout = fread(fout, 1, 'uint32');
datout = fread_array(fout, [nchannout, inf], datouttype);

fclose(fout);



fin = fopen(filein);

datintype = fread(fin, 1, 'uint32');
nchannin = fread(fin, 1, 'uint32');
datin = fread_array(fin, [nchannin, inf], datintype);

fclose(fin);


if (nchannin ~= nchannout)
    error('data params differs in the 2 files');
end



datmatlab = filter(num,denum,datin,[],2);


% for ichann=1:6:nchann
%     figure
%     plot(datout(ichann,:),'b')
%     hold on
%     plot(datmatlab(ichann,:),'r')
%    % plot(datmatlab(ichann,:),'g--')
%     hold off
%     axis([0 600 -2 2])
% end

diffval = abs(datmatlab - datout);
errvals = max(diffval,[],2) ./ max(abs(datmatlab),[],2);
errval = max(errvals);
fprintf('Error value = %10.10g\n',errval);
return;

function A = fread_array(fid, arrsize, typeval)
    type = '*float32';
    if bitand(typeval,1)
        type = '*float64';
    end
    
    c = 0;
    if bitand(typeval,2)
        c = 1;
        arrsize(1) = arrsize(1)*2;
    end
    
    A = fread(fid, arrsize, type);
    
    if c == 1
        A = A(1:2:end,:) + 1i*A(2:2:end,:);
    end
return
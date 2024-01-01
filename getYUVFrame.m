function [Y,U,V] = getYUVFrame(in_fid,resolution,yuvFormat,frameNum)
%a function that receives a yuv file id and reads the Y,U and V components
%of a frame belonging to the yuv file.

switch resolution
    case 'qcif'
        nrow = 144;
        ncol = 176;
    case 'cif'
        nrow = 288;
        ncol = 352;
    case '4cif'
        nrow = 576;
        ncol = 704;
    case '240p'
        nrow = 240;
        ncol = 416;
    case 'HD'%1080p (full HD)
        nrow = 1080;
        ncol = 1920;
end

switch yuvFormat
    case '420'
        ch_ncol = 0.5*ncol;
        ch_nrow = 0.5*nrow;
    case '422'
        ch_ncol = 0.5*ncol;
        ch_nrow = nrow;
    case '444'
        ch_ncol = ncol;
        ch_nrow = nrow;
    case '400'
        ch_ncol = 0;
        ch_nrow = 0;
end

% Seek to location
if ( frameNum > 1 )
    fseek(in_fid,(frameNum-1)*(nrow*ncol + 2*ch_ncol*ch_nrow),'bof');
end

% Now read Y, U, V components
Y = fread(in_fid, nrow * ncol, 'uchar');
Y = reshape(Y, ncol, nrow)';

U = fread(in_fid, ch_nrow*ch_ncol, 'uchar');
U = reshape(U, ch_ncol, ch_nrow)';

V = fread(in_fid, ch_nrow*ch_ncol, 'uchar');
V = reshape(V, ch_ncol, ch_nrow)';

end

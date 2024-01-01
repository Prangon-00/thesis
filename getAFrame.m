function [Y,U,V] = getAFrame(seqName,resolution,yuvFormat,frameNum)
%function that opens a yuv file, reads the Y, U and V components of a particular frame and after reading closes the file.

      in_fid = fopen(seqName,'rb'); %opens the file seqName in read mode and returns the file id.
      [Y,U,V] = getYUVFrame(in_fid,resolution,yuvFormat,frameNum);%file that does the actual reading
      fclose(in_fid);%closes the file
   
end
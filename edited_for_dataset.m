%script for reading a frame from a yuv sequence and display that frame
%------------- 240p Video Sequence -------------------------

clear;
clc;
%% Initialization...........
seqName = 'BasketballPass_416x240_50.yuv';
yuvFormat = '420';
blockSize = [64,64];
resolution = '240p';
[Y1,~,~] = getAFrame(seqName,resolution,yuvFormat,1);
[height,width] = size(Y1);
noOfBlocks = ceil(height/blockSize(1))*ceil(width/blockSize(2));

%% Showing the First 10 Video Frames from the YUV Video File
startFrame = 1;
frameGap = 1;
endFrame = 10;
extendedWidth = 64*ceil(width/64); % Padding to adapt multiple size of 64 Block
extendedHeight = 64*ceil(height/64); % Padding to adapt multiple size of 64 Block

dataset = cell(280, 2);
ctuCnt = 0;


for frameNum = startFrame:frameGap:endFrame
[F_c,~,~] = getAFrame(seqName,resolution,yuvFormat,frameNum);

F_c(:,width+1:extendedWidth) = 255; % Padding
F_c(height+1:extendedHeight,:) = 255; % Padding
CI1 = edge(F_c,'Canny'); %find the edge of current frame

[m,n] = size(CI1);
no_of_rows = floor(m/blockSize(1));
no_of_cols = floor(n/blockSize(2));

%ctu = zeros(64,64);

        for i = 1:no_of_rows
           r_start = (i-1)*64 + 1;
           r_end = i*64;
            for j = 1:no_of_cols
              c_start = (j-1)*64 + 1; 
              c_end = j*64;
              ctu = CI1(r_start:r_end,c_start:c_end);
              %figure;
              %imshow(ctu);
              title(['Block = ', num2str(ctuCnt)]);
              ctuCnt = ctuCnt+1;
              label = rem(ctuCnt,2);
              dataset{ctuCnt,1} =ctu;
              dataset{ctuCnt,2} =label;             
              
            
              
              
              
            end
        end
%disp(ctuCnt);
pause(0.5);
end
%save image into the .mat file
save('__image_with_label___.mat', 'dataset');

close all

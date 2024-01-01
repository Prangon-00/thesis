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
%Storing First 10 Frames in frameBuffer Variable.
frameBuffer = zeros(height, width, 10);
for frameNum = startFrame:frameGap:endFrame
[F_c,~,~] = getAFrame(seqName,resolution,yuvFormat,frameNum);
frameBuffer(:,:,frameNum) = F_c;
figure;
imshow(uint8(frameBuffer(:,:,frameNum)));
title(['POC = ', num2str(frameNum-1)]);
pause(0.5);
end


%% Showing the Edges of the Video Frames

% First Frame
[F_c,~,~] = getAFrame(seqName,resolution,yuvFormat,1); % Current Frame
CI1 = edge(F_c,'roberts');
figure;
imshow(CI1);

% Starting from Second Frame
startFrame = 2;
frameGap = 1;
endFrame = 10;
for frameNum = startFrame:frameGap:endFrame
[F_c,~,~] = getAFrame(seqName,resolution,yuvFormat,frameNum); % Current Frame
[F_r,~,~] = getAFrame(seqName,resolution,yuvFormat,frameNum-frameGap); % Reference Frame
F_e = F_c - F_r;
%F_e = F_c;
%CI1 = edge(F_e,'Canny');
%CI2 = edge(F_e,'Sobel');
CI3 = edge(F_e,'Roberts');
% Showing Edge of the Video Frames Using Various Edge Methods
figure;
%subplot(1,3,1)
%imshow(CI2);
%title('(Canny)');
%subplot(1,3,2)
%imshow(CI2);
%title('(Sobel)');
%subplot(1,3,3)
imshow(CI3);
title('(Roberts)');
end


%% ------- Testing and Saving the predictions of First Video Frame ------------------------
extendedWidth = 64*ceil(width/64); % Padding to adapt multiple size of 64 Block
extendedHeight = 64*ceil(height/64); % Padding to adapt multiple size of 64 Block

 %-------------- Saving preditions in file POC = 0 ---------------------    
    [F_c,~,~] = getAFrame(seqName,resolution,yuvFormat,1);
    F_c(:,width+1:extendedWidth) = 255; % Padding
    F_c(height+1:extendedHeight,:) = 255; % Padding
    F_e = F_c; % First Frame So no Reference (Intra)
    E_F_e = edge(F_e, 'Sobel'); 
    
    singleFramePredictions = doPredictions(E_F_e,blockSize); % Give the prediction of all blocks
   
    %-------------- Showing Predictions in figure ---------------------------
    F_m = F_c;
    F_m_rgb = cat(3, F_m, F_m, F_m);
        
        [m,n] = size(F_c);
        howmanyRows = floor(m/blockSize(1));
        howmanyCols = floor(n/blockSize(2));
        pr = singleFramePredictions(1,:);
        pr = reshape(pr, howmanyCols,howmanyRows)';

        ctuCnt = 0;
        for i = 1:howmanyRows
            row = (i-1)*blockSize(1) + 1;
            for j = 1:howmanyCols
              col = (j-1)*blockSize(2) + 1; 
              ctuCnt = ctuCnt+1;
              %disp(ctuCnt);
              
              if(pr(i,j) == 1)
                  F_m_rgb(row:row+blockSize(1)-1,col,1) = 255;
                  F_m_rgb(row:row+blockSize(1)-1,col,2) = 255;
                  F_m_rgb(row:row+blockSize(1)-1,col,3) = 255;
                  
                  F_m_rgb(row:row+blockSize(1)-1,col+blockSize(2)-1,1) = 255;
                  F_m_rgb(row:row+blockSize(1)-1,col+blockSize(2)-1,2) = 255;
                  F_m_rgb(row:row+blockSize(1)-1,col+blockSize(2)-1,3) = 255;
                  
                  F_m_rgb(row,col:col+blockSize(2)-1,1) = 255;
                  F_m_rgb(row,col:col+blockSize(2)-1,2) = 255;
                  F_m_rgb(row,col:col+blockSize(2)-1,3) = 255;
                  
                  F_m_rgb(row+blockSize(1)-1,col:col+blockSize(2)-1,1) = 255;
                  F_m_rgb(row+blockSize(1)-1,col:col+blockSize(2)-1,2) = 255;
                  F_m_rgb(row+blockSize(1)-1,col:col+blockSize(2)-1,3) = 255;
                  
                  % Drawing the Partitioning
                  F_m_rgb = predictionFigureFunction(F_m_rgb, singleFramePredictions, row, col, ctuCnt);
              end
            end
        end
     
        figure;   
        imshow(uint8(F_m_rgb),'InitialMagnification','fit');
        title(['Our Model Prediction of Frames, POC =  : ', num2str(0)]);
        
    %-------------- Saving the preditions in file ---------------------
        fileName = strcat('Prediction_BasketballPass_Sobel_POC_', num2str(0),'.txt');
        fileID = fopen(fileName,'w');
      
        singleFramePredictions = reshape(singleFramePredictions,21*noOfBlocks,1); 
        l = length(singleFramePredictions);
        for i = 1:l
               fprintf(fileID,'%d \n',singleFramePredictions(i)); 
        end
        fclose(fileID);
        

%% ------------ Testing and Saving the Video Frames From Frame 2 (POC = 1)
startFrame = 2;
frameGap = 1;
endFrame = 2;        
count = 1;
for frameNum = startFrame:frameGap:endFrame
    [F_c,~,~] = getAFrame(seqName,resolution,yuvFormat,frameNum);
    [F_r,~,~] = getAFrame(seqName,resolution,yuvFormat,frameNum-frameGap);
    % Padding
    F_c(:,width+1:extendedWidth) = 255;
    F_c(height+1:extendedHeight,:) = 255;
    F_r(:,width+1:extendedWidth) = 255;
    F_r(height+1:extendedHeight,:) = 255;
    F_e = F_c - F_r; % Error frame is calculated from current - reference frame 
    %F_e = F_c;
    E_F_e = edge(F_e, 'Sobel'); 
    
    singleFramePredictions = doPredictions(E_F_e,blockSize);
   
    %-------------- Showing Predictions in figure ---------------------------
    
    F_m = F_c;
    F_m_rgb = cat(3, F_m, F_m, F_m);
      
        % OUR Prediction
        [m,n] = size(F_c);
        howmanyRows = floor(m/blockSize(1));
        howmanyCols = floor(n/blockSize(2));
        pr = singleFramePredictions(1,:);
        pr = reshape(pr, howmanyCols,howmanyRows)';

        ctuCnt = 0;
        for i = 1:howmanyRows
            row = (i-1)*blockSize(1) + 1;
            for j = 1:howmanyCols
              col = (j-1)*blockSize(2) + 1; 
              ctuCnt = ctuCnt+1;
              %disp(ctuCnt);
              
              if(pr(i,j) == 1)
                  F_m_rgb(row:row+blockSize(1)-1,col,1) = 255;
                  F_m_rgb(row:row+blockSize(1)-1,col,2) = 255;
                  F_m_rgb(row:row+blockSize(1)-1,col,3) = 255;
                  
                  F_m_rgb(row:row+blockSize(1)-1,col+blockSize(2)-1,1) = 255;
                  F_m_rgb(row:row+blockSize(1)-1,col+blockSize(2)-1,2) = 255;
                  F_m_rgb(row:row+blockSize(1)-1,col+blockSize(2)-1,3) = 255;
                  
                  F_m_rgb(row,col:col+blockSize(2)-1,1) = 255;
                  F_m_rgb(row,col:col+blockSize(2)-1,2) = 255;
                  F_m_rgb(row,col:col+blockSize(2)-1,3) = 255;
                  
                  F_m_rgb(row+blockSize(1)-1,col:col+blockSize(2)-1,1) = 255;
                  F_m_rgb(row+blockSize(1)-1,col:col+blockSize(2)-1,2) = 255;
                  F_m_rgb(row+blockSize(1)-1,col:col+blockSize(2)-1,3) = 255;
                  
                  % Drawing the partitioning
                  F_m_rgb = predictionFigureFunction(F_m_rgb, singleFramePredictions, row, col, ctuCnt);
              end
            end
        end
     
        figure;   
        imshow(uint8(F_m_rgb),'InitialMagnification','fit');
        title(['Our Model Prediction of Frames, POC =  : ', num2str(frameNum-1)]);
    
    %-------------- Saving preditions in file ---------------------
        fileName = strcat('Prediction_BasketballPass_Sobel_POC_', num2str(frameNum-1),'.txt');
        fileID = fopen(fileName,'w');
        
        singleFramePredictions = reshape(singleFramePredictions,21*noOfBlocks,1); 
        l = length(singleFramePredictions);
        for i = 1:l
               fprintf(fileID,'%d \n',singleFramePredictions(i)); 
        end
        fclose(fileID);

end

  



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

% Starting from 1st Frame
startFrame = 1;
frameGap = 1;
endFrame = 10;
for frameNum = startFrame:frameGap:endFrame
[F_c,~,~] = getAFrame(seqName,resolution,yuvFormat,frameNum); % Current Frame
CI = edge(F_c,'Roberts');
% Showing Edge of the Video Frames Using Various Edge Methods
figure;
imshow(CI);
title('(Roberts)');
end

% Clear workspace and command window
clear;
clc;

% Initialize parameters
seqName = 'BasketballPass_416x240_50.yuv';
yuvFormat = '420';
resolution = '240p';
blockSize = [64, 64];

% Number of frames to process
numFrames = 10;

% Preallocate an array to store the padded frames
paddedFrames = cell(1, numFrames);

% Loop through the frames
for frameNum = 1:numFrames
    % Read the specified frame
    [F_c, ~, ~] = getAFrame(seqName, resolution, yuvFormat, frameNum);

    % Calculate the required padding dimensions
    extendedWidth = 64 * ceil(size(F_c, 2) / 64);
    extendedHeight = 64 * ceil(size(F_c, 1) / 64);

    % Create a padded frame
    paddedFrame = zeros(extendedHeight, extendedWidth);
    paddedFrame(1:size(F_c, 1), 1:size(F_c, 2)) = F_c;

    % Store the padded frame in the cell array
    paddedFrames{frameNum} = paddedFrame;
end

% Display the original frames and the padded frames
for frameNum = 1:numFrames
    originalFrame = paddedFrames{frameNum};
    
    % Display the original frame
    figure;
    imshow(uint8(originalFrame));
    title(['Original Frame - POC = ', num2str(frameNum - 1)]);
    
    % Display the padded frame
    figure;
    imshow(uint8(originalFrame));
    title(['Padded Frame - POC = ', num2str(frameNum - 1)]);
end


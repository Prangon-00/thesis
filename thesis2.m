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

% Preallocate a cell array to store the binary edge frames
edgeFrames = cell(1, numFrames);

% Loop through the frames to compute edge frames
for frameNum = 1:numFrames
    % Read the specified frame
    [F_c, ~, ~] = getAFrame(seqName, resolution, yuvFormat, frameNum);

    % Calculate the edge frame using the Roberts edge detection method
    edgeFrame = edge(F_c, 'Roberts');

    % Store the binary edge frame in the cell array
    edgeFrames{frameNum} = edgeFrame;
end

% Now that you have the binary edge frames in edgeFrames cell array, you can apply padding as follows:

% Calculate the required padding dimensions based on the first edge frame
extendedWidth = 64 * ceil(size(edgeFrames{1}, 2) / 64);
extendedHeight = 64 * ceil(size(edgeFrames{1}, 1) / 64);

% Preallocate a cell array to store the padded edge frames
paddedEdgeFrames = cell(1, numFrames);

% Loop through the edge frames and apply padding
for frameNum = 1:numFrames
    edgeFrame = edgeFrames{frameNum};
    
    % Create a padded edge frame
    paddedEdgeFrame = zeros(extendedHeight, extendedWidth);
    paddedEdgeFrame(1:size(edgeFrame, 1), 1:size(edgeFrame, 2)) = edgeFrame;
    
    % Store the padded edge frame in the cell array
    paddedEdgeFrames{frameNum} = paddedEdgeFrame;
end

% Display the original edge frames and the padded edge frames
for frameNum = 1:numFrames
    %originalEdgeFrame = edgeFrames{frameNum};
    paddedEdgeFrame = paddedEdgeFrames{frameNum};
    
    %Display the original edge frame
    %figure;
    %imshow(originalEdgeFrame);
    %title(['Original Edge Frame - Frame Number: ', num2str(frameNum)]);
    
    %Display the padded edge frame
    figure;
    imshow(paddedEdgeFrame);
    title(['Padded Edge Frame - Frame Number: ', num2str(frameNum)]);
end

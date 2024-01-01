% Clear workspace and command window
clear;
clc;

% Initialize parameters
seqName = 'BasketballPass_416x240_50.yuv';
yuvFormat = '420';
resolution = '240p';
blockSize = [64, 64];

% Number of frames to process
numFrames = 2;

% Preallocate a cell array to store the binary edge frames with padding
paddedEdgeFrames = cell(1, numFrames);

% Initialize the dataset as a single 280x2 cell array
dataset = cell(280, 2);
ctuCnt = 0;

% Loop through the frames to compute edge frames and apply padding
for frameNum = 1:numFrames
    % Read the specified frame
    [F_c, ~, ~] = getAFrame(seqName, resolution, yuvFormat, frameNum);

    % Calculate the edge frame using the Roberts edge detection method
    edgeFrame = edge(F_c, 'Roberts');
    
    % Calculate the required padding dimensions
    extendedWidth = 64 * ceil(size(edgeFrame, 2) / 64);
    extendedHeight = 64 * ceil(size(edgeFrame, 1) / 64);

    % Create a padded edge frame
    paddedEdgeFrame = zeros(extendedHeight, extendedWidth);
    paddedEdgeFrame(1:size(edgeFrame, 1), 1:size(edgeFrame, 2)) = edgeFrame;
    
    % Store the padded edge frame in the cell array
    paddedEdgeFrames{frameNum} = paddedEdgeFrame;
    
    % Calculate the number of rows and columns for 64x64 blocks in the padded frame
    numRows = extendedHeight / blockSize(1);
    numCols = extendedWidth / blockSize(2);
    
    % Loop through rows and columns to extract and save 64x64 blocks
    for row = 1:numRows
        for col = 1:numCols
            % Calculate the row and column indices for the current block
            rowIdx = (row - 1) * blockSize(1) + 1;
            colIdx = (col - 1) * blockSize(2) + 1;
            
            % Extract the 64x64 block from the padded edge frame
            block = paddedEdgeFrame(rowIdx:rowIdx + blockSize(1) - 1, colIdx:colIdx + blockSize(2) - 1);
            
            % Determine the value for the block (0 for odd, 1 for even)
            value = mod(row + col, 2);

            % Store the block and its value directly in the dataset
            ctuCnt = ctuCnt + 1;
            dataset{ctuCnt, 1} = block;
            dataset{ctuCnt, 2} = value;
        end
    end
end

% Save the combined data as a cell array in the .mat file
save('all_blocks_and_values.mat', 'dataset');
load all_blocks_and_values.mat;

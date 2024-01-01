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

% Preallocate a cell array to store the binary edge frames with padding
paddedEdgeFrames = cell(1, numFrames);

% Specify the path to your "Documents" folder
documentsFolderPath = fullfile(getenv('USERPROFILE'), 'Documents');

% Initialize arrays to store blocks and their values
allBlocks = cell(1, numFrames);
blockValues = cell(1, numFrames);

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
    
    % Initialize arrays to store blocks and their values
    blocks = cell(1, numRows * numCols);
    values = zeros(1, numRows * numCols);
    
    % Count the number of 64x64 blocks
    totalBlocks = 0;
    
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
            
            % Store the block and its value
            blocks{col + (row - 1) * numCols} = block;
            values(col + (row - 1) * numCols) = value;
            
            % Increment the count of 64x64 blocks
            totalBlocks = totalBlocks + 1;
        end
    end
    
    % Store all blocks and their values in cell arrays
    allBlocks{frameNum} = blocks;
    blockValues{frameNum} = values;
end

% Create a cell array to store the combined data
combinedData = cell(totalBlocks, 2);

% Fill the combined data with block data and values
blockIndex = 1;
for frameNum = 1:numFrames
    for i = 1:length(allBlocks{frameNum})
        combinedData{blockIndex, 1} = allBlocks{frameNum}{i};
        combinedData{blockIndex, 2} = blockValues{frameNum}(i);
        blockIndex = blockIndex + 1;
    end
end

% Save the combined data as a cell array in the .mat file
save(fullfile(documentsFolderPath, 'all_blocks_and_values.mat'), 'combinedData');

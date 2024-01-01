 % Calculate the Mean Squared Error (MSE) between the block and actualBlock
            mse = mean((block(:) - actualBlock(:)).^2);

            % Set a threshold for considering the blocks as matched
            threshold = 0.01;  % You can adjust this threshold as needed
            if mse < threshold
                fprintf('Block %d of frame %d matches the actual image block (MSE = %f).\n', col + (row - 1) * numCols, frameNum, mse);
            else
                fprintf('Block %d of frame %d does not match the actual image block (MSE = %f).\n', col + (row - 1) * numCols, frameNum, mse);
            end
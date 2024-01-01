%   Detailed explanation goes here

%---- Input : errImage and BlockSize --------
%---- Output : Return the E_T ( EnergyBundle) of a single Frame---------

function  singleFramePredictions = doPredictions(errImage, blockSize)

        [height,width]=size(errImage);
        noOfBlocks = floor(height/blockSize(1))*floor(width/blockSize(2));
         % Vector

        singleFramePredictions = zeros(21,noOfBlocks);
        increment1 = blockSize(1,1);
        increment2 = blockSize(1,2);
        errImage = (errImage.^1);
         
         
         k = 1;
         for a = 1:increment1:height - increment1 + 1
            for b = 1:increment2:width - increment2 + 1
                sprintf('a = %d, b = %d, k = %d\n', a, b, k);
                oneCTUPredictions = zeros(1,21);
                
                % Energy Caluclation (One CTU)
                CTU_D_0 = errImage(a:a+increment1 - 1,b:b+increment2 - 1);
                size(CTU_D_0);
                totalSum = sum(sum(CTU_D_0));
                %disp(totalSum);
                if(totalSum > 1) 
                   % Calling at Depth 0
                   oneCTUPredictions = CUs_D_1(CTU_D_0,a,b);
                   oneCTUPredictions = oneCTUPredictions'; % Convert into column Vector
                end
                singleFramePredictions(:,k) = oneCTUPredictions;
                k = k + 1;
            end
         end
         %singleFramePredictions = reshape(singleFramePredictions,21*noOfBlocks,1);  
end


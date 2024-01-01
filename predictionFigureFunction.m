function F_m_rgb = predictionFigureFunction(F_m_rgb, singleFramePredictions, row, col, ctuCnt)
    for it = row:1:row+64-1    % 32*32
        F_m_rgb(it,col+32-1,1) = 255;
        F_m_rgb(it,col+32-1,2) = 0;
        F_m_rgb(it,col+32-1,3) = 0;
    end
    
    for it = col:1:col+64-1
        F_m_rgb(row+32-1,it,1) = 255;
        F_m_rgb(row+32-1,it,2) = 0;
        F_m_rgb(row+32-1,it,3) = 0;
    end
 
    
    if(singleFramePredictions(2,ctuCnt) == 1) % 16*16
        row1 = row;
        col1 = col;
        
        for it = row1:1:row1+32-1
            F_m_rgb(it,col1+16-1,1) = 0;
            F_m_rgb(it,col1+16-1,2) = 255;
            F_m_rgb(it,col1+16-1,3) = 0;
        end
        for it = col1:1:col1+32-1
            F_m_rgb(row1+16-1,it,1) = 0;
            F_m_rgb(row1+16-1,it,2) = 255;
            F_m_rgb(row1+16-1,it,3) = 0;
        end
        
        
        if(singleFramePredictions(6,ctuCnt) == 1)   % 8*8
            row2 = row1;
            col2 = col1;
            for it = row2:1:row2+16-1
                F_m_rgb(it,col2+8-1,1) = 0;
                F_m_rgb(it,col2+8-1,2) = 0;
                F_m_rgb(it,col2+8-1,3) = 255;
            end
            for it = col2:1:col2+16-1
                F_m_rgb(row2+8-1,it,1) = 0;
                F_m_rgb(row2+8-1,it,2) = 0;
                F_m_rgb(row2+8-1,it,3) = 255;
            end
        end
        
        if(singleFramePredictions(7,ctuCnt) == 1)   % 8*8
            row2 = row1;
            col2 = col1+16;
            for it = row2:1:row2+16-1
                F_m_rgb(it,col2+8-1,1) = 0;
                F_m_rgb(it,col2+8-1,2) = 0;
                F_m_rgb(it,col2+8-1,3) = 255;
            end
            for it = col2:1:col2+16-1
                F_m_rgb(row2+8-1,it,1) = 0;
                F_m_rgb(row2+8-1,it,2) = 0;
                F_m_rgb(row2+8-1,it,3) = 255;
            end
        end
        
        if(singleFramePredictions(10,ctuCnt) == 1)  % 8*8
            row2 = row1+16;
            col2 = col1;
            for it = row2:1:row2+16-1
                F_m_rgb(it,col2+8-1,1) = 0;
                F_m_rgb(it,col2+8-1,2) = 0;
                F_m_rgb(it,col2+8-1,3) = 255;
            end
            for it = col2:1:col2+16-1
                F_m_rgb(row2+8-1,it,1) = 0;
                F_m_rgb(row2+8-1,it,2) = 0;
                F_m_rgb(row2+8-1,it,3) = 255;
            end
        end
        
        if(singleFramePredictions(11,ctuCnt) == 1)  % 8*8
            row2 = row1+16;
            col2 = col1+16;
            for it = row2:1:row2+16-1
                F_m_rgb(it,col2+8-1,1) = 0;
                F_m_rgb(it,col2+8-1,2) = 0;
                F_m_rgb(it,col2+8-1,3) = 255;
            end
            for it = col2:1:col2+16-1
                F_m_rgb(row2+8-1,it,1) = 0;
                F_m_rgb(row2+8-1,it,2) = 0;
                F_m_rgb(row2+8-1,it,3) = 255;
            end
        end
    end
    
    %---------------------------------------------------
    if(singleFramePredictions(3,ctuCnt) == 1) % 16*16
        row1 = row;
        col1 = col+32;

        for it = row1:1:row1+32-1
            F_m_rgb(it,col1+16-1,1) = 0;
            F_m_rgb(it,col1+16-1,2) = 255;
            F_m_rgb(it,col1+16-1,3) = 0;
        end
        for it = col1:1:col1+32-1
            F_m_rgb(row1+16-1,it,1) = 0;
            F_m_rgb(row1+16-1,it,2) = 255;
            F_m_rgb(row1+16-1,it,3) = 0;
        end
        
        if(singleFramePredictions(8,ctuCnt) == 1)   % 8*8
            row2 = row1;
            col2 = col1;
            for it = row2:1:row2+16-1
                F_m_rgb(it,col2+8-1,1) = 0;
                F_m_rgb(it,col2+8-1,2) = 0;
                F_m_rgb(it,col2+8-1,3) = 255;
            end
            for it = col2:1:col2+16-1
                F_m_rgb(row2+8-1,it,1) = 0;
                F_m_rgb(row2+8-1,it,2) = 0;
                F_m_rgb(row2+8-1,it,3) = 255;
            end
        end
        
        if(singleFramePredictions(9,ctuCnt) == 1)   % 8*8
            row2 = row1;
            col2 = col1+16;
            for it = row2:1:row2+16-1
                F_m_rgb(it,col2+8-1,1) = 0;
                F_m_rgb(it,col2+8-1,2) = 0;
                F_m_rgb(it,col2+8-1,3) = 255;
            end
            for it = col2:1:col2+16-1
                F_m_rgb(row2+8-1,it,1) = 0;
                F_m_rgb(row2+8-1,it,2) = 0;
                F_m_rgb(row2+8-1,it,3) = 255;
            end
        end
        
        if(singleFramePredictions(12,ctuCnt) == 1)  % 8*8
            row2 = row1+16;
            col2 = col1;
            for it = row2:1:row2+16-1
                F_m_rgb(it,col2+8-1,1) = 0;
                F_m_rgb(it,col2+8-1,2) = 0;
                F_m_rgb(it,col2+8-1,3) = 255;
            end
            for it = col2:1:col2+16-1
                F_m_rgb(row2+8-1,it,1) = 0;
                F_m_rgb(row2+8-1,it,2) = 0;
                F_m_rgb(row2+8-1,it,3) = 255;
            end
        end
        
        if(singleFramePredictions(13,ctuCnt) == 1)  % 8*8
            row2 = row1+16;
            col2 = col1+16;
            for it = row2:1:row2+16-1
                F_m_rgb(it,col2+8-1,1) = 0;
                F_m_rgb(it,col2+8-1,2) = 0;
                F_m_rgb(it,col2+8-1,3) = 255;
            end
            for it = col2:1:col2+16-1
                F_m_rgb(row2+8-1,it,1) = 0;
                F_m_rgb(row2+8-1,it,2) = 0;
                F_m_rgb(row2+8-1,it,3) = 255;
            end
        end
    end
    
    %------------------------------------------------------------      
    if(singleFramePredictions(4,ctuCnt) == 1)  % 16*16
        row1 = row+32;
        col1 = col;

        for it = row1:1:row1+32-1
            F_m_rgb(it,col1+16-1,1) = 0;
            F_m_rgb(it,col1+16-1,2) = 255;
            F_m_rgb(it,col1+16-1,3) = 0;
        end
        for it = col1:1:col1+32-1
            F_m_rgb(row1+16-1,it,1) = 0;
            F_m_rgb(row1+16-1,it,2) = 255;
            F_m_rgb(row1+16-1,it,3) = 0;
        end
        
        if(singleFramePredictions(14,ctuCnt) == 1)  % 8*8
            row2 = row1;
            col2 = col1;
            for it = row2:1:row2+16-1
                F_m_rgb(it,col2+8-1,1) = 0;
                F_m_rgb(it,col2+8-1,2) = 0;
                F_m_rgb(it,col2+8-1,3) = 255;
            end
            for it = col2:1:col2+16-1
                F_m_rgb(row2+8-1,it,1) = 0;
                F_m_rgb(row2+8-1,it,2) = 0;
                F_m_rgb(row2+8-1,it,3) = 255;
            end
        end
        
        if(singleFramePredictions(15,ctuCnt) == 1)  % 8*8
            row2 = row1;
            col2 = col1+16;
            for it = row2:1:row2+16-1
                F_m_rgb(it,col2+8-1,1) = 0;
                F_m_rgb(it,col2+8-1,2) = 0;
                F_m_rgb(it,col2+8-1,3) = 255;
            end
            for it = col2:1:col2+16-1
                F_m_rgb(row2+8-1,it,1) = 0;
                F_m_rgb(row2+8-1,it,2) = 0;
                F_m_rgb(row2+8-1,it,3) = 255;
            end
        end
        
        if(singleFramePredictions(18,ctuCnt) == 1)  % 8*8
            row2 = row1+16;
            col2 = col1;
            for it = row2:1:row2+16-1
                F_m_rgb(it,col2+8-1,1) = 0;
                F_m_rgb(it,col2+8-1,2) = 0;
                F_m_rgb(it,col2+8-1,3) = 255;
            end
            for it = col2:1:col2+16-1
                F_m_rgb(row2+8-1,it,1) = 0;
                F_m_rgb(row2+8-1,it,2) = 0;
                F_m_rgb(row2+8-1,it,3) = 255;
            end
        end
        
        if(singleFramePredictions(19,ctuCnt) == 1)  % 8*8
            row2 = row1+16;
            col2 = col1+16;
            for it = row2:1:row2+16-1
                F_m_rgb(it,col2+8-1,1) = 0;
                F_m_rgb(it,col2+8-1,2) = 0;
                F_m_rgb(it,col2+8-1,3) = 255;
            end
            for it = col2:1:col2+16-1
                F_m_rgb(row2+8-1,it,1) = 0;
                F_m_rgb(row2+8-1,it,2) = 0;
                F_m_rgb(row2+8-1,it,3) = 255;
            end
        end
    end
    
    %------------------------------------------------------
    
    if(singleFramePredictions(5,ctuCnt) == 1)   % 16*16
        row1 = row+32;
        col1 = col+32;

        for it = row1:1:row1+32-1
            F_m_rgb(it,col1+16-1,1) = 0;
            F_m_rgb(it,col1+16-1,2) = 255;
            F_m_rgb(it,col1+16-1,3) = 0;
        end
        for it = col1:1:col1+32-1
            F_m_rgb(row1+16-1,it,1) = 0;
            F_m_rgb(row1+16-1,it,2) = 255;
            F_m_rgb(row1+16-1,it,3) = 0;
        end
        
        if(singleFramePredictions(16,ctuCnt) == 1)  % 8*8
            row2 = row1;
            col2 = col1;
            for it = row2:1:row2+16-1
                F_m_rgb(it,col2+8-1,1) = 0;
                F_m_rgb(it,col2+8-1,2) = 0;
                F_m_rgb(it,col2+8-1,3) = 255;
            end
            for it = col2:1:col2+16-1
                F_m_rgb(row2+8-1,it,1) = 0;
                F_m_rgb(row2+8-1,it,2) = 0;
                F_m_rgb(row2+8-1,it,3) = 255;
            end
        end
        
        if(singleFramePredictions(17,ctuCnt) == 1)  % 8*8
            row2 = row1;
            col2 = col1+16;
            for it = row2:1:row2+16-1
                F_m_rgb(it,col2+8-1,1) = 0;
                F_m_rgb(it,col2+8-1,2) = 0;
                F_m_rgb(it,col2+8-1,3) = 255;
            end
            for it = col2:1:col2+16-1
                F_m_rgb(row2+8-1,it,1) = 0;
                F_m_rgb(row2+8-1,it,2) = 0;
                F_m_rgb(row2+8-1,it,3) = 255;
            end
        end
        
        if(singleFramePredictions(20,ctuCnt) == 1)  % 8*8
            row2 = row1+16;
            col2 = col1;
            for it = row2:1:row2+16-1
                F_m_rgb(it,col2+8-1,1) = 0;
                F_m_rgb(it,col2+8-1,2) = 0;
                F_m_rgb(it,col2+8-1,3) = 255;
            end
            for it = col2:1:col2+16-1
                F_m_rgb(row2+8-1,it,1) = 0;
                F_m_rgb(row2+8-1,it,2) = 0;
                F_m_rgb(row2+8-1,it,3) = 255;
            end
        end
        
        if(singleFramePredictions(21,ctuCnt) == 1)  % 8*8
            row2 = row1+16;
            col2 = col1+16;
            for it = row2:1:row2+16-1
                F_m_rgb(it,col2+8-1,1) = 0;
                F_m_rgb(it,col2+8-1,2) = 0;
                F_m_rgb(it,col2+8-1,3) = 255;
            end
            for it = col2:1:col2+16-1
                F_m_rgb(row2+8-1,it,1) = 0;
                F_m_rgb(row2+8-1,it,2) = 0;
                F_m_rgb(row2+8-1,it,3) = 255;
            end
        end
    end
end
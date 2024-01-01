function w = CUs_D_2(CU_D_1,p,q)
    
    w = zeros(1,4);
    p = 1; q = 1;
    %----- 1 No. CU -----
    m = p; n = q;
    size(CU_D_1);
    CU1_D_2 = CU_D_1(m:m+15, n:n+15);
    size(CU1_D_2);
    totalSum = sum(sum(CU1_D_2));
    if(totalSum > 1)
        % Decision at Depth 2
        w(1) = 1;
    end
    
    %----- 2 No. CU -----
    m = p; n = q+16;
    CU2_D_2 = CU_D_1(m:m+15, n:n+15);
    totalSum = sum(sum(CU2_D_2));
    if(totalSum > 1)
        % Decision at Depth 2
        w(2) = 1;
    end
    
    %----- 3 No. CU -----
    m = p+16; n = q;
    CU3_D_2 = CU_D_1(m:m+15, n:n+15);
    totalSum = sum(sum(CU3_D_2));
    if(totalSum > 1)
        % Decision at Depth 2
        w(3) = 1;
    end
    
    %----- 4 No. CU (D = 1) -----
    m = p + 16; n = q + 16;
    CU4_D_2 = CU_D_1(m:m+15, n:n+15);
    totalSum = sum(sum(CU4_D_2));
    if(totalSum > 1)
        % Decision at Depth 2
        w(4) = 1;
    end

end


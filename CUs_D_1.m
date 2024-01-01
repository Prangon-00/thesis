function v = CUs_D_1(CTU_D_0,a,b)
    
    a = 1; b = 1;
    v = zeros(1,21); % Creating 1 by 21 size vector
    v(1) = 1; % 64 by 64 block is partitioned
    %----- 1 No. CU -----
    p = a; q = b;
    CU1_D_1 = CTU_D_0(p:p+31, q:q+31);
    size(CU1_D_1);
    totalSum = sum(sum(CU1_D_1));
    if(totalSum > 1)
        % Decision at Depth 1
        v(2) = 1; % 1st 32 by 32 block is partitioned
        decision = CUs_D_2(CU1_D_1,p,q);
        v([6:7,10:11]) = decision;
    end
    
    %----- 2 No. CU -----
    p = a; q = b + 32;
    CU2_D_1 = CTU_D_0(p:p+31, q:q+31);
    size(CU2_D_1);
    totalSum = sum(sum(CU2_D_1));
    if(totalSum > 1)
        % Decision at Depth 1
        v(3) = 1; % 2nd 32 by 32 block is partitioned
        decision = CUs_D_2(CU2_D_1,p,q);
        v([8:9,12:13]) = decision;
    end
    
    %----- 3 No. CU -----
    p = a + 32; q = b;
    CU3_D_1 = CTU_D_0(p:p+31, q:q+31);
    size(CU3_D_1);
    totalSum = sum(sum(CU3_D_1));
    if(totalSum > 1)
        % Decision at Depth 1
        v(4) = 1; % 3rd 32 by 32 block is partitioned
        decision = CUs_D_2(CU3_D_1,p,q);
        v([14:15,18:19]) = decision;
    end
    
    %----- 4 No. CU (D = 1) -----
    p = a+32; q = b+32;
    CU4_D_1 = CTU_D_0(p:p+31, q:q+31);
    size(CU4_D_1);
    totalSum = sum(sum(CU4_D_1));
    if(totalSum > 1)
        % Decision at Depth 1
        v(5) = 1; % 4th 32 by 32 block is partitioned
        decision = CUs_D_2(CU4_D_1,p,q);
        v([16:17,20:21]) = decision;
    end

end


clear all;

N = 3; %antenna number

K_seq = 95:1:100
feasibility_ratio = 95:1:100
K_index = 0
gamma_dB = -15; %SINR / dB

for K=95:1:100 %user number
    
    K
    K_index = K_index + 1;
    ok_num = 0;
    for test=1:20

        H = []; %initialize H matrix

        for i=1:K
            h = 1/sqrt(2*K)*mvnrnd(zeros(N,1),eye(N),1)'+1i/sqrt(2*K)*mvnrnd(zeros(N,1),eye(N),1)';
            H = [H h];
        end

        H = H';

        gamma = db2mag(2*gamma_dB);

        [feasible,Wsolution] = HW_TEST2(H,gamma);
        ok_num = ok_num + feasible;
    end
    feasibility_ratio(K_index) = ok_num / 20.0
end
plot(K_seq,feasibility_ratio)
grid on
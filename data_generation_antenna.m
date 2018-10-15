clear all;

K = 100; %antenna number

N_seq = 7:1:12
feasibility_ratio = 7:1:12
N_index = 0
gamma_dB = -10; %SINR / dB

for N=7:1:12 %user number
    
    N
    N_index = N_index + 1;
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
    feasibility_ratio(N_index) = ok_num / 20.0
end
plot(N_seq,feasibility_ratio)
grid on
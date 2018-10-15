clear all;

K = 50; %user number
N = 3; %antenna number

gamma_dB_Seq = -13:0.5:-11
feasibility_ratio = -13:0.5:-11
gamma_index = 0

for gamma_dB=-13:0.5:-11
    gamma_dB
    gamma_index = gamma_index + 1;
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
    feasibility_ratio(gamma_index) = ok_num / 20.0
end
plot(gamma_dB_Seq,feasibility_ratio)
grid on
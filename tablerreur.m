function  [e]=tablerreur(N_1,N_2,N_3,N_4,N_5)
e=[erreure_max(N_1) erreure_max(N_2) erreure_max(N_3) erreure_max(N_4) erreure_max(N_5);erreure_h(N_1) erreure_h(N_2) erreure_h(N_3) erreure_h(N_4) erreure_h(N_5)];

plot(e(1,:),'r'),hold on,plot(e(2,:),'g'),legend('e_max','e_h')
end
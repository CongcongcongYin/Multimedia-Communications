Packet_loss=[0.0529,0.1046,0.1510,0.2056];
SGM=[0.7164,0.5715,0.4567,0.3679];
Bernoulli=[0.3490,0.2139,0.1489,0.1222];
 
plot(Packet_loss,SGM,Packet_loss,Bernoulli);
grid on;
title('resulting DFRs');
xlabel('Packet loss rate');
ylabel('Decodable frame rate');
legend('SGM','Bernoulli Model');
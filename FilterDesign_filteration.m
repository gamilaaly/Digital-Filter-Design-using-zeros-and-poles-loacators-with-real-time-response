clc;
clear all;
[file,filename]= uigetfile('*.csv;*.xls;*.xlsx');
signal= xlsread([filename,file]);
plot(signal)

%insertion of Fmax from gui and mapping it from 0 to pi
Fsampling=150; % elmafrod byegy ka input mn el gui
Frequency= linspace(0,Fsampling./2,315);
%unit circle vector sabet fe kolo
theta = 0:0.01:pi;
theta=transpose(theta);
z_coordinate=ones(315,1);
x=z_coordinate.*sin(theta);
y=z_coordinate.*cos(theta);
z_coordinate=x+y*i;
%brsm el |H(z)| ely hwa el gain versus mapped freq
zeros=[1]; % lazem column vector 3shan zp2tf
poles=[0];
%get tf from from zeros and poles matlab
[num_coeff,den_coeff]=zp2tf(zeros,poles,1);
Polynomial_tf= tf(num_coeff,den_coeff);
for k =1:length(z_coordinate)
   gain(k)=evalfr(Polynomial_tf,z_coordinate(k));
   gain=gain(:);
end
 figure
plot (Frequency,gain)


% filter function
filtered_signal = filter(num_coeff,den_coeff,signal) ;
figure 
plot(filtered_signal)

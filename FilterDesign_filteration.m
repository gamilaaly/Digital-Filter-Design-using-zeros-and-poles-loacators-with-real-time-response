clc;
clear all;
[file,filename]= uigetfile('*.csv;*.xls;*.xlsx');
signal= xlsread([filename,file]);
plot(signal)
%insertion of Fmax from gui and mapping it from 0 to pi
Fmax=150; % mslun
%unit circle vector sabet fe kolo
theta = 0:0.01:pi;
%theta=transpose(theta);
z_coordinate=ones(629);
z_coordinate=z_coordinate(:,1);
x=z_coordinate*sin(theta);
x=x(:,1);
y=z_coordinate*cos(theta);
y=y(:,1);
z_coordinate=x+y*i;
%brsm el |H(z)| ely hwa el gain versus mapped freq
zeros=[0.5 ; 2; -.5]; % lazem column vector 3shan zp2tf
poles=[2; -.7];
%get tf from from zeros and poles matlab
[num_coeff,den_coeff]=zp2tf(zeros,poles,1);
Polynomial_tf= tf(num_coeff,den_coeff);
for k =1:length(z_coordinate)
   gain(k)=evalfr(Polynomial_tf,z_coordinate(k));
   gain=gain(:)
end
figure
plot (gain,frequency)


% filter function
filtered_signal = filter(num_coeff,den_coeff,signal) ;
figure 
plot(filtered_signal)

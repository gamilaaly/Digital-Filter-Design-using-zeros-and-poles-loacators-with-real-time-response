clc;
clear all;
[file,filename]= uigetfile('*.csv;*.xls;*.xlsx');
signal= xlsread([filename,file]);
plot(signal)

%insertion of Fsampling from gui and mapping it from 0 to pi
Fsampling=150; % elmafrod byegy ka input mn el gui mn editline
Frequency= linspace(0,Fsampling./2,315);

%unit circle vector sabet fe kolo (manual and built-in)
theta = 0:0.01:pi;
theta=transpose(theta);
z_coordinate=ones(315,1);
x=z_coordinate.*cos(theta);
y=z_coordinate.*sin(theta);
z_coordinate=x+y*i;
% dol el 2 arrays ely  gayeen mn goz2 eman 
zeros=[-1]; % lazem column vector 3shan zp2tf
poles=[0];
%get tf from from zeros and poles matlab
[num_coeff,den_coeff]=zp2tf(zeros,poles,1); % 1 dah kan k 
%mn awel hena da el built-in gain
% Polynomial_tf= tf(num_coeff,den_coeff);
% for k =1:length(z_coordinate)
%    substitution_in_tf(k)=evalfr(Polynomial_tf,z_coordinate(k));
%    substitution_in_tf=substitution_in_tf(:);
%    gain_matlab=20*log10(substitution_in_tf); % to get mag of tf
% end
[gain_matlab,phase_resp]=freqz(num_coeff,den_coeff,315);
gain_matlab=20*log10(abs(gain_matlab));
figure
plot (Frequency,gain_matlab)



%hena dah el manual gain
distance=ones(315,1);
for i=1:length(z_coordinate)
    for j=1:length(zeros)        
      distance(i)= distance(i)*norm(z_coordinate(i)- zeros(j));  
    end
end

for i=1:length(z_coordinate)
   
    for j=1:length(poles)       
      distance(i)= distance(i)*(1./norm(z_coordinate(i)- poles(j)));
    end
end
manual_gain=20*log(abs(distance));
figure 
plot(Frequency, manual_gain);

% filter function sbta fe kolo
filtered_signal = filter(num_coeff,den_coeff,signal) ;
figure 
plot(filtered_signal)

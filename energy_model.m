close;
clear;
clc;
ftsz = 16;
%import the data
data =  importdata('data_to_build_energy_model.txt');

% extract time and energy columns 
time = data(:,2)/1000; %converting milseconds to seconds
energy = data(:,4);

% remove outliers
outliers =  abs( median( time ) - time ) > 3 * std(time) ;
time(outliers, :) = [] ; 
energy(outliers, :) = [] ; 
% outliers = energy <= 0.1
% time(outliers, :) = [] ; 
% energy(outliers, :) = [] ; 
%  outliers = time < 1
%  time(outliers, :) = [] ; 
%  energy(outliers, :) = [] ;


p = polyfit(time,energy,1)
a= p(1)
b=p(2)

% computing the mean square error to validate the results of regression 
simulated_energy=a*time+b;
err=sqrt(mean((energy-simulated_energy).^2))

% plot
%figure('Position',[440 378 560 620/3]);
plot(time,energy,'r.')
hold on;
plot(time,simulated_energy,'Linewidth',3)
set(gca , 'FontSize', ftsz);
set(gca , 'xTick', 0:3:max(time)+1);
set(gca , 'yTick', 0:3:max(energy)+1);
xlabel('time (sec)');
ylabel('Energy (Joule)')


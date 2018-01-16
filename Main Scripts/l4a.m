function l4a
close all;
clear all;
clc;
% Extracting dataset and labels
inp_data = dlmread('data.txt');
inp_labels = dlmread('label.txt');

% k = 10
[A, acc_A] =calc_kmean(inp_data, inp_labels, 10)
dlmwrite('K_10.txt', A,'delimiter','\t','precision',8);
dlmwrite('K_10.txt', acc_A, '-append');

% k = 15
[B, acc_B] =calc_kmean(inp_data, inp_labels, 15)
dlmwrite('K_15.txt', B,'delimiter','\t','precision',8);
dlmwrite('K_15.txt', acc_B,'delimiter','\t','precision',8, '-append');

% k = 5
[C, acc_C] =calc_kmean(inp_data, inp_labels, 5)
dlmwrite('K_5.txt', C,'delimiter','\t','precision',8);
dlmwrite('K_5.txt', acc_C,'delimiter','\t','precision',8, '-append');
end
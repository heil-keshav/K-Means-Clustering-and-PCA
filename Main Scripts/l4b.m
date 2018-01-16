function l4b
close all;
clear all;
clc;
%directory containing dataset
inp_data = dlmread('data.txt');

%Standardize
[N,D] = size(inp_data);
% N = No. of images or instances
% D = 400 pixels or Dimensions/Features
X = inp_data;
X_mean = mean(inp_data);
for i=1:N
    X(i,:) = X(i,:) - X_mean(1,:);
end

% Covariance Matrix
sigma = (X'*X)/N;
[U,S,V] = svd(sigma);

% Dimensions of U is DxD
% Pick k columns of U such that reconst error is <0.1
for k=1:D
    U_trial = U(:,1:k);
    Z = X*U_trial;
    X_trial = Z*U_trial';
    
    % Calculate error
    sq_err =0;
    for i=1:N
        for j=1:D
            sq_err = sq_err + (X(i,j) - X_trial(i,j))^2;
        end
    end
    %sq_err = norm(X-X_trial)^2;
    err = sq_err/N;
    fprintf('%f K is %d\n', err, k);
    if err < 0.1
        fprintf('Number of components = %d\n', k);
        break;
    end

end

% X for lower dimension k
U_final = U(:,1:k);
X_new = X*U_final;
dlmwrite('data_low_dim.txt',X_new);
inp_labels = dlmread('label.txt');

% Visualization of 2 dimension and 3 dimension

x1 = vec2mat(U(:,1),20);
figure, imshow(x1)
x2 = vec2mat(U(:,3),20);
figure, imshow(x2)
x3 = vec2mat(U(:,5),20);
figure, imshow(x3)


X = U(:,1);
Y = U(:,2);
Z = U(:,3);
figure
scatter3(X,Y,Z)

X = U(:,4);
Y = U(:,5);
Z = U(:,6);
figure
scatter3(X,Y,Z)

end

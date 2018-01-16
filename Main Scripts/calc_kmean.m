function [Conf_mat, Classification_accuracy] = calc_kmean(inp_data, inp_labels, kval)

Digits = 10;
predicted_cluster = kmeans(inp_data, kval);
x = [inp_labels predicted_cluster];
[m,n] =size(x);

% A is a 10x10 matrix
% Rows represent cluster number
% Columns represent the counts of the digit value
A = zeros(kval,Digits);
for i=1:m
    j = x(i,Digits+1);
    for k = 1:Digits
        if x(i,k)==1
            A(j,k) = A(j,k) + 1;
        end
    end
    
end

% Predicting label of the clusters = Digit having max count (in all the 10 (Digits) columns)
for i=1:kval
    max = A(i,1);
    digit_val = 0;
    for j=2:Digits
        if A(i,j) > max
            max = A(i,j);
            digit_val = j-1;
        end
    end
    P_label(i,1) = digit_val;
end

% Generating Confusion matrix
Conf_mat = zeros(10,10);
for i=1:kval
    j = P_label(i,1);
    Conf_mat(j+1,:) = Conf_mat(j+1,:) + A(i,:);
end

% Calculating classification accuracy
sum =0;
for i=1:10
    sum = sum + Conf_mat(i,i);
end
Classification_accuracy = sum/m;
end
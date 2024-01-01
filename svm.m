% Load the dataset from a .mat file
%load('image_with_label.mat', 'image_with_label');
load('image_with_label.mat');
% Assign the loaded dataset to a single variable
%myDataset = image_with_label;

% Define the percentage splits
train_percentage = 0.8;
verify_percentage = 0.1;
test_percentage = 0.1;

% Determine the number of data points
total_samples = size(dataset, 1);

% Generate random indices for each split using 'datasample'
train_indices = datasample(1:total_samples, round(train_percentage * total_samples), 'Replace', false);
remaining_indices = setdiff(1:total_samples, train_indices);

verify_indices = datasample(remaining_indices, round(verify_percentage * total_samples), 'Replace', false);
test_indices = setdiff(remaining_indices, verify_indices);

% Create 'train', 'verify', and 'test' variables
train = dataset(train_indices, :);
verify = dataset(verify_indices, :);
test = dataset(test_indices, :);

% View the contents of 'train', 'verify', and 'test'
disp('Train Set:');
disp(train);
disp('Verify Set:');
disp(verify);
disp('Test Set:');
disp(test);





% Load the dataset from a .mat file
load('image_with_label.mat');

% Define the common feature dimension
common_feature_dimension = [64, 64]; % Specify the desired size

% Define the percentage splits
train_percentage = 0.8;
validation_percentage = 0.1;
test_percentage = 0.1;

% Determine the number of data points
total_samples = size(dataset, 1);

% Generate random indices for each split
train_indices = datasample(1:total_samples, round(train_percentage * total_samples), 'Replace', false);
remaining_indices = setdiff(1:total_samples, train_indices);

validation_indices = datasample(remaining_indices, round(validation_percentage * total_samples), 'Replace', false);
test_indices = setdiff(remaining_indices, validation_indices);

% Create 'train', 'validation', and 'test' datasets
train = dataset(train_indices, :);
validation = dataset(validation_indices, :);
test = dataset(test_indices, :);

% Extract features and labels for training data
train_data = train(:, 1);
train_labels = cell2mat(train(:, 2));

% Resize smaller images to the common feature dimension and pad larger images for training
train_data_resized = cellfun(@(img) padarray(imresize(img, common_feature_dimension), max(0, common_feature_dimension - size(img)), 0, 'post'), train_data, 'UniformOutput', false);

% Flatten and convert images to feature vectors for training
num_features = common_feature_dimension(1) * common_feature_dimension(2);
train_features = zeros(length(train_data_resized), num_features);

for i = 1:length(train_data_resized)
    train_features(i, :) = train_data_resized{i}(:)';
end

% Extract features and labels for validation data
validation_data = validation(:, 1);
validation_labels = cell2mat(validation(:, 2));

% Resize smaller images to the common feature dimension and pad larger images for validation
validation_data_resized = cellfun(@(img) padarray(imresize(img, common_feature_dimension), max(0, common_feature_dimension - size(img)), 0, 'post'), validation_data, 'UniformOutput', false);

% Flatten and convert images to feature vectors for validation
validation_features = zeros(length(validation_data_resized), num_features);

for i = 1:length(validation_data_resized)
    validation_features(i, :) = validation_data_resized{i}(:)';
end

% Extract features and labels for test data
test_data = test(:, 1);
test_labels = cell2mat(test(:, 2));

% Resize smaller images to the common feature dimension and pad larger images for test data
test_data_resized = cellfun(@(img) padarray(imresize(img, common_feature_dimension), max(0, common_feature_dimension - size(img)), 0, 'post'), test_data, 'UniformOutput', false);

% Flatten and convert images to feature vectors for test data
test_features = zeros(length(test_data_resized), num_features);

for i = 1:length(test_data_resized)
    test_features(i, :) = test_data_resized{i}(:)';
end

% Define SVM options (you can customize these)
svm_options = templateSVM('KernelFunction', 'linear', 'Standardize', true);

% Train the SVM classifier on the training set
svm_model = fitcecoc(train_features, train_labels, 'Learners', svm_options);

% Predict on the validation set
validation_predictions = predict(svm_model, validation_features);

% Evaluate the accuracy on the validation set
validation_accuracy = sum(validation_labels == validation_predictions) / length(validation_labels);

fprintf('Validation Accuracy: %.2f%%\n', validation_accuracy * 100);

% Predict on the test set
test_predictions = predict(svm_model, test_features);

% Evaluate the accuracy on the test set
test_accuracy = sum(test_labels == test_predictions) / length(test_labels);

fprintf('Test Accuracy: %.2f%%\n', test_accuracy * 100);

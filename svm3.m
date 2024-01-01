% Load the dataset from a .mat file
load('image_with_label.mat'); % Assuming your dataset is in 'image_with_label.mat'

% Define the percentage splits
train_percentage = 0.8;
validation_percentage = 0.1; % Validation (hyperparameter tuning) percentage
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

% Extract features (64x64 image blocks) and labels
train_data = train(:, 1); % First column contains 64x64 image blocks
train_labels = cell2mat(train(:, 2)); % Second column contains labels

% Flatten and convert images to feature vectors
train_features = cellfun(@(img) img(:)', train_data, 'UniformOutput', false);
train_features = cell2mat(train_features);

% Define SVM options (you can customize these)
svm_options = templateSVM('KernelFunction', 'linear', 'Standardize', true);

% Train the SVM classifier on the training set
svm_model = fitcecoc(train_features, train_labels, 'Learners', svm_options);

% Extract validation data and labels
validation_data = validation(:, 1);
validation_labels = cell2mat(validation(:, 2));

% Flatten and convert validation images to feature vectors
validation_features = cellfun(@(img) img(:)', validation_data, 'UniformOutput', false);
validation_features = cell2mat(validation_features);

% Predict on the validation set
validation_predictions = predict(svm_model, validation_features);

% Evaluate the accuracy on the validation set
validation_accuracy = sum(validation_labels == validation_predictions) / length(validation_labels);

fprintf('Validation Accuracy: %.2f%%\n', validation_accuracy * 100);

% Extract test data and labels (similar to validation)
test_data = test(:, 1);
test_labels = cell2mat(test(:, 2));

% Flatten and convert test images to feature vectors (similar to validation)
test_features = cellfun(@(img) img(:)', test_data, 'UniformOutput', false);
test_features = cell2mat(test_features);

% Predict on the test set
test_predictions = predict(svm_model, test_features);

% Evaluate the accuracy on the test set
test_accuracy = sum(test_labels == test_predictions) / length(test_labels);

fprintf('Test Accuracy: %.2f%%\n', test_accuracy * 100);

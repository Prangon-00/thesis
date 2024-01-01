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

% Resize images for training, validation, and test datasets
datasets = {train, validation, test};

for d = 1:length(datasets)
    data = datasets{d}(:, 1);
    labels = cell2mat(datasets{d}(:, 2));

    data_resized = cellfun(@(img) ...
        imresize(img, common_feature_dimension), ...
        data, 'UniformOutput', false);

    num_features = common_feature_dimension(1) * common_feature_dimension(2);
    features = zeros(length(data_resized), num_features);

    for i = 1:length(data_resized)
        features(i, :) = data_resized{i}(:)';
    end

    if d == 1
        train_features = features;
        train_labels = labels;
    elseif d == 2
        validation_features = features;
        validation_labels = labels;
    else
        test_features = features;
        test_labels = labels;
    end
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

fprintf('Test Predictions:\n');
disp(test_predictions);  % Print the test prediction results

fprintf('Actual Test Labels:\n');
disp(test_labels);  % Print the actual test labels

% Evaluate the accuracy on the test set
test_accuracy = sum(test_labels == test_predictions) / length(test_labels);

fprintf('Test Accuracy: %.2f%%\n', test_accuracy * 100);

load fisheriris;

data = meas;         % Features
labels = species;    % Labels

% Define the percentage splits
train_percentage = 0.8;
validation_percentage = 0.1;
test_percentage = 0.1;

% Generate random indices for each split
total_samples = size(data, 1);
train_indices = datasample(1:total_samples, round(train_percentage * total_samples), 'Replace', false);
remaining_indices = setdiff(1:total_samples, train_indices);

validation_indices = datasample(remaining_indices, round(validation_percentage * total_samples), 'Replace', false);
test_indices = setdiff(remaining_indices, validation_indices);

% Create 'train', 'validation', and 'test' datasets
train_data = data(train_indices, :);
validation_data = data(validation_indices, :);
test_data = data(test_indices, :);

train_labels = labels(train_indices);
validation_labels = labels(validation_indices);
test_labels = labels(test_indices);

% Create cell arrays for the feature data
train_data = num2cell(train_data, 2);
validation_data = num2cell(validation_data, 2);
test_data = num2cell(test_data, 2);

% Resize images (features) for training, validation, and test datasets
datasets = {train_data, validation_data, test_data};
dataset_labels = {train_labels, validation_labels, test_labels};

for d = 1:length(datasets)
    data = datasets{d};
    labels = dataset_labels{d}; % Use the appropriate labels

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
    elseif d == 2
        validation_features = features;
    else
        test_features = features;
    end
end

% Define SVM options (you can customize these)
svm_options = templateSVM('KernelFunction', 'linear', 'Standardize', true);

% Train the SVM classifier on the training set
svm_model = fitcecoc(train_features, train_labels, 'Learners', svm_options);

% Predict on the validation set
validation_predictions = predict(svm_model, validation_features);

% Calculate the accuracy on the validation set
correctly_classified = sum(cellfun(@(x, y) strcmp(x, y), validation_labels, validation_predictions));
validation_accuracy = correctly_classified / length(validation_labels);

fprintf('Validation Accuracy: %.2f%%\n', validation_accuracy * 100);

% Predict on the test set
test_predictions = predict(svm_model, test_features);

fprintf('Test Predictions:\n');
disp(test_predictions);  % Print the test prediction results

fprintf('Actual Test Labels:\n');
disp(test_labels);  % Print the actual test labels

% Calculate the accuracy on the test set
correctly_classified = sum(cellfun(@(x, y) strcmp(x, y), test_labels, test_predictions));
test_accuracy = correctly_classified / length(test_labels);

fprintf('Test Accuracy: %.2f%%\n', test_accuracy * 100);

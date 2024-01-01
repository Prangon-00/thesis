% Load the Digits dataset as in-memory numeric arrays
[XTrain, YTrain, ~] = digitTrain4DArrayData;
[XTest, YTest, ~] = digitTest4DArrayData;

% Combine the data into one array
XCombined = cat(4, XTrain, XTest);
YCombined = cat(1, YTrain, YTest);

% Determine the number of data points
num_samples = size(XCombined, 4);

% Define the percentages
train_percentage = 0.8;
validation_percentage = 0.1;
test_percentage = 0.1;

% Calculate the number of samples for each split
num_train_samples = round(train_percentage * num_samples);
num_validation_samples = round(validation_percentage * num_samples);
num_test_samples = num_samples - num_train_samples - num_validation_samples;

% Create random indices for splitting
indices = randperm(num_samples);

% Split the data into training, validation, and test sets
train_indices = indices(1:num_train_samples);
validation_indices = indices(num_train_samples + 1:num_train_samples + num_validation_samples);
test_indices = indices(num_train_samples + num_validation_samples + 1:end);

% Extract the corresponding data and labels for each split
XTrain = XCombined(:, :, 1, train_indices);
YTrain = YCombined(train_indices);

XValidation = XCombined(:, :, 1, validation_indices);
YValidation = YCombined(validation_indices);

XTest = XCombined(:, :, 1, test_indices);
YTest = YCombined(test_indices);

% Reshape and preprocess the data
num_features = size(XCombined, 1) * size(XCombined, 2);

train_features = reshape(XTrain, num_features, num_train_samples)';
validation_features = reshape(XValidation, num_features, num_validation_samples)';
test_features = reshape(XTest, num_features, num_test_samples)';

% Define SVM options (you can customize these)
svm_options = templateSVM('KernelFunction', 'linear', 'Standardize', true);

% Train the SVM classifier on the training set
svm_model = fitcecoc(train_features, YTrain, 'Learners', svm_options);

% Predict on the validation set
validation_predictions = predict(svm_model, validation_features);

% Evaluate the accuracy on the validation set
validation_accuracy = sum(YValidation == validation_predictions) / numel(YValidation);

fprintf('Validation Accuracy: %.2f%%\n', validation_accuracy * 100);

% Predict on the test set
test_predictions = predict(svm_model, test_features);

% Evaluate the accuracy on the test set
test_accuracy = sum(YTest == test_predictions) / numel(YTest);

fprintf('Test Accuracy: %.2f%%\n', test_accuracy * 100);

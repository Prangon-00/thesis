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

% Reshape the data for CNN input (assuming grayscale images)
train_features = reshape(train_features, [size(train_features, 1), common_feature_dimension(1), common_feature_dimension(2), 1]);
validation_features = reshape(validation_features, [size(validation_features, 1), common_feature_dimension(1), common_feature_dimension(2), 1]);
test_features = reshape(test_features, [size(test_features, 1), common_feature_dimension(1), common_feature_dimension(2), 1]);

% Define and create a simple CNN model for binary classification
layers = [
    imageInputLayer([common_feature_dimension(1), common_feature_dimension(2), 1])
    convolution2dLayer(3, 16, 'Padding', 'same')
    reluLayer
    maxPooling2dLayer(2, 'Stride', 2)
    convolution2dLayer(3, 32, 'Padding', 'same')
    reluLayer
    maxPooling2dLayer(2, 'Stride', 2)
    fullyConnectedLayer(2) % 2 classes (0 and 1) for binary classification
    softmaxLayer
    classificationLayer
];

options = trainingOptions('sgdm', ...
    'MaxEpochs', 10, ...
    'MiniBatchSize', 64, ...
    'ValidationData', {validation_features, categorical(validation_labels)}, ...
    'ValidationFrequency', 50, ...
    'Verbose', true, ...
    'Plots', 'training-progress');

% Train the CNN model
net = trainNetwork(train_features, categorical(train_labels), layers, options);

% Evaluate the model on the test dataset
testPred = classify(net, test_features);
testAcc = sum(testPred == categorical(test_labels)) / numel(test_labels);
disp(['Test accuracy: ' num2str(testAcc)]);

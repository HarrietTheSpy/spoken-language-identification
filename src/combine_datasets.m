% Combine Spoken Language Feature Datasets
% Loads per-language feature datasets, concatenates the extracted
% features and labels, and saves a single combined dataset.

langs = ["Arabic", "English", "Mandarin", "Japanese", "Spanish", "Tamil"];
combinedFeatures = [];
combinedLabels = [];
combinedFilenames = [];

for i = 1:length(langs)
    % Convert string to character vector for the filename
    data = load(char("spoken_language_dataset_" + lower(langs(i)) + ".mat"));
    
    % Append data
    combinedFeatures = [combinedFeatures; data.features];
    combinedLabels = [combinedLabels; data.labels];
    combinedFilenames = [combinedFilenames; data.filenames];
end

% Save combined dataset
save('spoken_language_dataset_all.mat', 'combinedFeatures', 'combinedLabels', 'combinedFilenames');
fprintf("Combined dataset saved as spoken_language_dataset_all.mat with %d entries.\n", size(combinedFeatures, 1));

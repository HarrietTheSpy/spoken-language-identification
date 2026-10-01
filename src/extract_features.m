% Spoken Language Feature Extraction Script (Batch Version)
% ----------------------------------------------------------
% This script processes all .wav files in subfolders of a given root folder.
% It extracts MFCC + delta + delta-delta features, mean-pools them,
% and saves a dataset of features, labels, and filenames to .mat.

clc; clear;

%% Root folder and output
dataRoot = 'data';
outputFile = 'spoken_language_dataset.mat';
addpath(genpath(dataRoot));  % Make sure subfolders are accessible

%% Initialize storage
features = [];
labels = [];
filenames = [];

%% Get language folder names
langs = dir(dataRoot);
langs = langs([langs.isdir] & ~startsWith({langs.name}, '.'));
langNames = {langs.name};
fprintf("Found %d language folders.\n", numel(langNames));

%% Process each language folder
totalFiles = 0;
for i = 1:numel(langNames)
    lang = langNames{i};
    langPath = fullfile(dataRoot, lang);

    % Check for exactly one subfolder (e.g., data/Arabic/Arabic)
    subdirs = dir(langPath);
    subdirs = subdirs([subdirs.isdir] & ~startsWith({subdirs.name}, '.'));
    if numel(subdirs) == 1
        langPath = fullfile(langPath, subdirs(1).name);
    end

    % Find all .wav files recursively
    audioFiles = dir(fullfile(langPath, '**', '*.wav'));
    fprintf("Processing %s (%d files)...\n", lang, numel(audioFiles));

    for j = 1:length(audioFiles)
        try
            % Construct full file path
            filePath = fullfile(audioFiles(j).folder, audioFiles(j).name);
            [y, fs] = audioread(filePath);

			% Standardize audio to 16 kHz
			targetFs = 16000;

			if fs ~= targetFs
				y = resample(y, targetFs, fs);
  				fs = targetFs;
			end

            % Extract MFCCs
            coeffs = mfcc(y, fs, 'NumCoeffs', 13);

            % Compute delta and delta-delta
            deltas = diff([coeffs(1,:); coeffs], 1, 1);
            deltaDeltas = diff([deltas(1,:); deltas], 1, 1);

            % Mean-pool features to fixed-length vector
            featureVector = mean(coeffs); 
            featureVector = [featureVector, mean(deltas), mean(deltaDeltas)];
            featureVector = featureVector(:)';  % 1 x 39

            % Store results
            features = [features; featureVector];
            labels = [labels; string(lang)];
            filenames = [filenames; string(audioFiles(j).name)];

            totalFiles = totalFiles + 1;
            if mod(totalFiles, 50) == 0
                fprintf("Processed %d files...\n", totalFiles);
            end

        catch ME
            fprintf("Skipped file (error): %s - %s\n", audioFiles(j).name, ME.message);
            continue;
        end
    end
end

%% Summary
fprintf("\n Finished processing.\n");
fprintf(" Total files: %d\n", totalFiles);
fprintf(" Feature size: %d x %d\n", size(features));
fprintf(" Labels: %d\n", numel(labels));
if ~isempty(labels)
    fprintf("Unique langs: %s\n", strjoin(unique(labels), ', '));
else
    fprintf("Unique langs: [none found]\n");
end

%% Save to .mat file
save(outputFile, 'features', 'labels', 'filenames');
fprintf("Saved dataset to '%s'\n", outputFile);

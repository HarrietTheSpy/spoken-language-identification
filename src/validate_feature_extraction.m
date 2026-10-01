% Select one language folder for validation
lang = 'Arabic';
langPath = fullfile('data', lang);

% Grab the first .wav file
audioFiles = dir(fullfile(langPath, '*.wav'));
if isempty(audioFiles)
    error('No .wav files found in %s', langPath);
end

filePath = fullfile(langPath, audioFiles(1).name);
fprintf('Testing with: %s\n', filePath);

% Read audio
[y, fs] = audioread(filePath);

% Standardize audio to 16 kHz
targetFs = 16000;

if fs ~= targetFs
    y = resample(y, targetFs, fs);
    fs = targetFs;
end

% Extract MFCCs
coeffs = mfcc(y, fs, 'NumCoeffs', 13);

% Compute deltas
deltas = diff([coeffs(1,:); coeffs], 1, 1);
deltadeltas = diff([deltas(1,:); deltas], 1, 1);

% Combine features (mean-pooling over time)
featureVector = [mean(coeffs); mean(deltas); mean(deltadeltas)];
featureVector = featureVector(:)';  % row vector

% Save to .mat file for inspection
save('test_features.mat', 'featureVector', 'lang');
fprintf('Feature extraction complete. Saved to test_features.mat\n');

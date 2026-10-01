# spoken-language-identification
Spoken language identification using MFCC acoustic features and classical machine learning classifiers in MATLAB.

A machine learning system for identifying spoken languages from raw
speech recordings using Mel-Frequency Cepstral Coefficients (MFCCs)
and classical classification algorithms.

The project evaluates how well Support Vector Machines (SVM),
K-Nearest Neighbors (KNN), and Decision Trees can distinguish between
multiple spoken languages as classification complexity increases.

## Overview

The system processes raw multilingual speech recordings from the
Mozilla Common Voice dataset and predicts the spoken language contained
in each audio sample.

The complete processing pipeline consists of:

1. Audio preprocessing
2. Sampling-rate standardization
3. MFCC-based feature extraction
4. Feature normalization
5. Supervised classifier training
6. Hyperparameter tuning
7. Model evaluation
8. Confusion-matrix and precision-recall analysis

## Languages

The system was evaluated using six languages:

- English
- Spanish
- Mandarin Chinese
- Arabic
- Tamil
- Japanese

These languages were selected to provide substantial acoustic,
phonological, and rhythmic diversity.

## Signal Processing Pipeline

Audio recordings were standardized to:

- 16 kHz sampling frequency
- Mono channel
- Short-time analysis using approximately 25 ms frames
- 10 ms frame shift

Acoustic features were extracted using Mel-Frequency Cepstral
Coefficients.

The feature representation included:

- 13 MFCC coefficients
- First-order temporal derivatives (Delta)
- Second-order temporal derivatives (Delta-Delta)
- Energy-related features

The resulting representation captures both spectral characteristics
and short-term temporal behavior of speech.

## Machine Learning Models

Three supervised classification approaches were evaluated.

### Support Vector Machine

A multiclass SVM was implemented using MATLAB's Error-Correcting
Output Codes framework.

MATLAB:

```matlab
fitcecoc()

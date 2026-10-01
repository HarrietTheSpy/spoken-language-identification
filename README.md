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

Each audio recording was standardized before feature extraction to ensure consistent processing across speakers, languages, and recording conditions.

The preprocessing pipeline included:

- Resampling audio to a 16 kHz sampling frequency
- Converting recordings to a mono channel
- Segmenting speech using approximately 25 ms analysis frames
- Applying a 10 ms frame shift between consecutive frames

Mel-Frequency Cepstral Coefficients (MFCCs) were then extracted to represent the spectral characteristics of the speech signal.

The feature representation included:

- 13 MFCC coefficients
- First-order temporal derivatives (Delta)
- Second-order temporal derivatives (Delta-Delta)
- Energy-related features

These features capture both the short-term spectral content of speech and its temporal variation, providing the classifiers with information related to pronunciation, rhythm, and acoustic structure.

## Machine Learning Models

Three supervised classification models were implemented and compared to evaluate how different learning strategies handled multilingual acoustic features.

### Support Vector Machine

A multiclass Support Vector Machine was implemented using MATLAB's Error-Correcting Output Codes (ECOC) framework:

```matlab
fitcecoc()
```

The SVM was selected because it performs well in high-dimensional feature spaces and can create robust decision boundaries between classes with overlapping acoustic characteristics.

The regularization parameter was tuned to balance margin size and classification error.

### K-Nearest Neighbors

K-Nearest Neighbors was implemented using:

```matlab
fitcknn()
```

KNN classifies a sample based on the labels of nearby training examples in the feature space.

The number of neighbors, `k`, was varied to study the tradeoff between sensitivity to local acoustic patterns and overall generalization.

### Decision Tree

The Decision Tree classifier was implemented using:

```matlab
fitctree()
```

Decision Trees provide an interpretable rule-based classification structure that makes it possible to examine how acoustic features contribute to classification decisions.

Tree complexity was varied to evaluate the tradeoff between model flexibility, interpretability, and overfitting.

Complete machine learning models section

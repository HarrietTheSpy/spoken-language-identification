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

## Experimental Design

Classifier performance was evaluated under increasing classification complexity using three language-set configurations:

- **Two-language classification:** English and Mandarin
- **Three-language classification:** English, Mandarin, and Spanish
- **Six-language classification:** English, Spanish, Mandarin, Arabic, Tamil, and Japanese

Additional experiments examined how performance changed with:

- Number of target languages
- Training dataset size
- Classifier hyperparameters
- Acoustic variability across speakers and recordings

This experimental structure made it possible to evaluate both model accuracy and how well each classifier scaled as the classification task became more complex.

## Evaluation

Model performance was evaluated using multiple metrics to capture both overall accuracy and class-specific behavior.

The evaluation included:

- Classification accuracy
- Confusion matrices
- Precision-recall analysis
- Class-specific error analysis

Performance was compared across the two-, three-, and six-language experiments to examine how each classifier responded as the number of target classes increased.

Confusion matrices were used to identify which language pairs were most frequently misclassified, while precision-recall analysis provided additional insight into class-specific performance.

## Results and Key Findings

The experiments showed that classification performance generally decreased as the number of target languages increased, reflecting greater overlap between acoustic feature distributions in the multiclass setting.

Key observations included:

- **SVM** performed particularly well on the two-language classification task and produced strong class separation in several multiclass experiments.
- **KNN** benefited substantially from increased training data, as additional samples provided more representative local neighborhoods for classification.
- **Decision Trees** generally achieved lower classification performance than SVM and KNN but provided greater interpretability through their rule-based structure.
- Misclassification increased as additional languages were introduced, particularly where languages shared similar acoustic or phonetic characteristics.
- Increasing training data generally improved classifier performance, although the amount of improvement varied by model.

These results highlight the tradeoff between classification accuracy, scalability, model complexity, and interpretability when using classical machine learning methods for spoken language identification.

## Technologies and Tools

This project was implemented primarily in MATLAB using the following tools and libraries:

- MATLAB
- Audio Toolbox
- Signal Processing Toolbox
- Statistics and Machine Learning Toolbox
- Mozilla Common Voice Dataset

Core technical areas included:

- Digital signal processing
- Speech processing
- Feature engineering
- Supervised machine learning
- Multiclass classification
- Hyperparameter tuning
- Model evaluation
- Data preprocessing

## Project Structure

The repository is organized to separate preprocessing, model training, experimentation, results, and supporting documentation.

```text
spoken-language-identification/
├── README.md
├── LICENSE
├── .gitignore
├── src/
├── experiments/
├── results/
├── docs/
└── data/
```
## Data

Speech recordings for this project were obtained from the Mozilla Common Voice dataset.

The repository does not include the full raw audio dataset because of its size. Instead, the project is designed so that the dataset can be downloaded separately and processed using the preprocessing pipeline included in the repository.

The selected languages were:

- English
- Spanish
- Mandarin Chinese
- Arabic
- Tamil
- Japanese

All audio samples used in the experiments were standardized to a 16 kHz sampling rate and converted to mono before feature extraction.

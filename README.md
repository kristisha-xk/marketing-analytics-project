# marketing analytics project
SQL, Python, and Power BI project focused on funnel analysis, RFM segmentation, personalization, and marketing attribution.

---

## Project Overview

This project combines SQL analytics, Python-based data analysis, and BI visualization to analyze user behavior and customer conversion across different acquisition channels.

The workflow included:

- data extraction and transformation;
- sales funnel analysis;
- CTR / CVR / ER metrics calculation;
- RFM customer segmentation;
- personalization analysis;
- marketing attribution modeling;
- dashboard creation in Power BI;
- preparation of a final analytical report.

---

# Tech Stack

## SQL
Used for data extraction, aggregation, and analytical calculations.

### Implemented analyses:
- sales funnel analysis;
- CTR (Click-Through Rate) calculation;
- CVR (Conversion Rate) calculation;
- ER (Engagement Rate) analysis;
- RFM segmentation;
- channel performance analysis;
- user activity aggregation.

### SQL techniques used:
- CTEs;
- window functions;
- CASE statements;
- JOIN operations;
- aggregation functions.

---

## Python

Python was used for advanced analytical modeling, personalization systems, probabilistic attribution, and customer journey analysis.

Data was extracted directly from MS SQL Server using SQLAlchemy and processed with pandas and NumPy for large-scale analytical transformations.

### Personalization & Recommendation System

Built a recommendation engine for ad targeting based on user interests and behavioral scoring.

### Implemented logic:
- TF-IDF vectorization of user interests and ad targeting categories;
- cosine similarity matching between users and advertisements;
- weighted recommendation ranking using RFM-based behavioral scores;
- personalized Top-N ad recommendation generation;
- customer prioritization using engagement and recency metrics.

### Machine Learning / NLP techniques:
- TF-IDF vectorization;
- cosine similarity;
- text normalization and preprocessing;
- ranking algorithms;
- feature weighting.

---

### Marketing Attribution Modeling

Developed a multi-model attribution framework for evaluating marketing channel contribution across customer conversion journeys.

### Attribution models implemented:
- Last-Touch Attribution;
- Linear Attribution;
- Time-Decay Attribution;
- Position-Based Attribution;
- Markov Chain Attribution Model.

### Customer journey analysis included:
- event sequence reconstruction;
- conversion path building;
- transition probability calculation;
- path weighting and contribution analysis;
- non-converted user path modeling.

### Probabilistic & Simulation Modeling

Implemented a Markov-chain-based attribution system with Monte Carlo simulation for estimating channel importance.

### Advanced modeling techniques:
- transition matrix construction;
- absorbing Markov chains;
- removal effect analysis;
- Monte Carlo conversion simulation;
- probabilistic channel contribution estimation.

### Statistical / analytical methods:
- path probability normalization;
- transition redistribution after channel removal;
- weighted conversion estimation;
- temporal decay weighting.

### Python libraries used:
- pandas
- numpy
- scikit-learn
- SQLAlchemy
- matplotlib
- collections
- random

---

## Power BI Dashboard

Interactive dashboard was developed in Power BI for business monitoring and KPI tracking.

### Dashboard includes:
- total user actions overview:
  - clicks
  - likes
  - purchases
  - other engagement actions
- sales funnel visualization;
- RFM customer segmentation;
- share of buyers among all users by acquisition channel.

---

## Final Report

### Executive Summary
The main issue lies at the monetization stage rather than traffic acquisition.

Advertising campaigns demonstrate high efficiency at the top of the funnel:
- high CTR,
- high Engagement Rate,
- stable user engagement,
- effective targeting and creatives.

However:
- there is a significant drop-off between the Like and Purchase stages,
- Instagram generates engagement but fails to convert users into buyers,
- Facebook drives higher-quality commercial traffic,
- customer loyalty remains weak across both platforms.

### Key Finding
Advertising successfully attracts user attention, but the product, landing page, and purchase flow fail to convert users into customers.

#  SwiftKey Pro: Bilingual Next-Word Predictor
### High-Performance NLP Web Application | English & German Support

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Shiny](https://img.shields.io/badge/Shiny-Live_App-1a5276)](https://altamashali.shinyapps.io/bilingual-swiftkey-nlp/)
[![R](https://img.shields.io/badge/R-4.3.0%2B-blue)](https://www.r-project.org/)

SwiftKey Pro is a professional text prediction tool that suggests the most likely next word in a sequence. Developed as a capstone project, it demonstrates the application of Natural Language Processing (NLP) to provide a smartphone-like typing experience for both **English (US)** and **German (DE)** users.

##  Live Application
**Experience the live app here:** [https://altamashali.shinyapps.io/bilingual-swiftkey-nlp/](https://altamashali.shinyapps.io/bilingual-swiftkey-nlp/)

##  Key Features
* **Bilingual Capability:** Switch seamlessly between English and German interfaces and models.
* **Katz Back-off Algorithm:** Utilizes a sophisticated 4-gram model that "backs off" to Trigrams and Bigrams to ensure predictions are always available.
* **Premium UX:** A centered, responsive "Lux" interface with custom CSS for a modern, distraction-free experience.
* **Keyboard Optimized:** Features "Enter-to-Select" functionality and automatic cursor refocusing for rapid-fire typing.
* **Efficiency:** Powered by `data.table` for sub-millisecond prediction lookups.

##  Model Methodology
The engine was built using the **HC Corpora** dataset, following a rigorous data science pipeline:
1.  **Preprocessing:** Tokenization, profanity filtering, and removal of special characters (while preserving German umlauts like ä, ö, ü).
2.  **N-Gram Modeling:** Calculation of frequencies for Quadgrams, Trigrams, and Bigrams.
3.  **Prediction Logic:**
    * If a 3-word history matches a **Quadgram**, suggest the top targets.
    * Otherwise, back-off to a 2-word history (**Trigram**).
    * Otherwise, back-off to a 1-word history (**Bigram**).

##  Tech Stack
* **Language:** R
* **Framework:** Shiny
* **UI Components:** `bslib`, `JavaScript` (for input handling)
* **Data Processing:** `data.table`, `stringr`

##  License
This project is licensed under the **MIT License** - see the [LICENSE](LICENSE) file for details.

---
**Developed by Altamash Ali** [GitHub Profile](https://github.com/realAltamashAli)

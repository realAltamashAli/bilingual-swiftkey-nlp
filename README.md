#  SwiftKey Pro: Bilingual Next-Word Predictor
### High-Performance NLP Web Application | English & German Support

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Shiny](https://img.shields.io/badge/Shiny-Live_App-1a5276)](https://altamashali.shinyapps.io/bilingual-swiftkey-nlp/)
[![R](https://img.shields.io/badge/R-4.3.0%2B-blue)](https://www.r-project.org/)

SwiftKey Pro is a professional text prediction tool that suggests the most likely next word in a sequence. Developed as a capstone project, it demonstrates the application of Natural Language Processing (NLP) to provide a smartphone-like typing experience for both **English (US)** and **German (DE)** users.

##  Live Project Links
* **Experience the live app here:** [SwiftKey Pro Live](https://altamashali.shinyapps.io/bilingual-swiftkey-nlp/)
* **Technical Analysis (English):** [Milestone Report EN](https://realaltamashali.github.io/bilingual-swiftkey-nlp/index.html)
* **Technische Analyse (Deutsch):** [Meilensteinbericht DE](https://realaltamashali.github.io/bilingual-swiftkey-nlp/index-de.html)

##  Key Features
* **Bilingual Intelligence:** Switch seamlessly between English and German NLP models with localized UI.
* **Katz Back-off Algorithm:** Utilizes a sophisticated 4-gram model that "backs off" to Trigrams and Bigrams to ensure predictions are always available.
* **Premium UX/UI:** A centered, responsive "Lux" interface with custom CSS for a modern user experience.
* **Keyboard Optimized:** Features "Enter-to-Select" functionality and automatic cursor refocusing via JavaScript.
* **Efficiency:** Powered by `data.table` for sub-millisecond prediction lookups.

##  Model Methodology
The engine was built using the **HC Corpora** dataset, following a rigorous data science pipeline:
1.  **Preprocessing:** Tokenization, profanity filtering, and removal of special characters (while preserving German umlauts like ä, ö, ü).
2.  **N-Gram Modeling:** Calculation of frequencies for Quadgrams, Trigrams, and Bigrams.
3.  **Back-off Logic:** Intelligent fallback mechanism when specific word sequences are not found in the higher-order models.

##  Repository Structure & Data Privacy
* `app.R`: The complete Shiny application logic, UI, and custom JavaScript.
* `index.Rmd` / `index-de.Rmd`: The source R-Markdown files for technical analysis.
* **Note on Data:** To protect the integrity of the project and proprietary training results, the pre-trained `.rds` model files are not included in this public repository. The code is provided for peer review and portfolio demonstration. The full application remains functional at the live link above.

##  Tech Stack
* **Language:** R
* **Framework:** Shiny
* **UI Components:** `bslib`, `JavaScript` (for input handling)
* **Data Processing:** `data.table`, `stringr`

##  License
This project is licensed under the **MIT License** - see the [LICENSE](LICENSE) file for details.

---
**Developed by Altamash Ali** [GitHub Profile](https://github.com/realAltamashAli)

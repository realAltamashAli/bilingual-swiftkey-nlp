library(shiny)
library(bslib)
library(data.table)
library(stringr)

# 1. Load Optimized Data
en_data <- readRDS("app_data_en.rds")
de_data <- readRDS("app_data_de.rds")

# 2. Premium Blue Theme
my_theme <- bs_theme(
  version = 5,
  bootswatch = "lux",
  primary = "#1a5276",   
  secondary = "#aeb6bf",
  base_font = font_google("Inter"),
  heading_font = font_google("Montserrat")
)

# 3. User Interface
ui <- page_fillable(
  theme = my_theme,
  tags$head(
    tags$style(HTML("
      /* Universal Centering Fixes */
      body { 
        background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%); 
        display: flex; 
        align-items: center; 
        justify-content: center; 
        min-height: 100vh; 
        margin: 0;
        padding: 15px; /* Adds breathing room on mobile */
      }
      
      /* Ensure the card is centered and doesn't overflow horizontally */
      .container-fluid {
        width: 100%;
        display: flex;
        justify-content: center;
        padding: 0;
      }

      .prediction-card { 
        border-radius: 20px; 
        border: none; 
        box-shadow: 0 15px 45px rgba(26, 82, 118, 0.15); 
        width: 100%;
        max-width: 1000px; 
        margin: auto; /* Critical for centering */
        background-color: white;
      }

      .predict-btn { 
        border-radius: 50px; 
        padding: 12px 28px; 
        font-weight: 600; 
        text-transform: uppercase; 
        letter-spacing: 1px; 
        transition: all 0.3s ease; 
        border: 2px solid #1a5276; 
      }
      .predict-btn:hover { 
        background-color: #1a5276 !important; 
        color: white !important; 
        transform: translateY(-3px); 
      }
      
      #user_input { font-size: 1.2rem; border-radius: 12px; border: 2px solid #eaeded; resize: none; }
      #user_input:focus { border-color: #1a5276; box-shadow: none; }
      
      /* Flag Image Styling - Fixed for SVG compatibility */
      .flag-img { height: 16px; width: auto; vertical-align: middle; margin-right: 8px; border-radius: 2px; }
      
      /* Allow scrolling on mobile if content is tall */
      html, body { overflow-x: hidden; overflow-y: auto; }
    ")),
    
    tags$script(HTML("
      // CLICK HANDLER
      $(document).on('click', '.predict-btn', function() {
        var word = $(this).text().trim();
        var textArea = $('#user_input');
        var currentVal = textArea.val().replace(/[\\r\\n]/g, ' ').replace(/\\s+/g, ' ').trim();
        
        // Append word + space
        var newVal = currentVal + (currentVal.length > 0 ? ' ' : '') + word + ' ';
        
        // Update the UI and trigger Shiny
        textArea.val(newVal);
        textArea.trigger('change');
        textArea.focus();
      });

      // ENTER KEY HANDLER
      $(document).on('keydown', '#user_input', function(e) {
        if(e.which == 13) { 
          e.preventDefault(); // HARD BLOCK on the newline
          var firstBtn = $('.predict-btn').first();
          if(firstBtn.length > 0) {
            firstBtn.click();
          }
          return false;
        }
      });
    "))
  ),
  
  div(class = "container-fluid",
      card(
        class = "prediction-card p-4",
        card_header(
          div(style = "display: flex; justify-content: space-between; align-items: center;",
              uiOutput("app_title"),
              # FIX: Using lipis/flag-icons SVG assets for Universal Compatibility
              radioButtons("lang", NULL, 
                           choiceNames = list(
                             HTML("<img src='https://cdn.jsdelivr.net/gh/lipis/flag-icons/flags/4x3/us.svg' class='flag-img'> English"),
                             HTML("<img src='https://cdn.jsdelivr.net/gh/lipis/flag-icons/flags/4x3/de.svg' class='flag-img'> Deutsch")
                           ),
                           choiceValues = list("en", "de"),
                           inline = TRUE)
          )
        ),
        layout_sidebar(
          sidebar = sidebar(
            uiOutput("sidebar_content")
          ),
          div(
            uiOutput("input_label_ui"),
            textAreaInput("user_input", NULL, placeholder = "Start typing...", width = "100%", rows = 4),
            hr(),
            uiOutput("prediction_header"),
            uiOutput("prediction_ui")
          )
        ),
        card_footer(
          p(style="font-size: 0.8rem; color: #95a5a6; text-align: center; margin: 0;", 
            "Bilingual Predictive Engine © 2026 Altamash Ali | Powered by HC Corpora")
        )
      )
  )
)

# 4. Server Logic
server <- function(input, output, session) {
  
  i18n <- reactive({
    if (input$lang == "en") {
      list(title = "SWIFTKEY PRO", sidebar_title = "APP INFORMATION", sidebar_desc = "This model uses a Katz Back-off algorithm to predict words based on Quadgram, Trigram, and Bigram frequencies.", status = "Status: High-Precision Mode", input_label = "Enter your text below to generate smart predictions:", placeholder = "Type something here...", suggested = "SUGGESTED NEXT WORDS:", awaiting = "Awaiting input...", model_info = "Model: English US")
    } else {
      list(title = "SWIFTKEY PRO", sidebar_title = "APP-INFORMATIONEN", sidebar_desc = "Dieses Modell verwendet einen Katz-Back-off-Algorithmus, um Wörter basierend auf Quadgramm-, Trigramm- und Bigramm-Frequenzen vorherzusagen.", status = "Status: Hochpräzisionsmodus", input_label = "Geben Sie unten Ihren Text ein, um intelligente Vorhersagen zu generieren:", placeholder = "Schreiben Sie hier etwas...", suggested = "VORGESCHLAGENE NÄCHSTE WÖRTER:", awaiting = "Warte auf Eingabe...", model_info = "Modell: Deutsch DE")
    }
  })
  
  observeEvent(input$lang, {
    updateTextAreaInput(session, "user_input", placeholder = i18n()$placeholder)
  })
  
  output$app_title <- renderUI({ h2(style = "color: #1a5276; font-weight: 800; margin: 0;", i18n()$title) })
  output$sidebar_content <- renderUI({
    tagList(h5(i18n()$sidebar_title), p(i18n()$sidebar_desc), hr(), p(strong(i18n()$status)), span(i18n()$model_info, style = "color: #7f8c8d; font-size: 0.9em;"))
  })
  output$input_label_ui <- renderUI({ p(style="color: #566573;", i18n()$input_label) })
  output$prediction_header <- renderUI({ h5(style="color: #1a5276; font-weight: 700;", i18n()$suggested) })
  
  predict_next <- reactive({
    req(input$user_input)
    # Clean input for modeling
    clean_input <- tolower(input$user_input) %>% str_replace_all("[^a-zäöüß ]", " ") %>% str_squish()
    words <- unlist(strsplit(clean_input, " "))
    n_words <- length(words)
    dt <- if(input$lang == "en") en_data else de_data
    
    if (n_words >= 3) {
      res <- dt[history == paste(words[(n_words-2):n_words], collapse = " ")]
      if (nrow(res) > 0) return(head(res$target, 3))
    }
    if (n_words >= 2) {
      res <- dt[history == paste(words[(n_words-1):n_words], collapse = " ")]
      if (nrow(res) > 0) return(head(res$target, 3))
    }
    if (n_words >= 1) {
      res <- dt[history == words[n_words]]
      if (nrow(res) > 0) return(head(res$target, 3))
    }
    return(NULL)
  })
  
  output$prediction_ui <- renderUI({
    preds <- predict_next()
    if (is.null(preds) || length(preds) == 0) return(p(style="color: #bdc3c7; font-style: italic;", i18n()$awaiting))
    tagList(lapply(preds, function(w) { actionButton(inputId = paste0("btn_", w), label = w, class = "predict-btn btn-outline-primary m-2") }))
  })
}

shinyApp(ui, server)
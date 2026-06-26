# Ex_20

library(shiny)
library(ggplot2)
library(dplyr)

# UI - interfejs użytkownika
ui <- fluidPage(
  
  titlePanel("🔬 Interaktywny raport - analiza danych"),
  
  sidebarLayout(
    sidebarPanel(
      fileInput("file", "Wczytaj plik CSV", accept = ".csv"),
      uiOutput("var_select"),
      sliderInput("bins", "Liczba słupków w histogramie:", min = 5, max = 50, value = 30),
      actionButton("run", "🔄 Generuj raport")
    ),
    
    mainPanel(
      h3("📊 Wykres"),
      plotOutput("histogram"),
      h3("📈 Statystyki"),
      verbatimTextOutput("summary")
    )
  )
)

# Server - logika aplikacji
server <- function(input, output, session) {
  
  # Reactive expression: wczytanie danych
  dane <- reactive({
    req(input$file)
    read.csv(input$file$datapath)
  })
  
  # Dynamiczne pole wyboru zmiennych numerycznych
  output$var_select <- renderUI({
    req(dane())
    num_cols <- names(dane())[sapply(dane(), is.numeric)]
    selectInput("zmienna", "Wybierz zmienną do analizy:", choices = num_cols)
  })
  
  # Wykres histogramu
  output$histogram <- renderPlot({
    req(input$run)
    req(input$zmienna)
    
    ggplot(dane(), aes_string(x = input$zmienna)) +
      geom_histogram(bins = input$bins, fill = "skyblue", color = "white") +
      labs(
        title = paste("Histogram zmiennej:", input$zmienna),
        x = input$zmienna,
        y = "Częstość"
      ) +
      theme_minimal()
  })
  
  # Statystyki opisowe
  output$summary <- renderPrint({
    req(input$run)
    req(input$zmienna)
    
    summary(dane()[[input$zmienna]])
  })
}

# Uruchomienie aplikacji
shinyApp(ui, server)

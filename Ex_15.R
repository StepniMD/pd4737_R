# Ex_15: Tworzenie wykresów za pomocą ggplot2

# Wczytanie bibliotek
library(ggplot2)
library(dplyr)

# Wczytanie danych
rna_data <- read.csv("rna_seq_data.csv", stringsAsFactors = FALSE)

# === WYKRES 1: BOX PLOT — Ekspresja genów w różnych warunkach ===

boxplot_ekspresji <- ggplot(rna_data, aes(x = Condition, y = Expression_Level, fill = Chromosome)) +
  geom_boxplot(outlier.shape = NA, alpha = 0.8) +
  labs(
    title = "Poziomy ekspresji genów w różnych warunkach",
    x = "Warunek",
    y = "Poziom ekspresji"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5),
    legend.position = "bottom"
  )

# Zapis wykresu do pliku
ggsave("ekspresja boxplot.jpeg", plot = boxplot_ekspresji, width = 8, height = 5, dpi = 300)


# === WYKRES 2: VOLCANO PLOT — Różnicowa ekspresja ===

rna_data <- rna_data %>%
  mutate(
    minus_log10_p = -log10(P_value),
    istotny = ifelse(Adjusted_P_value < 0.05 & abs(Log2FC) > 1, "Tak", "Nie")
  )

volcano_plot <- ggplot(rna_data, aes(x = Log2FC, y = minus_log10_p)) +
  geom_point(aes(color = istotny), alpha = 0.7, size = 2) +
  scale_color_manual(values = c("Tak" = "red", "Nie" = "grey")) +
  geom_vline(xintercept = c(-1, 1), linetype = "dashed", color = "blue") +
  geom_hline(yintercept = -log10(0.05), linetype = "dashed", color = "blue") +
  labs(
    title = "Analiza różnicowej ekspresji genów",
    x = "Log2 fold change",
    y = "-log10(p-value)",
    color = "Istotna zmiana"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5),
    legend.position = "bottom"
  )

# Zapis wykresu do pliku
ggsave("volcano plot.jpg", plot = volcano_plot, width = 8, height = 5, dpi = 300)

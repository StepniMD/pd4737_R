# Ex_14: Tworzenie wykresów wbudowanymi funkcjami

# Wczytanie danych
rna_data <- read.csv("rna_seq_data.csv", stringsAsFactors = FALSE)

# === HISTOGRAM: Poziomy ekspresji genów ===

jpeg("histogram_ekspresji.jpeg")
hist(
  rna_data$Expression_Level,
  breaks = 30,
  col = "skyblue",
  border = "black",
  main = "Rozkład poziomów ekspresji genów",
  xlab = "Poziom ekspresji",
  ylab = "Częstość"
)
dev.off()

# === WYKRES PUNKTOWY: Log2FC vs -log10(P_value) ===

# Obliczenie -log10(p-value)
rna_data$minus_log10_p <- -log10(rna_data$P_value)

# Kolor punktów zależnie od Adjusted_P_value
kolory <- ifelse(rna_data$Adjusted_P_value < 0.05, "red", "blue")

jpeg("zmiana_ekspresji.jpeg")
plot(
  rna_data$Log2FC,
  rna_data$minus_log10_p,
  col = kolory,
  pch = 19,
  cex = 0.7,
  main = "Zmiana ekspresji vs Istotność statystyczna",
  xlab = "Log2 fold change",
  ylab = "-log10(p-value)"
)
legend("topright", legend = c("p.adj < 0.05", "p.adj >= 0.05"), col = c("red", "blue"), pch = 19)
dev.off()

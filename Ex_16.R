# Ex_16: Statystyka opisowa dla danych RNA-seq

# Wczytanie bibliotek
library(dplyr)
library(moments)

# Wczytanie danych
rna_data <- read.csv("rna_seq_data.csv", stringsAsFactors = FALSE)

# 1. Ogólny przegląd danych
print("== Podsumowanie danych ==")
print(summary(rna_data))

# 2. Szczegółowe statystyki opisowe dla Expression_Level
expr <- rna_data$Expression_Level

cat("\n== Statystyki opisowe dla Expression_Level ==\n")
cat("Średnia:", mean(expr), "\n")
cat("Mediana:", median(expr), "\n")
cat("Minimum:", min(expr), "\n")
cat("Maksimum:", max(expr), "\n")
cat("Odchylenie standardowe:", sd(expr), "\n")
cat("Kwartyle:\n")
print(quantile(expr))

# 3. Statystyki w podziale na warunki eksperymentalne
cat("\n== Statystyki opisowe według Condition ==\n")
aggregate(Expression_Level ~ Condition, data = rna_data, FUN = function(x) {
  c(Średnia = mean(x), Mediana = median(x), SD = sd(x))
})

# 4. Rozkład: skośność i kurtoza
cat("\n== Rozkład danych (Expression_Level) ==\n")
cat("Skośność:", skewness(expr), "\n")
cat("Kurtoza:", kurtosis(expr), "\n")

# 5. Histogramy dla P_value i Log2FC
jpeg("hist_pvalue.jpeg")
hist(rna_data$P_value, main = "Rozkład wartości P", xlab = "P_value", col = "lightblue", breaks = 30)
dev.off()

jpeg("hist_log2fc.jpeg")
hist(rna_data$Log2FC, main = "Rozkład Log2FC", xlab = "Log2 fold change", col = "salmon", breaks = 30)
dev.off()

# 6. Ekstremalne zmiany ekspresji
cat("\n== Geny z największymi zmianami ekspresji ==\n")
rna_data <- rna_data %>%
  mutate(abs_Log2FC = abs(Log2FC))

top_geny_up <- rna_data %>% arrange(desc(Log2FC)) %>% head(5)
top_geny_down <- rna_data %>% arrange(Log2FC) %>% head(5)

print(top_geny_up[, c("Gene_ID", "Gene_Symbol", "Log2FC")])
print(top_geny_down[, c("Gene_ID", "Gene_Symbol", "Log2FC")])

# 7. Częstość: Gene_Type
cat("\n== Tabela częstości dla Gene_Type ==\n")
print(table(rna_data$Gene_Type))

# 8. Tabela kontyngencji: Chromosome vs Condition
cat("\n== Tabela kontyngencji Chromosome ~ Condition ==\n")
print(table(rna_data$Chromosome, rna_data$Condition))

# 9. Analiza istotnych genów (P_value < 0.05)
geny_istotne <- rna_data %>%
  filter(P_value < 0.05)

srednia_abs_log2fc <- mean(abs(geny_istotne$Log2FC))

top5_max <- geny_istotne %>% arrange(desc(abs(Log2FC))) %>% head(5)
top5_min <- geny_istotne %>% arrange(abs(Log2FC)) %>% head(5)

# Zapis wyników do pliku
sink("significant_genes_stats.txt")
cat("Średnia bezwzględna zmiana ekspresji (Log2FC):", round(srednia_abs_log2fc, 4), "\n\n")

cat("Top 5 genów o NAJWIĘKSZEJ zmianie:\n")
print(top5_max[, c("Gene_ID", "Gene_Symbol", "Log2FC", "P_value")])

cat("\nTop 5 genów o NAJMNIEJSZEJ zmianie:\n")
print(top5_min[, c("Gene_ID", "Gene_Symbol", "Log2FC", "P_value")])
sink()

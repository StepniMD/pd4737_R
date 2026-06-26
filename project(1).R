# Projekt zaliczeniowy – Podstawy programowania w języku R
# Autor: [Twoje Imię]
# Data: 2026-04-04

# ==========================
# 1. IMPORT I INSPEKCJA DANYCH
# ==========================

dane <- read.csv("project_data.csv", stringsAsFactors = FALSE)

str(dane)
dim(dane)
head(dane, 10)
tail(dane, 5)

# ==========================
# 2. CZYSZCZENIE I TRANSFORMACJE
# ==========================

# Wymuszenie braków danych (min. 3 wartości)
dane$Expression[c(1, 10, 20)] <- NA

# Przekształcenie Gene_Type w factor
dane$Gene_Type <- as.factor(dane$Gene_Type)

# Zmiana nazw kolumn na duże litery
colnames(dane) <- toupper(colnames(dane))

# Sortowanie malejąco po Expression
dane_sorted <- dane[order(-dane$EXPRESSION, na.last = TRUE), ]

# Filtrowanie: Expression > 12
wysoka_ekspresja <- subset(dane_sorted, EXPRESSION > 12)
print(wysoka_ekspresja)

# ==========================
# 3. IMPUTACJA DANYCH
# ==========================

srednia_expr <- mean(dane$EXPRESSION, na.rm = TRUE)
dane$EXPRESSION[is.na(dane$EXPRESSION)] <- srednia_expr

# ==========================
# 4. ANALIZA EKSPLORACYJNA – dplyr
# ==========================

library(dplyr)

# filter + group_by + summarise + arrange
wynik_dplyr <- dane %>%
  filter(CONDITION == "Treatment") %>%
  group_by(GENE_TYPE) %>%
  summarise(SREDNIA = mean(EXPRESSION), MAX = max(EXPRESSION)) %>%
  arrange(desc(SREDNIA))

print(wynik_dplyr)

# select + mutate
dane <- dane %>%
  mutate(LOG2FC_ABS = abs(LOG2FC))

# ==========================
# 5. STATYSTYKA OPISOWA
# ==========================

cat("Min:",     min(dane$EXPRESSION),    "\n")
cat("Max:",     max(dane$EXPRESSION),    "\n")
cat("Srednia:", mean(dane$EXPRESSION),   "\n")
cat("Mediana:", median(dane$EXPRESSION), "\n")
cat("SD:",      sd(dane$EXPRESSION),     "\n")
cat("Kwartyle:\n")
print(quantile(dane$EXPRESSION))

# Moda
table_rounded <- table(round(dane$EXPRESSION))
moda <- as.numeric(names(table_rounded)[which.max(table_rounded)])
cat("Moda:", moda, "\n")

# Tabela czestosci Gene_Type
print(table(dane$GENE_TYPE))

# ==========================
# 6. TEST STATYSTYCZNY
# ==========================

# Test t-Studenta dla porownania grup Control vs Treatment
t_test <- t.test(EXPRESSION ~ CONDITION, data = dane)
print(t_test)

cat("\nInterpretacja: p-value =", round(t_test$p.value, 4), "\n")
if (t_test$p.value < 0.05) {
  cat("Roznica miedzy grupami jest statystycznie istotna.\n")
} else {
  cat("Brak statystycznie istotnej roznicy miedzy grupami.\n")
}

# ==========================
# 7. WIZUALIZACJE
# ==========================

library(ggplot2)

# Wykres 1: Pudelkowy – ekspresja wg warunku
p1 <- ggplot(dane, aes(x = CONDITION, y = EXPRESSION, fill = CONDITION)) +
  geom_boxplot() +
  labs(title = "Ekspresja genow wg warunku", x = "Warunek", y = "Ekspresja") +
  theme_minimal()
ggsave("plot_boxplot.jpeg", plot = p1, width = 8, height = 5, dpi = 150)

# Wykres 2: Histogram rozkladu ekspresji
p2 <- ggplot(dane, aes(x = EXPRESSION)) +
  geom_histogram(bins = 30, fill = "skyblue", color = "white") +
  labs(title = "Rozklad ekspresji", x = "Ekspresja", y = "Czestość") +
  theme_minimal()
ggsave("plot_histogram.jpeg", plot = p2, width = 8, height = 5, dpi = 150)

# Wykres 3: Volcano plot
p3 <- ggplot(dane, aes(x = LOG2FC, y = -log10(P_VALUE))) +
  geom_point(aes(color = CONDITION), alpha = 0.7) +
  geom_vline(xintercept = c(-1, 1), linetype = "dashed") +
  geom_hline(yintercept = -log10(0.05), linetype = "dashed") +
  labs(title = "Volcano Plot", x = "Log2FC", y = "-log10(p)") +
  theme_light()
ggsave("plot_volcano.jpeg", plot = p3, width = 8, height = 5, dpi = 150)

# ==========================
# 8. FUNKCJA WŁASNA
# ==========================

filtruj_geny <- function(df, prog_expr = 12, pval = 0.05) {
  df[df$EXPRESSION > prog_expr & df$P_VALUE < pval, ]
}

print(filtruj_geny(dane))

# ==========================
# 9. RAPORT RMARKDOWN
# Plik: project_report.Rmd – otworz w RStudio i kliknij Knit
# ==========================

# ==========================
# 10. ELEMENT ZAAWANSOWANY: REGRESJA LINIOWA
# ==========================

model <- lm(EXPRESSION ~ CONDITION + GENE_TYPE, data = dane)
print(summary(model))

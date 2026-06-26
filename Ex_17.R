# Ex_17: Testowanie i regresja

# Wczytanie danych z pakietu base
data(npk)

# Sprawdzenie struktury danych
cat("== Struktura danych npk ==\n")
str(npk)

# === JEDNOCZYNNIKOWA ANALIZA WARIANCJI ===

# ANOVA: Plon vs. nawóz azotowy (N)
anova_N <- aov(yield ~ N, data = npk)
cat("\n== ANOVA: Plon vs. N ==\n")
print(summary(anova_N))

# ANOVA: Plon vs. fosfor (P)
anova_P <- aov(yield ~ P, data = npk)
cat("\n== ANOVA: Plon vs. P ==\n")
print(summary(anova_P))

# ANOVA: Plon vs. potas (K)
anova_K <- aov(yield ~ K, data = npk)
cat("\n== ANOVA: Plon vs. K ==\n")
print(summary(anova_K))

# ANOVA: Plon vs. blok
anova_blok <- aov(yield ~ block, data = npk)
cat("\n== ANOVA: Plon vs. blok ==\n")
print(summary(anova_blok))

# === TEST POST-HOC TUKEYA dla czynnika N ===
cat("\n== Test post-hoc Tukeya dla N ==\n")
tukey_N <- TukeyHSD(anova_N)
print(tukey_N)

# === TEST KRUSKALA-WALLISA ===
cat("\n== Test Kruskala-Wallisa dla N ==\n")
print(kruskal.test(yield ~ N, data = npk))

# === REGRESJA LINIOWA ===
model <- lm(yield ~ N + P + K + block, data = npk)

cat("\n== Model regresji liniowej ==\n")
print(summary(model))

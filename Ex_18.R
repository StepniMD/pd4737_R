# Ex_18: GenomicRanges

# 1. Instalacja i załadowanie pakietu
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("GenomicRanges", ask = FALSE)
library(GenomicRanges)

# 2. Tworzenie obiektu GRanges z 6 genami
moje_geny <- GRanges(
  seqnames = c("chr1", "chr1", "chr2", "chr2", "chr3", "chrX"),
  ranges = IRanges(
    start = c(1000,  5000, 20000, 35000, 10000,  8000),
    end   = c(3500,  7200, 22000, 40000, 15000, 12000)
  ),
  strand    = c("+", "-", "+", "-", "+", "+"),
  gene_name = c("TP53", "BRCA1", "EGFR", "MYC", "PTEN", "KRAS"),
  expression = c(5.2, 3.8, 7.1, 9.4, 2.6, 6.3)
)

# 3. Podstawowe operacje

# Wyświetlenie obiektu
cat("== Obiekt GRanges ==\n")
print(moje_geny)

# Długości regionów
cat("\n== Długości regionów ==\n")
print(width(moje_geny))

# Wyodrębnienie regionów z chr1
cat("\n== Regiony z chr1 ==\n")
print(subset(moje_geny, seqnames == "chr1"))

# Liczba regionów dla każdego chromosomu
cat("\n== Liczba regionów na chromosom ==\n")
print(table(seqnames(moje_geny)))

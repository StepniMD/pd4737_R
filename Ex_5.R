# Ex_5: Importowanie i eksportowanie danych

# --- A. Import danych z pliku CSV (pacjenci.csv) ---
pacjenci <- read.csv("pacjenci.csv", stringsAsFactors = FALSE)

# --- B. Import danych z pliku Excel (geny.xlsx - dwa arkusze) ---
library(readxl)
geny_ekspresja <- read_excel("geny.xlsx", sheet = 1)
geny_metadane <- read_excel("geny.xlsx", sheet = 2)

# --- C. Import danych z pliku TXT (tab-separated) ---
sekwencje <- read.table("sekwencje.txt", header = TRUE, sep = "\t", stringsAsFactors = FALSE)

# --- D. Import danych z pliku XML (białka.xml) ---
library(XML)
bialka_xml <- xmlParse("białka.xml")
bialka_data <- xmlToDataFrame(nodes = getNodeSet(bialka_xml, "//protein"))

# --- E. Pobieranie danych z Ensembl przez biomaRt ---
library(biomaRt)

ensembl <- useMart("ensembl", dataset = "hsapiens_gene_ensembl")
gen_mtco1 <- getBM(
  attributes = c("ensembl_gene_id", "hgnc_symbol", "chromosome_name",
                 "start_position", "end_position", "gene_biotype"),
  filters = "hgnc_symbol",
  values = "MT-CO1",
  mart = ensembl
)

print("Informacje o genie MT-CO1:")
print(gen_mtco1)

# --- Operacje dla A, B, C ---

eksportuj_dane <- function(df, nazwa) {
  cat("\nStruktura danych:", nazwa, "\n")
  str(df)
  print("Pierwsze 6 wierszy:")
  print(head(df))
  print("Wymiary:")
  print(dim(df))

  # Dodanie kolumny
  df$Nowa_Kolumna <- "testowa_wartość"

  # Eksport do CSV, RDS, TXT
  write.csv(df, paste0(nazwa, "_zmodyfikowane.csv"), row.names = FALSE)
  saveRDS(df, paste0(nazwa, "_zmodyfikowane.rds"))
  write.table(df, paste0(nazwa, "_zmodyfikowane.txt"), sep = "\t", row.names = FALSE)
}

eksportuj_dane(pacjenci, "pacjenci")
eksportuj_dane(geny_ekspresja, "geny_ekspresja")
eksportuj_dane(sekwencje, "sekwencje")

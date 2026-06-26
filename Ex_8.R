# Ex_8: Praca z pakietem stringr (tidyverse)

# Wczytanie bibliotek
library(readr)
library(dplyr)
library(stringr)

# Wczytanie danych
sekwencje <- read_tsv("sekwencje.txt")

# 1. Liczba wystąpień motywu 'ATG' w każdej sekwencji
sekwencje <- sekwencje %>%
  mutate(ATG_count = str_count(Sekwencja, "ATG"))

# 2. Zamiana RNA (U) na DNA (U → T)
sekwencje <- sekwencje %>%
  mutate(Sekwencja_DNA = if_else(
    Typ == "RNA",
    str_replace_all(Sekwencja, "U", "T"),
    Sekwencja
  ))

# 3. Wyodrębnienie pierwszych 10 nukleotydów
sekwencje <- sekwencje %>%
  mutate(Pierwsze_10nt = str_sub(Sekwencja_DNA, 1, 10))

# 4. Wykrycie motywu 'GAG'
sekwencje <- sekwencje %>%
  mutate(Zawiera_GAG = str_detect(Sekwencja_DNA, "GAG"))

# 5. Sekwencja odwrócona + zamiana komplementarna
zamien_komplement_DNA <- function(seq) {
  seq <- tolower(seq)
  seq <- chartr("atgc", "tacg", seq)
  str_to_upper(strrev(seq))
}

zamien_komplement_RNA <- function(seq) {
  seq <- tolower(seq)
  seq <- chartr("augc", "uacg", seq)
  str_to_upper(strrev(seq))
}

sekwencje <- sekwencje %>%
  mutate(Sekwencja_rev = case_when(
    Typ == "DNA" ~ sapply(Sekwencja_DNA, zamien_komplement_DNA),
    Typ == "RNA" ~ sapply(Sekwencja_DNA, zamien_komplement_RNA)
  ))

# 6. Tabela podsumowująca
podsumowanie <- sekwencje %>%
  transmute(
    ID,
    Pierwsze_10nt,
    Ostatnie_5nt = str_sub(Sekwencja_DNA, -5),
    Zawiera_GAG
  )

# Podgląd
print(podsumowanie)

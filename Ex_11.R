# Ex_11: Tworzenie własnej funkcji

library(readxl)
library(dplyr)

# Wczytanie danych
dane <- read_excel("geny.xlsx", sheet = 1)

# Funkcja analiza_ekspresji
analiza_ekspresji <- function(dane, prog_fc = 0.8, prog_p = 0.05) {

  # Filtracja genów nadekspresjonowanych
  nadekspresja <- dane %>%
    filter(Log2FC > prog_fc & P_value < prog_p) %>%
    select(Symbol, Log2FC, P_value)

  # Filtracja genów obniżonych
  obniżona_ekspresja <- dane %>%
    filter(Log2FC < -prog_fc & P_value < prog_p) %>%
    select(Symbol, Log2FC, P_value)

  # Średnie w kontroli i próbie
  dane <- dane %>%
    mutate(
      Srednia_Kontrola = rowMeans(select(., starts_with("Kontrola"))),
      Srednia_Proba = rowMeans(select(., starts_with("Próba")))
    )

  # Wynik jako lista
  wynik <- list(
    Liczba_genow_nadekspresja = nrow(nadekspresja),
    Liczba_genow_obnizona = nrow(obniżona_ekspresja),
    Geny_nadekspresja = nadekspresja,
    Geny_obnizona = obniżona_ekspresja
  )

  return(wynik)
}

# Przetestowanie funkcji na danych
wynik_analizy <- analiza_ekspresji(dane)

# Wyświetlenie wyników
print(paste("Liczba genów z nadekspresją:", wynik_analizy$Liczba_genow_nadekspresja))
print(paste("Liczba genów z obniżoną ekspresją:", wynik_analizy$Liczba_genow_obnizona))

cat("\nGeny z nadekspresją:\n")
print(wynik_analizy$Geny_nadekspresja)

cat("\nGeny z obniżoną ekspresją:\n")
print(wynik_analizy$Geny_obnizona)

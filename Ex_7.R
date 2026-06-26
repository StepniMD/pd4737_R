# Ex_7: Zarządzanie brakującymi danymi

# Wczytanie danych
pacjenci <- read.csv("pacjenci.csv", stringsAsFactors = FALSE)

# Instalacja i załadowanie pakietu naniar (jeśli nie masz)
# install.packages("naniar")
library(naniar)

# 1. Policz liczbę NA w każdej kolumnie
print("Liczba brakujących wartości (NA) w kolumnach:")
print(colSums(is.na(pacjenci)))

# 2. Wizualizacja braków
vis_miss(pacjenci)  # funkcja z naniar

# 3. Pacjenci z kompletnymi danymi (bez NA)
kompletne_badania_krwii <- pacjenci[complete.cases(pacjenci), ]

# 4. Uzupełnienie braków:

## Hemoglobina — średnia według płci
pacjenci$Hemoglobina <- ifelse(
  is.na(pacjenci$Hemoglobina),
  ave(pacjenci$Hemoglobina, pacjenci$Płeć, FUN = function(x) mean(x, na.rm = TRUE))[is.na(pacjenci$Hemoglobina)],
  pacjenci$Hemoglobina
)

## Leukocyty — mediana ogólna
med_leuk <- median(pacjenci$Leukocyty, na.rm = TRUE)
pacjenci$Leukocyty[is.na(pacjenci$Leukocyty)] <- med_leuk

## Płytki krwi — średnia według płci
pacjenci$Płytki_krwi <- ifelse(
  is.na(pacjenci$Płytki_krwi),
  ave(pacjenci$Płytki_krwi, pacjenci$Płeć, FUN = function(x) mean(x, na.rm = TRUE))[is.na(pacjenci$Płytki_krwi)],
  pacjenci$Płytki_krwi
)

## Stan — najczęstsza wartość (moda)
najczestszy_stan <- names(sort(table(pacjenci$Stan), decreasing = TRUE))[1]
pacjenci$Stan[is.na(pacjenci$Stan)] <- najczestszy_stan

## Palenie — puste komórki jako "Brak danych"
pacjenci$Palenie[pacjenci$Palenie == "" | is.na(pacjenci$Palenie)] <- "Brak danych"

# Podgląd oczyszczonej ramki danych
print(head(pacjenci))

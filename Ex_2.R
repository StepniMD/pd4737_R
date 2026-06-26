# Ex_2: Operacje na macierzach

# Tworzenie macierzy ekspresji
set.seed(123)  # dla powtarzalności wyników
Ekspresja <- matrix(runif(12, 1, 10), nrow = 3, ncol = 4)

# Nadanie nazw wierszom (geny) i kolumnom (próbki)
rownames(Ekspresja) <- c("Gen1", "Gen2", "Gen3")
colnames(Ekspresja) <- c("Próbka1", "Próbka2", "Próbka3", "Próbka4")

# Wyświetlenie całej macierzy
print("Macierz Ekspresja:")
print(Ekspresja)

# Wartość ekspresji dla Gen1 w Próbce4
Gen1_Próbka4 <- Ekspresja["Gen1", "Próbka4"]
print("Wartość ekspresji dla Gen1 w Próbce4:")
print(Gen1_Próbka4)

# Zapisanie do zmiennych: trzeciego wiersza i drugiej kolumny
Gen3_all <- Ekspresja["Gen3", ]     # wszystkie wartości z trzeciego wiersza
Próbka2_all <- Ekspresja[, "Próbka2"]  # wszystkie wartości z drugiej kolumny

# Obliczanie średniej ekspresji dla każdego genu (wiersze)
srednia_geny <- rowMeans(Ekspresja)
print("Średnia ekspresja dla każdego genu:")
print(srednia_geny)

# Obliczanie średniej ekspresji dla każdej próbki (kolumny)
srednia_probki <- colMeans(Ekspresja)
print("Średnia ekspresja dla każdej próbki:")
print(srednia_probki)

# Transpozycja macierzy
EkspresjaT <- t(Ekspresja)
print("Transponowana macierz EkspresjaT:")
print(EkspresjaT)

# Nowa macierz tylko dla Próbki1 i Próbki3
Ekspresja_subset <- Ekspresja[, c("Próbka1", "Próbka3")]
print("Macierz z Próbki1 i Próbki3:")
print(Ekspresja_subset)

# Ex_3: Operacje na listach

# Tworzenie listy bio_lista
bio_lista <- list(
  sekwencje_DNA = c("ATGCCTGAC", "GTCAGTCAG", "CTGATCGATGCTA"),
  gatunki = c("Homo sapiens", "Mus musculus", "Drosophila melanogaster"),
  ekspresja_genow = matrix(runif(9, 0, 100), nrow = 3),
  cechy_morfologiczne = data.frame(
    Gatunek = c("Homo sapiens", "Mus musculus", "Drosophila melanogaster"),
    Wysokość = c(170, 10, 0.1),
    Waga = c(70, 0.02, 0.0002)
  ),
  mutacje = list(Homo_sapiens = c("BRCA1", "BRCA2"), Mus_musculus = "p53")
)

# 1. Wyświetlenie podstawowych informacji o liście
print("Struktura listy bio_lista:")
str(bio_lista)

# 2. Wyświetlenie nazw gatunków
print("Nazwy gatunków:")
print(bio_lista$gatunki)

# 3. Dodanie nowej sekwencji DNA
bio_lista$sekwencje_DNA <- c(bio_lista$sekwencje_DNA, "CGATGTAGCTA")

# 4. Zmiana wartości ekspresji genu w [1,1] na 99.9
bio_lista$ekspresja_genow[1, 1] <- 99.9

# 5. Obliczenie średniej ekspresji genów
srednia_ekspresji <- mean(bio_lista$ekspresja_genow)
print("Średnia ekspresji genów:")
print(srednia_ekspresji)

# 6. Dodanie nowego gatunku do cechy_morfologiczne
nowy_gatunek <- data.frame(
  Gatunek = "Arabidopsis thaliana",
  Wysokość = 0.3,
  Waga = 0.001
)
bio_lista$cechy_morfologiczne <- rbind(bio_lista$cechy_morfologiczne, nowy_gatunek)

# 7. Wyświetlenie mutacji dla Homo sapiens
print("Mutacje dla Homo sapiens:")
print(bio_lista$mutacje$Homo_sapiens)

# 8. Dodanie nowej mutacji do Mus musculus
bio_lista$mutacje$Mus_musculus <- c(bio_lista$mutacje$Mus_musculus, "Lmna")

# Podgląd końcowej wersji listy (opcjonalne)
# print(bio_lista)

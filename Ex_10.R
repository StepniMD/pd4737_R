# Ex_10: Podstawowe funkcje z rodziny apply

# Tworzenie przykładowej macierzy ekspresji
set.seed(42)  # dla powtarzalności wyników
gene_expression <- matrix(
  rnorm(20, mean = 10, sd = 2),
  nrow = 4,
  ncol = 5,
  dimnames = list(
    c("Gen_A", "Gen_B", "Gen_C", "Gen_D"),
    c("Próbka_1", "Próbka_2", "Próbka_3", "Próbka_4", "Próbka_5")
  )
)

# 1. Średnia ekspresja dla każdego genu (wiersze)
srednia_genow <- apply(gene_expression, 1, mean)
print("Średnia ekspresja genów:")
print(srednia_genow)

# 2. Odchylenie standardowe dla każdej próbki (kolumny)
odchylenie_probki <- apply(gene_expression, 2, sd)
print("Odchylenie standardowe dla próbek:")
print(odchylenie_probki)

# 3. Maksymalna wartość w każdym wierszu
maks_wartosci_genow <- apply(gene_expression, 1, max)
print("Maksymalne wartości ekspresji dla genów:")
print(maks_wartosci_genow)

# 4. Liczba wartości > 10 w każdej próbce
wartosci_ponad_10 <- apply(gene_expression, 2, function(x) sum(x > 10))
print("Liczba wartości > 10 w każdej próbce:")
print(wartosci_ponad_10)

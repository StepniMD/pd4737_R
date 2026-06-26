# Ex_1: Operacje na wektorach

# Tworzenie wektorów
A <- c(1, 4, 6, 8, 10)
B <- c(-1.7, 2.5, -3.5, 4.5, -5.5)
C <- c('ssDNA', 'dsDNA', 'RNA', 'Proteins', 'Lipids')
D <- c(TRUE, FALSE, FALSE, FALSE, TRUE)

# Operacje na A i B
sum_AB <- A + B           # Sumowanie
diff_AB <- A - B          # Odejmowanie
prod_AB <- A * B          # Mnożenie
div_AB <- A / B           # Dzielenie

# Operacje na C
char_count_C <- nchar(C)                # Liczba znaków
third_element_C <- C[3]                 # Trzeci element
first_fourth_C <- C[c(1, 4)]            # Pierwszy i czwarty element
sorted_C <- sort(C)                     # Sortowanie
reversed_C <- rev(C)                    # Odwrócenie kolejności

# Przekształcenie C w faktor i operacje na faktorze
factor_C <- factor(C)
levels_C <- levels(factor_C)            # Poziomy faktora
num_levels_C <- nlevels(factor_C)       # Liczba poziomów
factor_C_reordered <- factor(C, levels = c("RNA", setdiff(levels(factor_C), "RNA")))

# Operacje na D
sum_D <- sum(D)                         # Suma wartości logicznych (TRUE = 1)
true_indices_D <- which(D)              # Indeksy TRUE
negation_D <- !D                        # Negacja wartości

# Wyświetlenie wyników (dla testowania lokalnego)
print("Operacje na A i B:")
print(sum_AB)
print(diff_AB)
print(prod_AB)
print(div_AB)

print("Operacje na C:")
print(char_count_C)
print(third_element_C)
print(first_fourth_C)
print(sorted_C)
print(reversed_C)

print("Faktor C:")
print(levels_C)
print(num_levels_C)
print(factor_C_reordered)

print("Operacje na D:")
print(sum_D)
print(true_indices_D)
print(negation_D)

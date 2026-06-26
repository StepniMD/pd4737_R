# Ex_4: Operacje na ramkach danych

# Tworzenie ramki danych df
df <- data.frame(
  ID = 1:5,
  Wiek = c(25, 34, 28, 52, 40),
  Płeć = c("Kobieta", "Mężczyzna", "Kobieta", "Mężczyzna", "Kobieta"),
  Wzrost = c(165, 180, 170, 175, 168),
  Waga = c(60, 80, 65, 75, 58),
  Status_zdrowia = c("Dobry", "Średni", "Dobry", "Zły", "Dobry")
)

# 1. Wyświetlenie podstawowych informacji o ramce danych
print("Struktura ramki danych df:")
str(df)

print("Pierwsze trzy rekordy:")
print(head(df, 3))

# 2. Obliczenie średniego wieku pacjentów
sredni_wiek <- mean(df$Wiek)
print("Średni wiek pacjentów:")
print(sredni_wiek)

# 3. Filtrowanie: pacjenci z dobrym stanem zdrowia i kobiety
dobry_kobiety <- df[df$Status_zdrowia == "Dobry" & df$Płeć == "Kobieta", ]
print("Kobiety ze statusem zdrowia 'Dobry':")
print(dobry_kobiety)

# 4. Sortowanie ramki danych wg wieku malejąco
df_posortowane <- df[order(-df$Wiek), ]
print("Ramka danych posortowana malejąco według wieku:")
print(df_posortowane)

# 5. Maksymalny i minimalny wzrost
maks_wzrost <- max(df$Wzrost)
min_wzrost <- min(df$Wzrost)
print("Maksymalny wzrost:")
print(maks_wzrost)

print("Minimalny wzrost:")
print(min_wzrost)

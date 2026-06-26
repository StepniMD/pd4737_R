# Ex_13: Symulacja wzrostu populacji bakterii

# Parametry początkowe
populacja <- 100
godzina <- 0
historia_populacji <- c(populacja)  # do obliczenia średniego wzrostu

# Pętla symulacyjna
repeat {
  # Zwiększ godzinę
  godzina <- godzina + 1
  
  # Poprzednia populacja
  poprzednia <- populacja
  
  # Podwojenie
  populacja <- populacja * 2
  
  # Zapis historii
  historia_populacji <- c(historia_populacji, populacja)
  
  # Oblicz wzrost
  wzrost <- populacja - poprzednia
  
  # Wydruk danych dla godziny
  cat(paste0("Godzina: ", godzina, "\n"))
  cat(paste0("Liczba bakterii: ", populacja, "\n"))
  cat(paste0("Wzrost o ", wzrost, " bakterii od poprzedniej godziny\n\n"))
  
  # Sprawdzenie warunków zakończenia
  if (godzina == 10 || populacja > 100000) {
    break
  }
}

# Podsumowanie
sredni_wzrost <- round(mean(diff(historia_populacji)), 2)

cat("=== PODSUMOWANIE ===\n")
cat(paste0("Czas trwania symulacji: ", godzina, " godzin\n"))
cat(paste0("Końcowa liczba bakterii: ", populacja, "\n"))
cat(paste0("Średni wzrost populacji na godzinę: ", sredni_wzrost, " bakterii\n"))

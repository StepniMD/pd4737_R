# Ex_12: Praktyczne wykorzystanie instrukcji warunkowych

klasyfikuj_probe <- function(stezenie_dna, jakosc_dna) {
  if (stezenie_dna > 50 && jakosc_dna > 7) {
    return("Próbka wysokiej jakości - nadaje się do sekwencjonowania")
  } else if (stezenie_dna >= 20 && stezenie_dna <= 50 && jakosc_dna >= 5 && jakosc_dna <= 7) {
    return("Próbka średniej jakości - wymaga optymalizacji")
  } else if (stezenie_dna < 20 && jakosc_dna < 5) {
    return("Próbka niskiej jakości - nie nadaje się do dalszych badań")
  } else {
    return("Próbka wymaga ponownej weryfikacji")
  }
}

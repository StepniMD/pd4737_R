# Ex_6: Przekształcenia typów danych

library(readxl)

# Wczytanie arkusza "Metadane" (arkusz 2)
geny_metadane <- read_excel("geny.xlsx", sheet = 2)

# 1. Długość genu = End - Start
geny_metadane$Dlugosc_genu <- geny_metadane$End - geny_metadane$Start

# 2. Kategoria genu jako factor z przedziałami
geny_metadane$Kategoria_genu <- cut(
  geny_metadane$Dlugosc_genu,
  breaks = c(-Inf, 100000, 300000, Inf),
  labels = c("Krótki", "Średni", "Długi")
)

# 3. Strand binarny: + → 1, - → -1
geny_metadane$Strand_binarny <- ifelse(geny_metadane$Strand == "+", 1, -1)

# 4. Data odkrycia
daty <- c("1990.12.15", "1979.04.22", "1983.06.10", "1986.09.05",
          "2002.03.18", "1997.11.30", "1995.08.12", "1988.07.25")
geny_metadane$Data_odkrycia <- as.Date(daty[1:nrow(geny_metadane)], format = "%Y.%m.%d")

# Podgląd wyników
print(head(geny_metadane))

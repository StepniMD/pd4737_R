# Ex_9: Operacje dplyr na danych RNA-seq

library(dplyr)
rna_seq_data <- read.csv("rna_seq_data.csv", stringsAsFactors = FALSE)

# 1. Wybierz geny z P_value < 0.05
# 2. Z tych genów wybierz te z Sample_Quality == "high"
# 3. Wybierz kolumny: Gene_Symbol, Expression_Level, Log2FC, Gene_Type
# 4. Grupuj po Gene_Type
# 5. Oblicz średnią ekspresję
# 6. Dodaj kolumnę z liczbą genów w grupie
# 7. Posortuj malejąco według średniej ekspresji

podsumowanie <- rna_seq_data %>%
  filter(P_value < 0.05) %>%
  filter(Sample_Quality == "high") %>%
  select(Gene_Symbol, Expression_Level, Log2FC, Gene_Type) %>%
  group_by(Gene_Type) %>%
  summarise(
    Średnia_Ekspresja = mean(Expression_Level, na.rm = TRUE),
    Liczba_Genów = n()
  ) %>%
  arrange(desc(Średnia_Ekspresja))

print(podsumowanie)

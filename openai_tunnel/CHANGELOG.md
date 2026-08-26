# Changelog

## 0.0.12-4

- Poprawiono migrację z wersji `0.0.12-2`: nowe pole tokenu Home Assistanta jest
  opcjonalne podczas instalacji aktualizacji.
- Dodatek nadal odmówi uruchomienia do czasu zapisania prawidłowego tokenu, ale
  sama aktualizacja nie jest już blokowana przez brak nowej opcji.

## 0.0.12-3

- Dodano lokalną, niedostępną z sieci bramkę uwierzytelniającą dla endpointu MCP.
- Token dedykowanego użytkownika Home Assistanta jest maskowany i nie trafia do
  logów ani repozytorium.
- Tunel może być dodany w ChatGPT z opcją „Brak uwierzytelnienia”, bez publicznego
  wystawiania serwera OAuth Home Assistanta.

## 0.0.12-2

- Poprawiono wewnętrzny adres Home Assistant Core: dodatki używają portu 80,
  mimo że interfejs w sieci LAN działa na porcie 8123.
- Dodano automatyczną korektę adresu zapisanego przez wersję `0.0.12-1`, dzięki
  czemu aktualizacja nie wymaga ponownego wprowadzania konfiguracji.

## 0.0.12-1

- Pierwsza wersja dodatku.
- Oficjalny klient OpenAI `v0.0.12` przypięty do konkretnej wersji.
- Automatyczny start, watchdog i bezpieczne opcje dla Home Assistanta.

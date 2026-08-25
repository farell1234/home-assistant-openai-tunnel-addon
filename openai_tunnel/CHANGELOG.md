# Changelog

## 0.0.12-3

- Dodano lokalny reverse proxy, który uwierzytelnia wywołania MCP systemowym
  tokenem Home Assistanta.
- Usunięto potrzebę publicznego OAuth Home Assistanta oraz ręcznego tokenu
  długoterminowego.
- Proxy nasłuchuje wyłącznie na interfejsie loopback kontenera i nie ujawnia
  tokenu usłudze tunelowej.

## 0.0.12-2

- Poprawiono wewnętrzny adres Home Assistant Core: dodatki używają portu 80,
  mimo że interfejs w sieci LAN działa na porcie 8123.
- Dodano automatyczną korektę adresu zapisanego przez wersję `0.0.12-1`, dzięki
  czemu aktualizacja nie wymaga ponownego wprowadzania konfiguracji.

## 0.0.12-1

- Pierwsza wersja dodatku.
- Oficjalny klient OpenAI `v0.0.12` przypięty do konkretnej wersji.
- Automatyczny start, watchdog i bezpieczne opcje dla Home Assistanta.

# Home Assistant OpenAI Secure MCP Tunnel

Prywatny klient tunelu OpenAI uruchamiany jako dodatek Home Assistanta.

Dodatek:

- uruchamia oficjalny `openai/tunnel-client` w wersji `v0.0.12`,
- łączy się wychodząco z OpenAI przez HTTPS,
- przekazuje żądania do lokalnego serwera MCP Home Assistanta,
- startuje automatycznie razem z Home Assistant OS,
- nie wymaga komputera z Windows ani publicznego portu MCP.

## Instalacja

1. W Home Assistant otwórz **Ustawienia → Aplikacje → Sklep aplikacji**.
2. Dodaj repozytorium:

   `https://github.com/farell1234/home-assistant-openai-tunnel-addon`

3. Zainstaluj **OpenAI Secure MCP Tunnel**.
4. W konfiguracji dodatku wpisz:

   - identyfikator tunelu z OpenAI Platform,
   - klucz runtime API zapisany w menedżerze haseł,
   - token długoterminowy dedykowanego, nieadministracyjnego użytkownika Home
     Assistanta.
5. Włącz **Uruchamiaj przy starcie**, **Watchdog** i uruchom dodatek.

Klucza API nigdy nie dodawaj do GitHuba, pliku README ani zgłoszeń błędów.

## Lokalna bramka uwierzytelniająca

Dodatek przekazuje wyłącznie żądania do endpointu `/api/mcp/assist` i lokalnie
dodaje token Home Assistanta. Bramka nasłuchuje tylko wewnątrz kontenera, dlatego
nie otwiera dodatkowego portu w sieci LAN ani w routerze.

## Diagnostyka

Stan klienta sprawdzisz w zakładce **Dziennik** dodatku. Port `18080` na hoście jest używany wyłącznie do kontroli zdrowia przez watchdog; zdalny interfejs administracyjny pozostaje domyślnie wyłączony.

## Bezpieczeństwo

- Oba klucze są polami typu `password` w opcjach dodatku.
- Token Home Assistanta należy do osobnego użytkownika bez uprawnień administratora.
- Lokalna bramka przekazuje tylko metody MCP na ścieżce `/api/mcp/assist`.
- Surowe logowanie HTTP jest wyłączone.
- Interfejs administracyjny klienta nie jest dostępny z sieci LAN.
- Nie są otwierane ani przekierowywane porty routera do Internetu.

Dokumentacja OpenAI: <https://developers.openai.com/api/docs/guides/secure-mcp-tunnels>

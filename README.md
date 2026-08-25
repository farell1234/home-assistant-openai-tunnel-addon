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
   - pozostaw domyślny adres MCP, jeśli Home Assistant działa na tym samym urządzeniu.
5. Włącz **Uruchamiaj przy starcie**, **Watchdog** i uruchom dodatek.

Klucza API nigdy nie dodawaj do GitHuba, pliku README ani zgłoszeń błędów.

## Domyślny serwer MCP

`http://homeassistant:8123/api/mcp/assist`

Jest to lokalny endpoint integracji **Model Context Protocol Server** Home Assistanta.

## Diagnostyka

Stan klienta sprawdzisz w zakładce **Dziennik** dodatku. Port `18080` na hoście jest używany wyłącznie do kontroli zdrowia przez watchdog; zdalny interfejs administracyjny pozostaje domyślnie wyłączony.

## Bezpieczeństwo

- Klucz jest polem typu `password` w opcjach dodatku.
- Surowe logowanie HTTP jest wyłączone.
- Interfejs administracyjny klienta nie jest dostępny z sieci LAN.
- Nie są otwierane ani przekierowywane porty routera do Internetu.

Dokumentacja OpenAI: <https://developers.openai.com/api/docs/guides/secure-mcp-tunnels>

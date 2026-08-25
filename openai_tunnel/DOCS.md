# OpenAI Secure MCP Tunnel

## Konfiguracja

### `control_plane_tunnel_id`

Identyfikator tunelu utworzonego w OpenAI Platform. Ma postać `tunnel_` oraz 32 małych znaków szesnastkowych.

### `control_plane_api_key`

Dedykowany klucz runtime API klienta tunelu. Wklej go wyłącznie tutaj. Pole jest maskowane przez Home Assistanta.

### `mcp_server_url`

Adres lokalnego serwera MCP. Dla Home Assistanta na tym samym urządzeniu pozostaw:

`http://homeassistant:8123/api/mcp/assist`

### `log_level`

Używaj `info`. Włącz `debug` tylko tymczasowo podczas diagnostyki. Surowe logowanie HTTP pozostaje wyłączone.

## Po zapisaniu konfiguracji

1. Włącz **Uruchamiaj przy starcie**.
2. Włącz **Watchdog**.
3. Uruchom dodatek.
4. Otwórz **Dziennik** i sprawdź, czy nie ma błędu uwierzytelnienia lub połączenia z MCP.

Nie publikuj klucza API ani pełnego eksportu diagnostycznego.

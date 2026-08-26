# OpenAI Secure MCP Tunnel

## Konfiguracja

### `control_plane_tunnel_id`

Identyfikator tunelu utworzonego w OpenAI Platform. Ma postać `tunnel_` oraz 32 małych znaków szesnastkowych.

### `control_plane_api_key`

Dedykowany klucz runtime API klienta tunelu. Wklej go wyłącznie tutaj. Pole jest maskowane przez Home Assistanta.

### `home_assistant_access_token`

Token długoterminowy utworzony na koncie dedykowanego, nieadministracyjnego
użytkownika Home Assistanta. Wklej go wyłącznie w konfiguracji dodatku. Pole jest
maskowane, a wartość nie trafia do logów.

Dodatek udostępnia klientowi tunelu wyłącznie endpoint `/api/mcp/assist` i dodaje
token lokalnie. W ChatGPT wybierz uwierzytelnianie **Brak uwierzytelnienia** —
transport pozostaje ograniczony do tunelu przypisanego do Twojej organizacji i
przestrzeni roboczej OpenAI.

### `log_level`

Używaj `info`. Włącz `debug` tylko tymczasowo podczas diagnostyki. Surowe logowanie HTTP pozostaje wyłączone.

## Po zapisaniu konfiguracji

1. Włącz **Uruchamiaj przy starcie**.
2. Włącz **Watchdog**.
3. Uruchom dodatek.
4. Otwórz **Dziennik** i sprawdź, czy tunel jest połączony, a inicjalizacja MCP
   nie zwraca błędu `Unauthorized`.

Nie publikuj klucza API ani pełnego eksportu diagnostycznego.

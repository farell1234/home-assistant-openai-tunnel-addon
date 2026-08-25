#!/bin/sh
set -eu

OPTIONS_FILE="/data/options.json"

if [ ! -r "${OPTIONS_FILE}" ]; then
  echo "[ERROR] Brak pliku opcji dodatku: ${OPTIONS_FILE}" >&2
  exit 1
fi

CONTROL_PLANE_TUNNEL_ID="$(jq -er '.control_plane_tunnel_id | select(type == "string" and length > 0)' "${OPTIONS_FILE}")"
CONTROL_PLANE_API_KEY="$(jq -er '.control_plane_api_key | select(type == "string" and length > 0)' "${OPTIONS_FILE}")"
MCP_SERVER_URL="$(jq -er '.mcp_server_url | select(type == "string" and length > 0)' "${OPTIONS_FILE}")"
LOG_LEVEL="$(jq -er '.log_level // "info"' "${OPTIONS_FILE}")"

# Home Assistant udostępnia interfejs użytkownikom w sieci LAN na porcie 8123,
# ale dodatki łączą się z kontenerem Core przez wewnętrzny port 80. Zachowujemy
# zgodność z konfiguracją zapisaną przez pierwszą wersję dodatku.
case "${MCP_SERVER_URL}" in
  http://homeassistant:8123/*)
    MCP_SERVER_URL="http://homeassistant/${MCP_SERVER_URL#http://homeassistant:8123/}"
    echo "[INFO] Skorygowano adres MCP do wewnętrznego portu Home Assistant Core."
    ;;
esac

case "${CONTROL_PLANE_TUNNEL_ID}" in
  tunnel_[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]) ;;
  *)
    echo "[ERROR] Nieprawidłowy identyfikator tunelu." >&2
    exit 1
    ;;
esac

case "${MCP_SERVER_URL}" in
  http://*|https://*) ;;
  *)
    echo "[ERROR] Adres MCP musi zaczynać się od http:// albo https://." >&2
    exit 1
    ;;
esac

case "${LOG_LEVEL}" in
  debug|info|warn) ;;
  *)
    echo "[ERROR] Nieprawidłowy poziom logowania." >&2
    exit 1
    ;;
esac

export CONTROL_PLANE_TUNNEL_ID
export CONTROL_PLANE_API_KEY
export MCP_SERVER_URL
export LOG_LEVEL
export LOG_FORMAT="struct-text"
export HEALTH_LISTEN_ADDR=":8080"
export ALLOW_REMOTE_UI="false"
export OPEN_WEB_UI="false"
export LOG_HTTP_RAW_UNSAFE="false"
export MCP_STARTUP_WAIT_TIMEOUT="60s"

echo "[INFO] Uruchamiam OpenAI Secure MCP Tunnel."
echo "[INFO] Tunel: ${CONTROL_PLANE_TUNNEL_ID}"
echo "[INFO] Lokalny serwer MCP: ${MCP_SERVER_URL}"
echo "[INFO] Klucz API pozostaje ukryty."

exec /usr/bin/tunnel-client run

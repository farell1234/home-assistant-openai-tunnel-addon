#!/bin/sh
set -eu

OPTIONS_FILE="/data/options.json"

if [ ! -r "${OPTIONS_FILE}" ]; then
  echo "[ERROR] Brak pliku opcji dodatku: ${OPTIONS_FILE}" >&2
  exit 1
fi

CONTROL_PLANE_TUNNEL_ID="$(jq -er '.control_plane_tunnel_id | select(type == "string" and length > 0)' "${OPTIONS_FILE}")"
CONTROL_PLANE_API_KEY="$(jq -er '.control_plane_api_key | select(type == "string" and length > 0)' "${OPTIONS_FILE}")"
HOME_ASSISTANT_ACCESS_TOKEN="$(jq -er '.home_assistant_access_token | select(type == "string" and length > 0)' "${OPTIONS_FILE}")"
LOG_LEVEL="$(jq -er '.log_level // "info"' "${OPTIONS_FILE}")"
MCP_SERVER_URL="http://127.0.0.1:18081/api/mcp/assist"

case "${CONTROL_PLANE_TUNNEL_ID}" in
  tunnel_[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]) ;;
  *)
    echo "[ERROR] Nieprawidłowy identyfikator tunelu." >&2
    exit 1
    ;;
esac

case "${HOME_ASSISTANT_ACCESS_TOKEN}" in
  *[!A-Za-z0-9._-]*|"")
    echo "[ERROR] Token Home Assistanta ma nieprawidłowy format." >&2
    exit 1
    ;;
  *) ;;
esac

case "${MCP_SERVER_URL}" in
  http://127.0.0.1:18081/api/mcp/assist) ;;
  *)
    echo "[ERROR] Nieprawidłowy wewnętrzny adres MCP." >&2
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

sed "s|__HOME_ASSISTANT_ACCESS_TOKEN__|${HOME_ASSISTANT_ACCESS_TOKEN}|g" \
  /etc/nginx/nginx.conf.template > /tmp/nginx.conf

mkdir -p /tmp/nginx-client-body /tmp/nginx-proxy
nginx -t -c /tmp/nginx.conf
nginx -c /tmp/nginx.conf &
NGINX_PID="$!"
trap 'kill "${NGINX_PID}" 2>/dev/null || true' EXIT INT TERM

ATTEMPT=0
until wget -q -O /dev/null http://127.0.0.1:18081/healthz-local; do
  ATTEMPT=$((ATTEMPT + 1))
  if [ "${ATTEMPT}" -ge 20 ]; then
    echo "[ERROR] Lokalna bramka uwierzytelniająca nie uruchomiła się." >&2
    exit 1
  fi
  sleep 0.1
done

echo "[INFO] Uruchamiam OpenAI Secure MCP Tunnel."
echo "[INFO] Tunel: ${CONTROL_PLANE_TUNNEL_ID}"
echo "[INFO] Lokalny serwer MCP: chroniona bramka Home Assistanta."
echo "[INFO] Klucze OpenAI i Home Assistanta pozostają ukryte."

exec /usr/bin/tunnel-client run

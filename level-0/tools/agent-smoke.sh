#!/usr/bin/env bash
# Prueba de humo del agente: comprueba que el modelo elegido sirve para este roadmap.
#
# No instala nada. Verifica que el CLI esté disponible, que sepas qué proveedor y
# modelo estás usando, y que el modelo pueda **leer, editar y ejecutar** comandos,
# que es lo que el roadmap le va a pedir.
#
# Uso:  bash tools/agent-smoke.sh            (interactivo: tú pides el cambio)
#       bash tools/agent-smoke.sh --print    (una sola pregunta, sin sesión)
set -uo pipefail

print_mode=0
[ "${1:-}" = "--print" ] && print_mode=1

ok()   { printf '  \033[32mOK\033[0m   %s\n' "$1"; }
warn() { printf '  \033[33mWARN\033[0m %s\n' "$1"; }
fail() { printf '  \033[31mFAIL\033[0m %s\n' "$1"; FALLAS=$((FALLAS + 1)); }
FALLAS=0

echo "== prueba de humo del agente"
echo

# ---------------------------------------------------------------- 1. el CLI
if command -v claude >/dev/null 2>&1; then
  ok "claude disponible ($(claude --version 2>/dev/null | head -1))"
else
  fail "claude no está en el PATH: instálalo con https://claude.ai/install.sh"
  exit 1
fi

# ----------------------------------------------------------- 2. el proveedor
if [ -n "${ANTHROPIC_BASE_URL:-}" ]; then
  ok "proveedor alternativo: $ANTHROPIC_BASE_URL"
  printf '       modelo: %s\n' "${ANTHROPIC_MODEL:-<alias por defecto>}"
else
  ok "proveedor Anthropic (por defecto)"
fi

if [ -n "${ANTHROPIC_API_KEY:-}${ANTHROPIC_AUTH_TOKEN:-}" ]; then
  ok "credencial presente en el entorno"
else
  warn "sin ANTHROPIC_API_KEY ni ANTHROPIC_AUTH_TOKEN: se usará la sesión de claude"
fi

# ------------------------------------------------------------- 3. el modelo
target="agent-smoke.txt"
printf 'modelo=desconocido\n' > "$target"
ok "archivo de prueba creado: $target"

prompt="Lee $target, reemplaza la palabra 'desconocido' por 'ok' y responde solo con el contenido final del archivo."

if [ "$print_mode" -eq 1 ]; then
  echo "  ejecutando en modo print..."
  claude -p "$prompt" >/dev/null 2>&1
else
  echo
  echo "  Abre otra terminal y pide al agente:"
  echo "    \"$prompt\""
  echo
  printf '  Cuando termine, pulsa ENTER para verificar. '
  read -r _
fi

# ---------------------------------------------------------- 4. verificación
if grep -q 'modelo=ok' "$target" 2>/dev/null; then
  ok "el agente pudo editar el archivo"
else
  fail "el agente no editó el archivo (contenido: $(cat "$target" 2>/dev/null))"
  echo
  echo "  Posibles causas:"
  echo "   - el modelo no soporta bien tool calling"
  echo "   - el proveedor no habla el protocolo Anthropic Messages (/v1/messages)"
  echo "   - la credencial es inválida o el límite de uso se agotó"
fi

rm -f "$target"

echo
if [ "$FALLAS" -eq 0 ]; then
  printf '\033[32magente listo\033[0m para el roadmap.\n'
  exit 0
else
  printf '\033[31m%d fallas\033[0m: revisa la configuración antes de empezar.\n' "$FALLAS"
  exit 1
fi

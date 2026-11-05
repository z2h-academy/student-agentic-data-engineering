# student-agentic-data-engineering

> Repositorio de trabajo del roadmap **Agentic Data Engineering** de Z2H Academy.

Este repositorio es un **template**. No contiene código: lo construyes tú a medida que avanzas por el roadmap.

## Cómo empezar

1. Haz **fork** de este repositorio en tu cuenta de GitHub.
2. Abre tu fork en Codespaces o clónalo en tu máquina.
3. Sigue las secciones del Level 0 desde TUTOR.

```bash
# en Codespaces el workspace ya es /workspaces/student-agentic-data-engineering
# en local:
git clone git@github.com:<tu-usuario>/student-agentic-data-engineering.git
cd student-agentic-data-engineering
```

## Qué vas a construir

**Meridian**, una plataforma de datos para un e-commerce ficticio:

| Nivel | Artefacto |
|---|---|
| 0 | Entorno reproducible y primer pipeline con evidencia |
| 1 | Lakehouse bronze → silver → gold con contratos y políticas |
| 2 | Agentes de profiling, contrato, calidad y remediación |
| 3 | Pipeline orquestado con recuperación ante fallos |
| 4 | Corpus documental consultable con citas |
| 5 | Stream de eventos enriquecido con LLM |
| 6 | Analítica en lenguaje natural con SQL validado |
| 7 | Capstone operado con gates verdes |

## Cómo trabajas

El roadmap se recorre con un **coding agent** en tu terminal. La referencia es Claude Code,
pero cualquier agente que lea `AGENTS.md` y hable MCP sirve.

```bash
curl -fsSL https://claude.ai/install.sh | bash
cd level-0 && bash tools/agent-smoke.sh --print
```

### Elige tu modelo

El modelo no viene impuesto. Los tres proveedores documentados hablan el protocolo que
Claude Code usa:

| Proveedor | `ANTHROPIC_BASE_URL` | Modelo |
|---|---|---|
| Anthropic | *(sin definir)* | `sonnet` |
| DeepSeek | `https://api.deepseek.com/anthropic` | `deepseek-flash` |
| MiniMax | `https://api.minimax.io/anthropic` | `MiniMax-M3.1-Flash` |

```bash
# ejemplo con DeepSeek
export ANTHROPIC_BASE_URL=https://api.deepseek.com/anthropic
export ANTHROPIC_AUTH_TOKEN=<tu-key>
export ANTHROPIC_MODEL=deepseek-flash
```

Antes de empezar, comprueba que el modelo sirve:

```bash
bash level-0/tools/agent-smoke.sh
```

### Qué hay en el repositorio

| Archivo | Para qué |
|---|---|
| `AGENTS.md` | las reglas que tu agente lee antes de tocar nada |
| `.mcp.json` | la conexión con TUTOR, que sirve el material del curso |
| `.claude/settings.json` | permisos: no leer `.env`, pedir confirmación antes de un push |

## Qué NO es este roadmap

- **No enseña a construir un harness de agentes.** Usas uno; no lo diseñas.
- **No enseña a crear un agente runtime.** Construyes un servidor MCP en el Level 6, que es una pieza distinta: expone herramientas, no razona.
- **No depende de un proveedor de modelos.** Los laboratorios corren con `make`, sin LLM.

## Reglas

1. El repositorio arranca vacío a propósito: el entorno y los datos los creas siguiendo las secciones.
2. No subes credenciales. Usa un `.env` local a partir del ejemplo que cada nivel indique.
3. Cada nivel se cierra con la evidencia descrita en su README.
4. Un cambio que no pasa su smoke no está terminado, aunque el agente diga que sí.

## Documentación

El contenido vive en el repositorio privado de la academia y se consulta con TUTOR. Aquí solo vive tu código.

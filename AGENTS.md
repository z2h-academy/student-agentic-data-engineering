# AGENTS.md — reglas del repositorio

> Este archivo lo lee tu agente de código antes de tocar nada. Editarlo es parte del
> trabajo: si una regla no aplica, se borra; si aparece una excepción, se escribe aquí.

## Qué es este repositorio

Tu fork de **Agentic Data Engineering**. Aquí construyes el sistema. El material del
curso no vive aquí: se consulta con TUTOR.

## Dónde trabaja el agente

En la raíz de tu fork, con Claude Code:

```bash
claude
```

Si tu repo tiene `CLAUDE.md`, Claude Code ignora este archivo. Mantén uno solo:
o usas `AGENTS.md` (recomendado) o creas un `CLAUDE.md` que lo importe con `@AGENTS.md`.

## Reglas

1. **Una tarea por sesión.** El nivel se cierra por secciones, no de una vez.
2. **Especificación antes de código.** Si el pedido no dice qué se acepta y qué se
   rechaza, primero se escribe la especificación.
3. **No inventes comandos ni versiones.** Si no está en el repositorio, no existe.
4. **`level-*/data/` y `warehouse/` son salidas.** No se editan a mano.
5. **La evidencia manda.** Un paso no está terminado porque no falló; está terminado
   cuando hay salida registrada.

## Qué no tocar

- `.env` y cualquier credencial. Nunca se versionan ni se leen.
- `level-0/data/samples/` sin justificarlo: es la entrada del primer pipeline.
- Archivos de otros niveles cuando la tarea es de uno solo.

## Cómo se comprueba un cambio

Cada nivel tiene su comando. Ejemplo del Level 0:

```bash
cd level-0 && bash smoke.sh && bash scripts/doctor.sh
```

Si el smoke no está verde, no se sigue. Antes de empezar, `bash level-0/tools/agent-smoke.sh`
comprueba que el modelo puede leer, editar y ejecutar.

## Cómo consultar el material

El contenido del roadmap está en TUTOR, expuesto por MCP (ver `.mcp.json`). Pregunta
por la sección que estás haciendo en lugar de suponer su contenido.

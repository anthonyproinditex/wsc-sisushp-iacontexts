# Prompt genérico para investigación

## Propósito

Se usa cuando el agente necesita comprender mejor una historia, contexto del dominio, dependencias existentes o cómo se ha resuelto algo similar antes.

## Prompt base

```text
Necesito analizar la historia {JIRA_KEY} y su contexto técnico y funcional para identificar:
- el problema de negocio,
- los actores implicados,
- los flujos principales y alternativos,
- los servicios o APIs involucrados,
- la estructura de los datos relevantes,
- y cualquier patrón previo que se pueda reutilizar.

Haz una investigación orientada a:
1. Revisar la historia, notas y documentación disponible.
2. Identificar repositorios y componentes afectados.
3. Buscar implementaciones similares en el código o en historias previas.
4. Señalar supuestos, riesgos y decisiones a validar con el negocio o con ingeniería.
5. Entregar una síntesis clara y útil para implementación.
```

## Resultado esperado

- Resumen ejecutivo.
- Alcance y riesgos.
- Puntos de decisión.
- Réplicas para implementación y prueba.

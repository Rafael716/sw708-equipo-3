## Resumen
<!-- Qué cambia y por qué (1–3 viñetas). -->

-

## Tipo de cambio
- [ ] `feat` — funcionalidad
- [ ] `fix` — corrección
- [ ] `docs` — documentación
- [ ] `chore` — CI, deps, limpieza
- [ ] `refactor` — sin cambio de comportamiento

## Checklist (Guía de Git / observaciones docente)
- [ ] La rama sigue `tipo/numero-descripcion` (minúsculas y guiones), p. ej. `fix/12-di-incidencias`
- [ ] Partí de `develop` (o de `main` solo si aún no existe `develop`) y está actualizada (`git pull`)
- [ ] El código **no** entra directo a `main`: este PR es el camino
- [ ] El mensaje de commit dice qué cambió (evitar «bitacora», «update(src)», «completando recuadro»)
- [ ] Commits hechos con mi cuenta (nombre completo + correo `@uni.pe` en `git config`)
- [ ] CI en verde (`.github/workflows/backend-arch.yml`) si toqué backend

## Cómo probar
<!-- Comandos o pasos manuales. -->

```bash
cd src/repo/app && pnpm --filter backend test
```

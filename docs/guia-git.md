# Guía rápida de Git (punto 6 de la revisión)

## Flujo

1. Trabajo en una rama `tipo/numero-descripcion` (nunca commits de código directo en `main`).
2. Abrir **Pull Request** hacia `develop` (o `main` mientras se crea `develop`).
3. CI verde + revisión → merge (preferir squash en PRs de docs de revisión docente).

## Qué sí puede vivir en `.github/`

| Pieza | Rol |
|---|---|
| `pull_request_template.md` | Recuerda checklist al abrir el PR |
| `workflows/pr-guard.yml` | Falla el check si la rama no sigue la convención |
| `workflows/backend-arch.yml` | Tests + dependency-cruiser |

## Qué NO es un archivo del repo (hay que configurarlo en GitHub)

En el repo del equipo (**Settings → Rules → Rulesets** o **Branches → Branch protection**), el coordinador/`admin` debe activar para `main` (y `develop`):

- **Require a pull request before merging**
- Require status checks (al menos `Backend tests y arquitectura` / `PR guard`)

Sin eso, GitHub sigue permitiendo `git push` directo a `main` aunque exista la plantilla.

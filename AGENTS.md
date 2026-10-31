# Repository instructions

## Commits

- Use the Conventional Commits format for every commit: `type(optional-scope): description`.
- Choose the type that best describes the change, such as `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `build`, `ci`, `perf`, or `chore`.
- This is a personal project. Rewriting unshared local Git history is permitted when requested; confirm before rewriting history that has been pushed or otherwise shared.

## Amp orbs

- In an orb, the `site` service in `.amp/services.yaml` serves the local `Caddyfile` through the portal. After changing `Caddyfile`, run `amp orb service restart site` instead of `caddy reload --config Caddyfile`: a reload from an agent shell drops the service's `SITE_ADDRESS` and leaves portal requests unmatched.

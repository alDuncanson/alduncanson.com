# alduncanson.com

The source for [alduncanson.com](https://alduncanson.com), a personal website built for writing about and experimenting with fundamental web technologies.

## Stack

- Hypertext
- [Caddy](https://caddyserver.com/) for local and production serving
- [Nix](https://nixos.org/) for the reproducible development environment
- Virtual machine hosted

More details are hiding in [`humans.txt`](https://alduncanson.com/humans.txt).

## Repository layout

```text
.
├── public/                 Files deployed to the document root
├── Caddyfile               Local Caddy configuration
├── Caddyfile.production    Production Caddy configuration
├── flake.nix               Development environment and local server
└── CONTRIBUTING.md         Workflow and deployment notes
```

Only the contents of `public/` are served in production.

## Local development

With Nix installed, start the site from the repository root:

```sh
nix run
```

Then open <http://localhost:8080>.

Alternatively, enter the development shell and run Caddy directly:

```sh
nix develop
caddy run --config Caddyfile
```

Static file changes are visible on refresh. After changing `Caddyfile`, reload the running server:

```sh
caddy reload --config Caddyfile
```

## Current features

- Zstandard and gzip response compression
- A custom `404` response
- A preference-aware SVG favicon
- Light and dark browser color-scheme support
- `robots.txt`, `sitemap.xml`, `humans.txt`, and `security.txt`
- One small HTTP teapot

See [CONTRIBUTING.md](CONTRIBUTING.md) for project conventions and deployment commands.

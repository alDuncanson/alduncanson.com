# Contributing

This is a personal website and a place to explore the web platform directly. Changes should remain understandable without an application framework, client-side dependency graph, or build step.

## Principles

- Prefer semantic HTML and native browser behavior.
- Add JavaScript only when it is the appropriate platform capability.
- Keep assets small and dependencies intentional.
- Preserve accessibility and useful HTTP semantics.
- Do not commit credentials, private host details, licensed assets, or generated local state.
- Use [Conventional Commits](https://www.conventionalcommits.org/) for commit messages.

## Local workflow

Start the development server:

```sh
nix run
```

Validate both Caddy configurations before committing configuration changes:

```sh
nix develop --command caddy validate --config Caddyfile
nix develop --command caddy validate --config Caddyfile.production
```

Check the Nix flake after changing the development environment:

```sh
nix flake check
```

## Maintainer deployment

The Git checkout, public document root, and active Caddy configuration are deliberately separate:

```text
/opt/alduncanson.com/    Git checkout
/var/www/html/           Public document root
/etc/caddy/Caddyfile     Active Caddy configuration
```

### Initial checkout

Create a checkout owned by the current server user:

```sh
sudo install -d -o "$USER" -g "$(id -gn)" /opt/alduncanson.com
git clone https://github.com/alDuncanson/alduncanson.com.git /opt/alduncanson.com
cd /opt/alduncanson.com
```

### Deploy site files

Preview the synchronization first:

```sh
sudo rsync \
  -an \
  --delete \
  --itemize-changes \
  --chown=root:root \
  public/ \
  /var/www/html/
```

Then deploy:

```sh
sudo rsync \
  -a \
  --delete \
  --chown=root:root \
  public/ \
  /var/www/html/
```

The trailing slash copies the contents of `public/`, including `.well-known`. The `--delete` flag means `/var/www/html` must contain only files managed by this repository.

### Deploy the Caddy configuration

```sh
caddy validate --config Caddyfile.production

sudo install \
  -o root \
  -g root \
  -m 0644 \
  Caddyfile.production \
  /etc/caddy/Caddyfile

sudo caddy validate --config /etc/caddy/Caddyfile
sudo systemctl reload caddy
```

Static-only changes do not require a Caddy reload.

### Subsequent deployments

```sh
cd /opt/alduncanson.com
git pull --ff-only

sudo rsync \
  -a \
  --delete \
  --chown=root:root \
  public/ \
  /var/www/html/
```

After deployment, verify representative responses:

```sh
curl -I https://alduncanson.com/
curl -I https://alduncanson.com/does-not-exist
curl -i https://alduncanson.com/coffee
```

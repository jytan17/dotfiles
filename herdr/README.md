# Herdr

[Herdr](https://herdr.dev) is a mouse-friendly terminal multiplexer with first-class support for running AI coding agents in parallel.

## Setup

```sh
stow herdr
```

Stows `config.toml` to `~/.config/herdr/config.toml`.

## Dependencies / External Setup

- `herdr` binary (installed via Homebrew: `brew install herdr`). Verified against `herdr 0.7.5`.

## File Structure

| File | Purpose |
|------|---------|
| `.config/herdr/config.toml` | Main config. Currently the unmodified default template (every setting present but commented out). |

## Notable Settings

The config is the output of `herdr --default-config` — a fully documented template with all options commented out, so Herdr runs on its built-in defaults. Uncomment settings to customize.

Regenerate/refresh the template with:

```sh
herdr --default-config > ~/.config/herdr/config.toml
```

After editing, apply changes without a full restart:

```sh
herdr server reload-config
```

The prefix key (default `ctrl+b`) enters prefix mode; `prefix+?` shows active keybindings.

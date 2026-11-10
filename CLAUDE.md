# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

Darren's dotfiles and machine bootstrap, managed entirely by **mise** (`mise dot` for dotfiles,
`mise bootstrap` for apt sources/packages, `mise run` for tasks). There is no build or test suite;
the checks below are the regression gate.

## Commands

Run mise against this repo with `-C ~/code/dotfiles` (aliased in `home/bashrc.d/45-dot.sh`):

```bash
dot status                       # mise -C ~/code/dotfiles dot status: what's declared/applied
dot apply                        # (re)create links and copies
dotrun dot:check                 # shell regression check (startup, PATH, links, push.default)
dotrun doctor                    # drift: undecided ~/.config entries, stray scripts, secrets; runs dot:check too
bash mise-tasks/dot/check        # same check without mise
DOT_CHECK_PROFILE=container dotrun dot:check   # skip machine-specific checks (flyctl, Postgres env)
mise -C ~/code/dotfiles x -- gitleaks dir <path> --redact   # secret scan a path
```

Both tasks are read-only and exit 1 on any failure. Run `dotrun dot:check` after changing anything
under `home/` (shell startup) and `dotrun doctor` after adding or moving a config.

## How it fits together

- **`mise.toml` is the single source of truth.** `[dotfiles]` maps each target in `~` to a source
  in this repo. Default mode is a symlink; `mode = "copy"` is used where a tool rewrites its own
  file (`claude/settings.json`, `config/gh/config.yml`, `config/mise/config.toml`). For copy-mode
  files, edits on the machine must be pulled back with `dot add --local --changed`, and edits in
  the repo need `dot apply`.
- **Never use plain `mise dot add`**: it writes to the global config and `~/.dotfiles`. Always
  `dot add --local --source config/<app> ~/.config/<app>`.
- **`dot add` re-sorts `[dotfiles]` alphabetically.** Keep the table sorted and only put comments
  directly above the entry they describe (no group headers).
- **Repo layout:** `home/` → files in `~`, `config/` → `~/.config/*`, `claude/` → `~/.claude/*`,
  `bin/` → `~/bin` (the whole directory is one link; every script needs a shebang and `+x`,
  which doctor enforces). `archive/` holds retired configs and is not deployed.
- **Shell startup order:** `~/.bash_profile` sources `~/.profile.d/*.sh` (env and PATH, every
  login shell; `90-path.sh` runs last so `~/bin` and `~/.local/bin` lead PATH), then
  `~/.profile.local`, then `~/.bashrc`, which returns early for non-interactive shells and then
  sources `~/.bashrc.d/*.sh` and `~/.bashrc.local`. Env/PATH belongs in `profile.d`; aliases,
  functions and prompt in `bashrc.d`. Numeric prefixes set the order. `*.local` files are
  machine-specific and gitignored.
- **mise activation** lives in `profile.d/31-mise-shims.sh` and `bashrc.d/60-mise.sh`. Don't use
  `[bootstrap.mise_shell_activate]`: it refuses because `~/.bash_profile` is a managed symlink.
- **`[bootstrap.*]`** in `mise.toml` declares apt sources (each with a pinned key fingerprint;
  list every `pub` fingerprint in a keyring) and packages. `[tasks.bootstrap]` runs last on every
  `mise bootstrap` and must stay idempotent; it re-trusts the repo and sets
  `core.hooksPath githooks`.
- **Secrets:** `githooks/pre-commit` runs gitleaks on staged changes; `.gitleaks.toml` holds
  reviewed allowlist entries only. `config/gh/hosts.yml` (the gh token) is never tracked.
- **`doctor.ignore`** lists `~/.config` entries deliberately not tracked. Every `~/.config` entry
  must be either declared in `mise.toml` or listed there.
- **Trust:** mise shims (`ruby`, `node`, …) fail inside this repo until `mise trust` has run.

## Docs

- `docs/mise-notes.md`: probed mise behavior this repo depends on (apply refusing real files,
  `--force` keeping no backup, bootstrap quirks). Re-check after a mise upgrade.
- `docs/designs/dotfiles-modernization.md`: the design and decision history behind this layout.

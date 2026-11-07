# mise behavior notes (phase 0 spike)

Probed 2026-11-06 with `mise 2026.11.2 linux-x64 (2026-11-05)` and `gitleaks 8.30.1`, in a scratch HOME. Every run used `env -i` with HOME and all XDG dirs inside the scratch tree, so nothing touched the real `~`. These notes pin the behavior the [design](designs/dotfiles-modernization.md) relies on. Re-run the relevant probe after a mise upgrade.

## Dotfiles (`mise dot`)

| Behavior | Result |
|---|---|
| Repo config is read only after trust | `mise -C <repo> trust` once per machine; `--from` bootstraps trust for its own run |
| `dot add --local --source config/nvim ~/.config/nvim` (run from any cwd, with `-C <repo>`) | Moves the dir into the repo, writes `"~/.config/nvim" = { source = "config/nvim" }` to the repo `mise.toml` (relative), symlinks it back |
| Plain `mise dot add` | Defaults to the **global** config, and `dotfiles.root` defaults to `~/.dotfiles`. Don't use it in this repo |
| Symlink mode (default) | `ln -sf <repo>/<source> <target>` |
| Copy mode, edit-back | `dot add --local <target>` copies the live file back to its source; `dot add --local --changed` does it for every changed copy-mode entry |
| Apply onto an existing **real file** | Refuses the **whole apply** ("refusing to overwrite existing files (use --force)", exit 1); nothing else is applied either |
| Apply onto a **dangling symlink** | Replaced silently, no `--force` needed |
| `--force` | Overwrites real files. **No backup is kept**, so back up first (phase 1 step 4) |
| Re-apply with everything correct | "all files are applied", no-op |
| `dot status --missing` | Exit 0 when all applied, exit 1 when any entry is missing |
| `dot status --json` | `{"files":[…],"edits":[…],"history":…}`; each file has `target`, `source`, `mode`, `state` (`applied`, `missing`, …), `origin.config`. Doctor reads the declared set from `.files[].target` and `.edits[].path` |

**Trust before anything else.** Once a repo-root `mise.toml` exists, every mise shim (`python3`, `ruby`, `node`, …) run from inside the repo fails with "Config files in ~/code/dotfiles/mise.toml are not trusted" until `mise trust` runs. Found in phase 1, 2026-11-06.

**`dot add` re-sorts `[dotfiles]`.** Writing an entry rewrites the table in alphabetical key order. A comment stays attached to the key directly below it, so group headers end up labeling the wrong lines. Keep the table sorted and use only per-entry comments. Found in phase 4, 2026-11-06.

## Partial-file edits

```toml
# block from a repo file (needs template = "tera"; any other value is ignored with a WARN)
"~/.gemrc/dotfiles" = { source = "home/gemrc", template = "tera" }
# single line, appended if missing
"~/.profile/local" = { line = "[ -r ~/.profile.local ] && . ~/.profile.local" }
```

- Block markers: `# >>> mise:<name> >>> managed by mise — do not edit between markers` … `# <<< mise:<name> <<<`. `comment = "…"` changes the prefix.
- mise **does not remove** the Rakefile's old `# START GENERATED … # END GENERATED` block. It appends its own block after it. Strip the old block by hand before the first apply.
- `tera` renders the source, so a `{{` in `gemrc` would be interpreted. There is none today.

## Bootstrap

| Behavior | Result |
|---|---|
| `mise bootstrap --from file:///path/repo.git?ref=<branch> --from-dir <dir> --dry-run` | Prints only the clone and checkout. It can't preview past the clone |
| Same with `--yes` | Clones to `--from-dir`, checks out the branch (with upstream tracking `origin/<branch>`), applies dotfiles, then edits, shell activation, tools and the `bootstrap` task, exit 0. Works against a local bare clone, so the phase 3 container can test an unpushed branch |
| Global tools | `bootstrap` installs tools from `~/.config/mise/config.toml` (jq installed in the probe). No separate `mise install` needed |
| `[bootstrap.mise_shell_activate] bash = true` | Writes a `block:activate` into `~/.bash_profile`, and **refuses when `~/.bash_profile` is a symlink** ("target is a symlink; edit the real file instead"). In this repo `~/.bash_profile` is a managed symlink, so **don't use this section**. Activation stays in `profile.d/mise_shims.sh` and `bashrc.d/mise.sh` |
| `bootstrap --only <part>` | Not a flag in 2026.11.2; use `mise bootstrap <part> apply` |

### Fresh-machine findings (phase 3, ubuntu:24.04 container, 2026-11-06)

| Finding | Fix in this repo |
|---|---|
| A new user always has the distro's stock `~/.bashrc` (from `/etc/skel`), so `bootstrap --from` refuses the whole dotfiles step | README uses `--force-dotfiles`, for fresh machines only |
| `--from` trusts the repo only for its own run; afterwards `dot`/`dotrun` and mise shims inside the repo fail | `bootstrap` task runs `mise trust ~/code/dotfiles` |
| `mise` isn't on the bootstrap task's PATH on a fresh box (exit 127) | the task calls `$(command -v mise \|\| echo ~/.local/bin/mise)` |
| apt sources have no part of their own: they're applied inside `packages`, so `--skip packages` skips sources too, and `packages apply --dry-run` doesn't fetch keys | the test applied the sources (plus `jq`) for real, then ran `apt-get install --simulate` on all 29 packages: 713 to install, exit 0 |
| `architectures` is a string (`"amd64"`), not a list | fixed |
| `fingerprint` accepts a list. GitHub CLI's keyring holds two primary keys and signs with the newer one (`7F38…`), so pinning only the first one fails `apt-get update` with NO_PUBKEY | both keys are pinned. When pinning, list every `pub` fingerprint in the keyring, not just the first |

**Running bootstrap on this machine:** it writes `/etc/apt/sources.list.d/mise-<name>.sources` next to the existing `docker.list`, `github-cli.list` and so on. apt then warns about duplicate sources. Remove the old files first (back them up), and mise's files replace them.

## Secret scan (gitleaks)

- `mise x aqua:gitleaks/gitleaks@latest -- gitleaks …` works; pin it in `[tools]`.
- Today's tree (`gitleaks dir`) and full history (`gitleaks git`): **0 findings**. `.gitleaks.toml` starts empty.
- Fixture `{"env": {"GITHUB_TOKEN": "ghp_<36 random>"}}` is caught (`github-pat`, exit 1), and `--redact` prints `REDACTED`.
- `max_tokens`, `author` and `oauth` in JSON: clean (exit 0).

## Not covered yet

These need artifacts that later phases create:

- **Doctor seeded cases:** run them when `mise-tasks/doctor` exists (phase 4).
- **Restore script:** run it in a scratch HOME when phase 1's inventory script exists.
- **Staged pre-commit mode:** test `gitleaks git --pre-commit --staged` in a scratch worktree in phase 4.
- **`[bootstrap.apt.sources]` / `[bootstrap.packages]`:** the subcommands exist (`mise bootstrap packages`), but they weren't exercised, because they need root. Verify them in the phase 3 container.

import os
import subprocess

# =============================================================================
# Locale
# =============================================================================
$COLORTERM = 'truecolor'
$LANG = 'C.UTF-8'
$LC_ALL = 'C.UTF-8'

# =============================================================================
# uv settings
# =============================================================================
$UV_NATIVE_TLS = '1'

# =============================================================================
# Default editor
# =============================================================================
$EDITOR = 'nvim'
$VISUAL = 'nvim'

# =============================================================================
# Lazygit config
# =============================================================================
$LG_CONFIG_FILE = os.path.expanduser('~/.config/lazygit/config.yml')

# =============================================================================
# PATH additions
# =============================================================================
# ~/.local/bin
$PATH.insert(0, os.path.expanduser('~/.local/bin'))

# Homebrew — detect Apple Silicon, Intel, or Linuxbrew
if os.path.isfile('/opt/homebrew/bin/brew'):
    _brew_prefix = '/opt/homebrew'
elif os.path.isfile('/usr/local/bin/brew'):
    _brew_prefix = '/usr/local'
elif os.path.isdir('/home/linuxbrew/.linuxbrew'):
    _brew_prefix = '/home/linuxbrew/.linuxbrew'
else:
    _brew_prefix = None

if _brew_prefix:
    $PATH.insert(0, f'{_brew_prefix}/bin')
    $PATH.insert(0, f'{_brew_prefix}/sbin')
    $HOMEBREW_PREFIX = _brew_prefix
    $HOMEBREW_CELLAR = f'{_brew_prefix}/Cellar'
    $HOMEBREW_REPOSITORY = _brew_prefix
    # Bash completions — docker, git, gh, brew, eza, etc.
    $BASH_COMPLETIONS = [f'{_brew_prefix}/etc/bash_completion.d']

# Cargo / Rust
_cargo_env = os.path.expanduser('~/.cargo/env')
if os.path.isfile(_cargo_env):
    source-bash @(_cargo_env)

# =============================================================================
# Terminal title — just show the current directory name
# =============================================================================
$TITLE = '{cwd_base}'

# =============================================================================
# Prompt — Starship
# =============================================================================
$STARSHIP_CONFIG = os.path.expanduser('~/.config/starship/starship.toml')
execx($(starship init xonsh))

# =============================================================================
# Aliases (were fish `alias` — commands with flags)
# =============================================================================
aliases['ls'] = 'eza --icons=always --color=always'
aliases['ll'] = 'eza -l --icons=always --color=always'
aliases['la'] = 'eza -la --icons=always --color=always'
aliases['lt'] = 'eza --tree --icons=always --color=always'

# =============================================================================
# Abbreviations → aliases (fish abbr has no equivalent in xonsh)
# =============================================================================
# Git
aliases['g']     = 'git'
aliases['ga']    = ['git', 'add']
aliases['gaa']   = ['git', 'add', '--all']
aliases['gb']    = ['git', 'branch']
aliases['gcm']   = ['git', 'commit', '-m']
aliases['gco']   = ['git', 'checkout']
aliases['gd']    = ['git', 'diff']
aliases['glog']  = ['git', 'log', '--oneline', '--decorate', '--color', '--graph']
aliases['gloga'] = ['git', 'log', '--oneline', '--decorate', '--graph', '--all']
aliases['gpl']   = ['git', 'pull']
aliases['gps']   = ['git', 'push']
aliases['grs']   = ['git', 'restore']
aliases['gs']    = ['git', 'status']
aliases['gsw']   = ['git', 'switch']
aliases['gswc']  = ['git', 'switch', '-c']

# Tools
aliases['c']   = 'clear'
aliases['lg']  = 'lazygit'
aliases['ld']  = 'lazydocker'
aliases['zj']  = 'zellij'
aliases['tm']  = 'tmux'
aliases['vi']  = 'nvim'
aliases['vim'] = 'nvim'
aliases['nv']  = 'nvim'
aliases['oc']  = 'opencode'
aliases['cc']  = 'claude'

# nf — open fzf result in nvim
aliases['nf'] = ['bash', '-c', 'nvim $(fzf)']

# =============================================================================
# fzf
# =============================================================================
# fzf has no --xonsh flag; set opts directly — fzf works as a subprocess as-is
$FZF_DEFAULT_OPTS = "--bind 'ctrl-y:accept'"

# =============================================================================
# Zoxide
# =============================================================================
if $(which zoxide 2>/dev/null).strip():
    execx($(zoxide init xonsh), 'exec', __xonsh__.ctx, filename='zoxide')

# =============================================================================
# Key bindings (prompt_toolkit)
# =============================================================================
from prompt_toolkit.keys import Keys
from prompt_toolkit.filters import EmacsInsertMode, ViInsertMode

@events.on_ptk_create
def custom_keybindings(bindings, **kwargs):
    insert_mode = EmacsInsertMode() | ViInsertMode()

    # Ctrl+P — history search backward
    @bindings.add('c-p', filter=insert_mode)
    def _hist_up(event):
        event.current_buffer.history_backward(count=1)

    # Ctrl+N — history search forward
    @bindings.add('c-n', filter=insert_mode)
    def _hist_down(event):
        event.current_buffer.history_forward(count=1)

    # Ctrl+Y — accept autosuggestion
    @bindings.add('c-y', filter=insert_mode)
    def _accept_suggestion(event):
        buf = event.current_buffer
        suggestion = buf.suggestion
        if suggestion:
            buf.insert_text(suggestion.text)

    # TODO: Alt+Backspace (delete previous word) — needs more investigation.
    # On Mac/ghostty (macos-option-as-alt=true), the sequence is ('escape', 'c-h')
    # but the binding only fires once per command, not repeatably.
    # Tried: ('escape', 'backspace'), ('escape', 'c-h'), eager=True — none fully work.
    # Possibly a prompt_toolkit escape-sequence timeout issue on macOS.

# =============================================================================
# Custom functions
# =============================================================================

# mkcd — mkdir + cd combined
def mkcd(args, stdin=None):
    if not args:
        print('mkcd: missing argument')
        return 1
    os.makedirs(args[0], exist_ok=True)
    cd @(args[0])
aliases['mkcd'] = mkcd

# y — yazi wrapper that syncs CWD back to shell on exit
def _y(args, stdin=None):
    import tempfile
    tmp = tempfile.mktemp(prefix='yazi-cwd.')
    try:
        yazi @(args) --cwd-file=@(tmp)
        if os.path.isfile(tmp):
            cwd = open(tmp).read().strip()
            if cwd and cwd != os.getcwd() and os.path.isdir(cwd):
                cd @(cwd)
    finally:
        if os.path.isfile(tmp):
            os.remove(tmp)
aliases['y'] = _y

# bedrock-login — AWS SSO login and credential export
def _bedrock_login(args, stdin=None):
    aws sso login --profile bedrock
    _export = $(aws configure export-credentials --profile bedrock --format env-no-export).strip()
    for line in _export.splitlines():
        if '=' in line:
            key, _, val = line.partition('=')
            __xonsh__.env[key.strip()] = val.strip()
    __xonsh__.env['AWS_REGION'] = 'us-east-1'
aliases['bedrock-login'] = _bedrock_login

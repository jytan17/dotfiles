function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    if set -q ZELLIJ
        # Zellij no passthrough Kitty graphics. Strip terminal-identity env
        # so yazi fall back to chafa instead of garbled Kitty escapes.
        env -u TERM_PROGRAM -u TERM_PROGRAM_VERSION -u GHOSTTY_RESOURCES_DIR \
            -u GHOSTTY_BIN_DIR -u KITTY_WINDOW_ID -u KITTY_PID \
            -u WEZTERM_EXECUTABLE -u WEZTERM_PANE -u ITERM_SESSION_ID \
            yazi $argv --cwd-file="$tmp"
    else
        command yazi $argv --cwd-file="$tmp"
    end
    if read -z cwd <"$tmp"; and [ "$cwd" != "$PWD" ]; and test -d "$cwd"
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

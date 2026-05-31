# Kanata

Cross-platform keyboard remapper. Used on the laptop's built-in keyboard (and an external Air75 V3 in BT slot 2) to mirror the home-row mods (HRM) layout configured in firmware on the ZSA Voyager, so typing feels consistent across both.

Replaces a previous Karabiner-Elements + goku setup.

## Setup

```sh
stow kanata
```

Then start as a background service (auto-launches on boot, root):

```sh
sudo brew services start kanata
```

After editing config, reload via:

```sh
sudo brew services restart kanata
```

Run in the foreground for debugging (`ctrl-c` to stop):

```sh
sudo kanata --cfg ~/.config/kanata/kanata.kbd
```

Validate config without running:

```sh
kanata --cfg ~/.config/kanata/kanata.kbd --check
```

## Dependencies / External Setup

- `brew install kanata`.
- **Karabiner-DriverKit-VirtualHIDDevice** -- kanata on macOS sends events through this DriverKit extension. It is installed by the Karabiner-Elements installer on first run; the Karabiner-Elements UI itself is not needed and has been uninstalled. Verify the driver is active:

  ```sh
  systemextensionsctl list | grep karabiner
  # expect: org.pqrs.Karabiner-DriverKit-VirtualHIDDevice ... [activated enabled]
  ```

- First run will prompt for **Input Monitoring** in System Settings -> Privacy & Security. Grant it to `/opt/homebrew/bin/kanata`.
- If switching back from Karabiner-Elements: quit it via its app menu (or run `/Library/Application\ Support/org.pqrs/Karabiner-Elements/uninstall.sh`) so it stops grabbing input devices exclusively. The DriverKit driver stays.

Logs (since the service runs without a terminal):

```sh
tail -f /opt/homebrew/var/log/kanata.log
```

## File Structure

| File | Purpose |
|------|---------|
| `.config/kanata/kanata.kbd` | Main configuration |

## Key Bindings

### Caps Lock

| Tap | Hold |
|-----|------|
| Esc | (no hold action -- redundant with HRM Ctrl on D) |

### Home-row mods (GACS layout)

Tap = letter. Hold + opposite-hand key = modifier.

| Key | Tap | Hold |
|-----|-----|------|
| A | `a` | LCmd  |
| S | `s` | LOpt  |
| D | `d` | LCtrl |
| F | `f` | LShift |
| J | `j` | RShift |
| K | `k` | RCtrl |
| L | `l` | ROpt  |
| `;` | `;` | RCmd  |

Outside -> inside: Cmd, Opt, Ctrl, Shift. Shift on strongest finger (index), Cmd on weakest (pinky).

### Shift via chord (chordsv2)

For guaranteed capitals without release-order issues, simultaneous press of `F` or `J` with an opposite-hand key (within `chord-time`, default 35ms) emits Shift+key directly. Covers all opposite-hand letters, digits, and symbols.

The set `{f, j}` resolves to `Shift+J` (capital J). For capital F, use the real Shift key.

### Space-thumb nav layer

| Combo | Action |
|-------|--------|
| Tap Space | Space |
| Hold Space + H | Left  |
| Hold Space + J | Down  |
| Hold Space + K | Up    |
| Hold Space + L | Right |

Use the nav layer for vim-style movement so you do not pay HRM release-latency on repeated `jk` navigation. Chord (Shift) detection is disabled while the nav layer is held.

## Notable Settings

- **`tap-hold-release-keys`** for HRM letters. Hold engages when a key from the opposite-hand list is pressed and released while the HRM key is still held. Suppresses early hold on same-hand rolls (e.g. `fd`, `as`). Note: the hold-time timeout still engages hold after 170ms regardless of which key follows -- raise `hold-time` if same-hand typing rolls misfire as mods.
- **`concurrent-tap-hold yes`** -- allows multiple HRM keys to overlap cleanly (e.g. Ctrl+Shift+T via D+F+T).
- **`chordsv2`** for Shift+letter so capitals do not depend on tap-hold release order. `chord-time` (35ms) governs how close together the two keys must be pressed to count as a chord; above the threshold, behaviour falls back to `tap-hold-release-keys`.
- **`process-unmapped-keys yes`** -- every key not listed in `defsrc` passes through untouched. Only the keys in `defsrc` are remapped.
- **`macos-dev-names-include`** -- whitelist of keyboards kanata grabs. Voyager is intentionally not listed so its firmware HRM remains the source of truth when it is plugged in. Air75 V3 appears with different names depending on connection: `Air75 V3-1/-2/-3` for its three BT slots and `Air75 V3 Dongle` for 2.4GHz wireless; all four are whitelisted.

## Tuning Knobs

In `defvar`:

| Var | Default | Effect of raising | Effect of lowering |
|-----|---------|-------------------|--------------------|
| `tap-time`   | 200ms | More forgiving tap window | Fast keypresses turn into holds |
| `hold-time`  | 170ms | Fewer same-hand misfires when typing slowly; mods feel laggy when held alone | Faster mod engagement; more risk of mid-roll misfires |
| `chord-time` | 35ms  | More combos counted as chords (easier capitals) | Tighter overlap required (fewer accidental capitals) |

## Behaviour Summary

- Fast typing rolls on the same hand never produce mods.
- Cross-hand keypresses within 35ms produce Shift+letter via chord (e.g. F+J -> capital J).
- Cross-hand keypresses past the chord window still produce mods via tap-hold, but require releasing the trigger key before the HRM key.
- Holding an HRM key alone past 170ms engages the mod (for shift+arrow, cmd+click drag, ctrl+wheel, etc.).
- Holding space turns hjkl into arrow keys with no HRM delay -- the preferred path for vim-style navigation.

## Related

- The Voyager firmware (Oryx/QMK) is the source of truth for the HRM layout; this config mirrors it on the laptop.
- Karabiner-Elements has been uninstalled. Its DriverKit-VirtualHIDDevice extension remains because kanata depends on it.

# Kanata

Cross-platform keyboard remapper. Used on the laptop's built-in keyboard and external Air75 V3 for two things only: Caps as Esc/Ctrl and a Space-held nav layer for vim-style arrows. Home-row mods live in firmware on the ZSA Voyager and are not mirrored here.

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
| Esc | LCtrl |

### Space-thumb nav layer

| Combo | Action |
|-------|--------|
| Tap Space | Space |
| Hold Space + H | Left  |
| Hold Space + J | Down  |
| Hold Space + K | Up    |
| Hold Space + L | Right |

## Notable Settings

- **`process-unmapped-keys yes`** -- every key not listed in `defsrc` passes through untouched.
- **`concurrent-tap-hold yes`** -- allows tap-hold keys to overlap cleanly (e.g. Ctrl from Caps held while Space taps).
- **`macos-dev-names-include`** -- whitelist of keyboards kanata grabs. Voyager is intentionally not listed so its firmware HRM remains the source of truth when it is plugged in. Air75 V3 appears with different names depending on connection: `Air75 V3-1/-2/-3` for its three BT slots and `Air75 V3 Dongle` for 2.4GHz wireless; all four are whitelisted.

## Tuning Knobs

In `defvar`:

| Var | Default | Effect of raising | Effect of lowering |
|-----|---------|-------------------|--------------------|
| `tap-time`   | 200ms | More forgiving tap window | Fast keypresses turn into holds |
| `hold-time`  | 170ms | Mods feel laggy when held alone | Faster mod engagement; tap may misfire as hold |

## Related

- The Voyager firmware (Oryx/QMK) handles home-row mods; the laptop does not mirror them anymore.
- Karabiner-Elements has been uninstalled. Its DriverKit-VirtualHIDDevice extension remains because kanata depends on it.

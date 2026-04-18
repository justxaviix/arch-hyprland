# HyprDots 🌙

My personal Hyprland rice for Arch Linux, built around **matugen** for dynamic, wallpaper-driven theming across every component. Designed to run on low-end hardware with an NVIDIA graphics card.

Note: This setup or rice incorporates ideas from many different repos. This setup is not all 100% created by me. Please view the credits section below to support each of the indiviual creators! <3
> This setup needs to be tailored to each indiviual's unique device. See the wiki's below for guidance.

---

## System

Tested on low-end hardware with an NVIDIA graphics card. Make sure you have the proprietary NVIDIA drivers installed and the necessary environment variables set for Hyprland — see the [Hyprland NVIDIA wiki](https://wiki.hyprland.org/Nvidia/) for guidance.

---

## Components

| Component | Tool |
|---|---|
| Compositor | [Hyprland](https://hyprland.org/) |
| Bar | [Waybar](https://github.com/Alexays/Waybar) (dual monitor setup) |
| Launcher | [Rofi](https://github.com/davatorium/rofi) |
| Terminal | [Kitty](https://sw.kovidgoyal.net/kitty/) |
| Notifications | [swaync](https://github.com/ErikReider/SwayNotificationCenter) |
| Wallpaper | [awww](https://github.com/arian8j2/awww) |
| Color scheme | [matugen](https://github.com/InioX/matugen) |
| Shell | Zsh + [zinit](https://github.com/zdharma-continuum/zinit) + [Starship](https://starship.rs/) |
| Fetch | [fastfetch](https://github.com/fastfetch-cli/fastfetch) |
| File manager | [Thunar](https://docs.xfce.org/xfce/thunar/start) |
| Lock screen | [hyprlock](https://github.com/hyprwm/hyprlock) |
| Idle daemon | [hypridle](https://github.com/hyprwm/hypridle) |
| Spotify | [Spicetify](https://spicetify.app/) — Comfy theme |
| Discord | [Vencord](https://vencord.dev/) — Midnight theme |

---

## Theming

Color theming is driven by **matugen**. When you set a wallpaper using `set-wallpaper.sh`, it:

1. Extracts the dominant color from the wallpaper using ImageMagick
2. Feeds it into matugen to generate a full Material You palette
3. Automatically applies the new colors to: Hyprland borders, Waybar, Rofi, Kitty, swaync, Spotify (via Spicetify), and Discord (via Vencord + matugen template)

---

## Dependencies

Install these before applying the configs:

```
hyprland hyprlock hypridle
waybar rofi-wayland kitty
awww swaync
matugen imagemagick
zsh starship fastfetch thunar
spicetify-cli
```

For NVIDIA, also follow the [Hyprland NVIDIA guide](https://wiki.hyprland.org/Nvidia/) and install the appropriate `nvidia` driver package for your kernel.

---

## Install

Clone as a bare repo into `~/.dotfiles`:

```bash
git clone --bare https://github.com/justxaviix/arch-hyprland.git ~/.dotfiles
```

Define the alias (add to your shell before proceeding):

```bash
alias dots='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
```

Check out the files:

```bash
dots checkout
```

If you get conflicts (existing config files), back them up first:

```bash
mkdir -p ~/.config-backup && \
dots checkout 2>&1 | grep "^\s" | awk '{print $1}' | \
xargs -I{} mv {} ~/.config-backup/{}
dots checkout
```

Suppress untracked file noise:

```bash
dots config --local status.showUntrackedFiles no
```

Then reload Hyprland: `Super + Shift + E` or log out and back in.

---

## Usage

| Keybind | Action |
|---|---|
| `Super + Return` | Open terminal (Kitty) |
| `Super + D` | Open launcher (Rofi) |
| `Super + M` | Power menu |
| `Super + Tab` | Window switcher |
| `Super + Shift + W` | Wallpaper picker (triggers matugen re-theme) |

---

## Notes

- **Spicetify** patches Spotify directly at `/opt/spotify/` — you'll need to run `spicetify apply` after every Spotify update
- **Vencord** uses the Midnight theme with matugen primary color wired in — re-apply the theme after Discord updates
- Waybar requires a **full restart** (not just SIGUSR2) after wallpaper/theme changes to pick up new colors
- Dual monitor layout is configured for HDMI-A-4 (main, 1600×900) and DVI-D-1 (left, 1366×768) — adjust `~/.config/hypr/hyprland.conf` for your own monitors

---

## Credits

- **[JaKooLit](https://github.com/JaKooLit)** — scripts and waybar configurations that binnewbs built upon, which this setup inherits
- **[binnewbs/arch-hyprland](https://github.com/binnewbs/arch-hyprland)** — arch + hyprland rice this setup draws heavily from, including the matugen theming pipeline and wallpaper picker script
- **[refact0r/midnight-discord](https://github.com/refact0r/midnight-discord)** — original Midnight Discord theme, integrated via binnewbs's matugen template
- **[Vendicated/Vencord](https://github.com/Vendicated/Vencord)** — the Discord client mod that makes deep theming possible; without Vencord's active development and CSS injection support, the Discord customisations in this setup would not be viable on modern Discord

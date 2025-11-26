# Spotify Spicetify Theme Setup

This directory contains Spicetify configuration for automatic theme switching across 10 color schemes that match system-wide themes.

## What is Spicetify?

**Spicetify** is a command-line tool that customizes the Spotify client. It allows you to:
- Change colors and themes
- Add custom CSS
- Install extensions
- Modify the Spotify UI

Website: https://spicetify.app/

## Prerequisites

### Install Spicetify on Arch Linux

```bash
yay -S spicetify-cli
# or
paru -S spicetify-cli
```

### Verify Installation

```bash
spicetify --version
```

## Initial Setup

**IMPORTANT**: You must complete this setup before theme switching will work.

### Step 1: Grant Spicetify Permissions

Spicetify needs write access to Spotify's installation directory:

```bash
sudo chmod a+wr /opt/spotify
sudo chmod a+wr /opt/spotify/Apps -R
```

**Note**: If Spotify is installed via Flatpak or Snap, the path will be different. See troubleshooting section below.

### Step 2: Backup and Initialize Spicetify

This creates the initial integration:

```bash
spicetify backup apply
```

This command:
- Backs up your original Spotify files
- Applies Spicetify modifications
- Creates necessary config files

**After this command, Spotify should restart with Spicetify enabled.**

### Step 3: Set Initial Theme

Set the Everforest color scheme:

```bash
spicetify config color_scheme EverforestDarkMedium
spicetify apply
```

Spotify will now use the Everforest Dark Medium color palette.

## Automatic Theme Switching

Once setup is complete, the system theme switcher automatically updates Spotify themes.

### How It Works

When you press **SUPER SHIFT+T** and select a theme, the theme-switcher script:
1. Detects the selected theme
2. Maps it to a Spicetify color scheme
3. Runs `spicetify config color_scheme <scheme>`
4. Runs `spicetify apply`

### Theme Mappings

The following system themes map to Spicetify color schemes:

| System Theme      | Spicetify Color Scheme   |
|-------------------|--------------------------|
| Autumn            | TokyoNight               |
| Catppuccin Mocha  | CatppuccinMocha          |
| Crimson           | Dracula                  |
| Everforest        | EverforestDarkMedium     |
| Graphite          | Solarized                |
| Gruvbox           | GruvboxDark              |
| Kanagawa          | Kanagawa                 |
| Nightowl          | Nord                     |
| Oxocarbon         | TokyoNightStorm          |
| Rosepine          | RosePine                 |

These color schemes are defined in the `color.ini` file in this directory.

## Configuration Files

### color.ini

Contains color definitions for all 24+ available themes. Each theme section defines:
- **accent**: Primary accent color
- **accent-active**: Hover/active state color
- **accent-inactive**: Inactive state color
- **banner**: Banner background color
- **border-active**: Active border color
- **border-inactive**: Inactive border color
- **header**: Header background color
- **highlight**: Highlight color
- **main**: Main background color
- **notification**: Notification color
- **notification-error**: Error notification color
- **subtext**: Secondary text color
- **text**: Primary text color

### user.css

Custom CSS overrides (906 lines) with:
- Monospace font styling
- Border customizations
- Layout tweaks
- Custom UI elements
- ASCII art headers

### prefs

Spotify preferences file (managed by Spotify)

## Manual Theme Changes

To manually change Spotify theme without switching system theme:

```bash
# List available color schemes
spicetify config color_scheme -h

# Set a specific color scheme
spicetify config color_scheme GruvboxDark

# Apply changes
spicetify apply
```

## Troubleshooting

### Permission Errors

**Error**: `Error: no write permission`

**Solution**:
```bash
# If standard location doesn't work, try:
sudo chmod 777 /opt/spotify
sudo chmod 777 /opt/spotify/Apps -R
```

### Spotify Installed via Flatpak

**Different permissions needed**:
```bash
# Find Spotify Flatpak path
flatpak info --show-location com.spotify.Client

# Grant permissions
flatpak override --user --filesystem=xdg-config/spicetify com.spotify.Client
flatpak override --user --filesystem=xdg-data/spicetify com.spotify.Client

# Then run
spicetify backup apply
```

### Spotify Installed via Snap

**Snap version is not supported by Spicetify.**

Uninstall Snap version and install from:
- AUR: `yay -S spotify`
- Flatpak: `flatpak install spotify`

### Theme Not Applying

**Symptom**: Spotify looks the same after running spicetify

**Solutions**:
1. Verify Spicetify is initialized:
   ```bash
   spicetify backup apply
   ```

2. Check permissions:
   ```bash
   ls -la /opt/spotify/Apps
   ```

3. Manually apply theme:
   ```bash
   spicetify config color_scheme EverforestDarkMedium
   spicetify apply
   ```

4. Clear Spotify cache:
   ```bash
   rm -rf ~/.cache/spotify
   spicetify apply
   ```

### Theme Switcher Not Working

**Symptom**: System theme changes but Spotify doesn't update

**Check**:
1. Verify spicetify command is in PATH:
   ```bash
   which spicetify
   ```

2. Check if theme-switcher script has errors:
   ```bash
   bash -x ~/.config/hypr/scripts/theme-switcher.sh
   ```

3. Manually test spicetify:
   ```bash
   spicetify config color_scheme GruvboxDark
   spicetify apply
   ```

### Spotify Won't Launch

**Symptom**: Spotify crashes or won't start after Spicetify install

**Solution**:
```bash
# Restore original Spotify
spicetify restore

# Then retry setup
spicetify backup apply
```

## Updating Spotify

When Spotify updates, Spicetify needs to be reapplied:

```bash
# Spotify just updated and looks unstyled
spicetify backup apply
```

This re-applies all customizations to the new Spotify version.

## Uninstalling Spicetify

To remove Spicetify and restore original Spotify:

```bash
spicetify restore
```

## Advanced Customization

### Creating Custom Color Schemes

1. Edit `color.ini` in this directory
2. Add a new section with your colors:
   ```ini
   [MyCustomTheme]
   accent = FF5733
   accent-active = FF7043
   # ... etc
   ```

3. Apply it:
   ```bash
   spicetify config color_scheme MyCustomTheme
   spicetify apply
   ```

### Modifying Custom CSS

Edit `user.css` in this directory, then:
```bash
spicetify apply
```

Changes apply immediately.

## Available Color Schemes

This configuration includes 24+ color schemes:

- Spotify (default)
- Spicetify
- **CatppuccinMocha** / CatppuccinMacchiato / CatppuccinLatte
- Dracula
- **EverforestDarkMedium**
- **GruvboxDark**
- **Kanagawa**
- **Nord**
- **RosePine** / RosePineMoon / RosePineDawn
- Solarized
- **TokyoNight** / **TokyoNightStorm**
- OneDark / OneDarkPro
- Everblush
- ArcDark
- Biscuit
- Carbonfox / Dawnfox / Duskfox

**Bold** themes are used by the system theme switcher.

## Resources

- **Spicetify Website**: https://spicetify.app/
- **Spicetify Docs**: https://spicetify.app/docs/
- **Spicetify GitHub**: https://github.com/spicetify/spicetify-cli
- **Themes Marketplace**: https://spicetify.app/docs/advanced-usage/themes
- **Extensions**: https://spicetify.app/docs/advanced-usage/extensions

## Integration Notes

### System Theme Switcher

The theme-switcher script at `~/.config/hypr/scripts/theme-switcher.sh` handles Spotify theming automatically. It:

1. Checks if spicetify is installed
2. Maps the selected system theme to a color scheme
3. Runs `spicetify config` and `spicetify apply`
4. Silently fails if spicetify isn't installed (using `2>/dev/null || true`)

### Required for Theme Switching

- Spicetify must be installed
- Initial setup must be completed (`spicetify backup apply`)
- Spicetify must be in PATH

---

**Last Updated**: 2024-11-24
**Spicetify Version**: Latest
**Default Theme**: EverforestDarkMedium

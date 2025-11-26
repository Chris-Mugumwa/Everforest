# Discord/Vencord Everforest Theme Setup

This directory contains reference files for the **system24** Discord theme with **Everforest Dark Medium** color customization.

## What is system24?

- **Theme**: TUI-style Discord theme by refact0r
- **Style**: Terminal/gruvbox-inspired minimalist design
- **Customization**: Uses Everforest Dark Medium color palette
- **Source**: https://github.com/refact0r/system24

## Installation Instructions

### Prerequisites

1. **Discord with Vencord installed** (or Vesktop)
2. **CommitMono Nerd Font** installed on your system (or substitute with another font)

### Setup Steps

#### 1. Enable Custom CSS in Vencord

1. Open Discord/Vesktop
2. Go to **Settings** (gear icon)
3. Scroll to **Vencord** section
4. Click **Vencord**
5. Toggle **"Custom CSS"** to **ON**

#### 2. Open QuickCSS Editor

1. Still in Settings → Vencord → Vencord
2. Click **"Open QuickCSS file"**
3. This opens the Monaco code editor

#### 3. Paste Theme Code

Copy and paste this entire code block into the QuickCSS editor:

```css
/* system24 Discord Theme with Everforest Colors */
@import url('https://refact0r.github.io/system24/build/system24.css');

:root {
	/* Font Configuration */
	--font: 'CommitMono Nerd Font';
	letter-spacing: -0.10ch;
	font-weight: 300;
	--label-font-weight: 400;

	/* Theme Identifier */
	--corner-text: 'everforest'; /* Windows only */

	/* Spacing */
	--pad: 14px;
	--txt-pad: 10px;
	--panel-roundness: 0px;

	/* Background Colors (darkest to lightest) */
	--bg-0: #232a2e;
	--bg-1: #343f44;
	--bg-2: #3d484d;
	--bg-3: #475258;

	/* Text Colors */
	--txt-dark: var(--bg-0);
	--txt-link: var(--aqua);
	--txt-0: #d3c6aa;  /* Primary text */
	--txt-1: #d3c6aa;  /* Secondary text */
	--txt-2: #7a8478;  /* Muted text */
	--txt-3: #859289;  /* Placeholder text */

	/* Accent Colors */
	--acc-0: var(--aqua);   /* Primary accent */
	--acc-1: var(--green);  /* Hover accent */
	--acc-2: var(--blue);   /* Active accent */

	/* Everforest Color Palette */
	--red: #e67e80;
	--purple: #d699b6;
	--yellow: #dbbc7f;
	--aqua: #83c092;
	--blue: #7fbbb3;
	--green: #a7c080;
}
```

#### 4. Save and Apply

- Press **Ctrl+S** (or Cmd+S on Mac) to save
- Theme applies **immediately** with hot reload
- No Discord restart needed

## Font Setup

The theme uses **CommitMono Nerd Font**. If not installed:

### Option 1: Install the Font
Download and install CommitMono Nerd Font from:
- https://www.nerdfonts.com/
- Or your distribution's font package manager

### Option 2: Change the Font
Edit the `--font` variable in QuickCSS:
```css
--font: 'Your Installed Font Name';
```

Or use Discord's default font:
```css
--font: '';
```

## Customization

All visual aspects can be customized by editing the CSS variables:

### Color Customization
- **Background**: Modify `--bg-0` through `--bg-3`
- **Text**: Modify `--txt-0` through `--txt-3`
- **Accents**: Modify `--acc-0` through `--acc-2`
- **Palette**: Modify color variables (--red, --green, etc.)

### Spacing Customization
- **Panel spacing**: `--pad` (default: 14px)
- **Text padding**: `--txt-pad` (default: 10px)
- **Corner rounding**: `--panel-roundness` (default: 0px)

### Advanced Options

**Add rounded corners:**
```css
--panel-roundness: 8px;
```

**Import unrounding module** (removes all Discord rounded corners):
```css
@import url('https://refact0r.github.io/system24/src/unrounding.css');
```

## Switching Themes

To switch to a different color scheme (e.g., Nord variant):

1. Open QuickCSS
2. Replace the color variables with Nord colors from `system24 - Nord.css`
3. Save (Ctrl+S)

## Troubleshooting

### Theme Not Applying
1. Verify **Custom CSS** is enabled in Vencord settings
2. Check that the `@import` URL is accessible: https://refact0r.github.io/system24/build/system24.css
3. Try clearing Discord cache: Settings → Vencord → Clear Cache
4. Restart Discord completely

### Font Not Working
1. Verify font is installed: Run `fc-list | grep CommitMono` (Linux)
2. Change `--font` to a font you have installed
3. Set `--font: ''` to use Discord's default

### Colors Look Wrong
1. Ensure you copied the entire CSS block including `:root {}`
2. Check for syntax errors in QuickCSS editor
3. Try re-pasting the theme code

### QuickCSS Not Saving
1. Check file permissions in `~/.config/vesktop/` or `~/.config/discord/`
2. Try manual save with Ctrl+S
3. Restart Discord and try again

## Reference Files

This directory contains:
- `system24 - Everforest Dark Medium.css` - Full theme reference
- `system24 - Nord.css` - Nord color variant reference

These are **backup/reference files only**. The actual theme is loaded via QuickCSS as documented above.

## Resources

- **Theme Repository**: https://github.com/refact0r/system24
- **Vencord Documentation**: https://docs.vencord.dev/
- **Theme Support Discord**: Join with invite code `nz87hXyvcy`

## Integration with System Theme Switcher

This Discord theme uses Everforest colors that match the system-wide Everforest theme. When you switch system themes with `SUPER SHIFT+T`, Discord will need to be manually updated by changing the QuickCSS colors.

For automatic Discord theme switching, you would need to:
1. Create QuickCSS variants for each theme
2. Add a script to update the QuickCSS file
3. Restart Discord after theme changes

Currently, Discord theming is **manual** - use QuickCSS to change colors as desired.

---

**Last Updated**: 2024-11-24
**Theme Version**: system24 latest
**Color Scheme**: Everforest Dark Medium

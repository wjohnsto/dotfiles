/**
 * @typedef {Object} ThemeFamilyContent
 * @property {string} author - The author of the theme family.
 * @property {string} name - The name of the theme family.
 * @property {ThemeContent[]} themes - An array of themes in the family.
 */

/**
 * @typedef {string|null} AccentContent
 */

/**
 * @typedef {'light'|'dark'} AppearanceContent
 */

/**
 * @typedef {'normal'|'italic'|'oblique'} FontStyleContent
 */

/**
 * @typedef {Object} HighlightStyleContent
 * @property {string|null} [background_color=null] - Background color for highlighted text.
 * @property {string|null} [color=null] - Text color for highlighted text.
 * @property {FontStyleContent|null} [font_style=null] - Font style for highlighted text.
 * @property {100|200|300|400|500|600|700|800|900|null} [font_weight=null] - Font weight for highlighted text.
 */

/**
 * @typedef {Object} PlayerColorContent
 * @property {string|null} [background=null] - Background color for player elements.
 * @property {string|null} [cursor=null] - Cursor color for player elements.
 * @property {string|null} [selection=null] - Selection color for player elements.
 */

/**
 * @typedef {Object} ThemeContent
 * @property {AppearanceContent} appearance - The appearance mode of the theme.
 * @property {string} name - The name of the theme.
 * @property {ThemeStyleContent} style - The style configuration for the theme.
 */

/**
 * @typedef {Object} ThemeStyleContent
 * @property {AccentContent[]} [accents=[]] - Array of accent colors.
 * @property {string|null} [background=null] - Background color for the app and blank panels.
 * @property {'opaque'|'transparent'|'blurred'|null} [background.appearance=null] - Background appearance of the window.
 * @property {string|null} [border=null] - Border color for most borders, typically high contrast.
 * @property {string|null} [border.disabled=null] - Border color for disabled elements.
 * @property {string|null} [border.focused=null] - Border color for focused elements.
 * @property {string|null} [border.selected=null] - Border color for selected elements.
 * @property {string|null} [border.transparent=null] - Border color for transparent borders.
 * @property {string|null} [border.variant=null] - Border color for deemphasized borders.
 * @property {string|null} [conflict=null] - Color indicating a conflict, like merge conflicts in Git.
 * @property {string|null} [conflict.background=null] - Background color for conflict indicators.
 * @property {string|null} [conflict.border=null] - Border color for conflict indicators.
 * @property {string|null} [created=null] - Color indicating new items, like files added to Git.
 * @property {string|null} [created.background=null] - Background color for new items.
 * @property {string|null} [created.border=null] - Border color for new items.
 * @property {string|null} [deleted=null] - Color indicating deleted items.
 * @property {string|null} [deleted.background=null] - Background color for deleted items.
 * @property {string|null} [deleted.border=null] - Border color for deleted items.
 * @property {string|null} [drop_target.background=null] - Background color for drop target areas.
 * @property {string|null} [editor.active_line.background=null] - Background color for the active line in the editor.
 * @property {string|null} ["editor.active_line_number"] - Text color for the active line number in the editor gutter.
 * @property {string|null} [editor.active_wrap_guide=null] - Color for the active wrap guide in the editor.
 * @property {string|null} [editor.background=null] - Background color for the editor.
 * @property {string|null} [editor.document_highlight.bracket_background=null] - Background color for highlighted brackets.
 * @property {string|null} [editor.document_highlight.read_background=null] - Background color for read-access document highlights.
 * @property {string|null} [editor.document_highlight.write_background=null] - Background color for write-access document highlights.
 * @property {string|null} [editor.foreground=null] - Foreground color for the editor.
 * @property {string|null} [editor.gutter.background=null] - Background color for the editor gutter.
 * @property {string|null} [editor.highlighted_line.background=null] - Background color for highlighted lines.
 * @property {string|null} [editor.indent_guide=null] - Color for indent guides in the editor.
 * @property {string|null} [editor.indent_guide_active=null] - Color for active indent guides.
 * @property {string|null} [editor.invisible=null] - Text color for invisible characters like spaces or tabs.
 * @property {string|null} [editor.line_number=null] - Text color for line numbers in the editor gutter.
 * @property {string|null} [editor.subheader.background=null] - Background color for editor subheaders.
 * @property {string|null} [editor.wrap_guide=null] - Color for wrap guides in the editor.
 * @property {string|null} [element.active=null] - Background color for active elements.
 * @property {string|null} [element.background=null] - Background color for elements like buttons or inputs.
 * @property {string|null} [element.disabled=null] - Background color for disabled elements.
 * @property {string|null} [element.hover=null] - Background color for hovered elements.
 * @property {string|null} [element.selected=null] - Background color for selected elements.
 * @property {string|null} [elevated_surface.background=null] - Background color for elevated surfaces like context menus.
 * @property {string|null} [error=null] - Color indicating a system error or failed operation.
 * @property {string|null} [error.background=null] - Background color for error indicators.
 * @property {string|null} [error.border=null] - Border color for error indicators.
 * @property {string|null} [ghost_element.active=null] - Background color for active ghost elements.
 * @property {string|null} [ghost_element.background=null] - Background color for ghost elements.
 * @property {string|null} [ghost_element.disabled=null] - Background color for disabled ghost elements.
 * @property {string|null} [ghost_element.hover=null] - Background color for hovered ghost elements.
 * @property {string|null} [ghost_element.selected=null] - Background color for selected ghost elements.
 * @property {string|null} [hidden=null] - Color indicating hidden items, like hidden files.
 * @property {string|null} [hidden.background=null] - Background color for hidden items.
 * @property {string|null} [hidden.border=null] - Border color for hidden items.
 * @property {string|null} [hint=null] - Color indicating hints or additional information.
 * @property {string|null} [hint.background=null] - Background color for hints.
 * @property {string|null} [hint.border=null] - Border color for hints.
 * @property {string|null} [icon=null] - Fill color for default icons.
 * @property {string|null} [icon.accent=null] - Fill color for accented icons.
 * @property {string|null} [icon.disabled=null] - Fill color for disabled icons.
 * @property {string|null} [icon.muted=null] - Fill color for muted or deemphasized icons.
 * @property {string|null} [icon.placeholder=null] - Fill color for placeholder icons.
 * @property {string|null} [ignored=null] - Color indicating ignored items, like Git-ignored files.
 * @property {string|null} [ignored.background=null] - Background color for ignored items.
 * @property {string|null} [ignored.border=null] - Border color for ignored items.
 * @property {string|null} [info=null] - Color for informational status updates or messages.
 * @property {string|null} [info.background=null] - Background color for info indicators.
 * @property {string|null} [info.border=null] - Border color for info indicators.
 * @property {string|null} [link_text.hover=null] - Color for hovered link text.
 * @property {string|null} [modified=null] - Color indicating modified items, like edited files.
 * @property {string|null} [modified.background=null] - Background color for modified items.
 * @property {string|null} [modified.border=null] - Border color for modified items.
 * @property {string|null} [pane.focused_border=null] - Border color for focused panes.
 * @property {string|null} [pane_group.border=null] - Border color for pane groups.
 * @property {string|null} [panel.background=null] - Background color for panels.
 * @property {string|null} [panel.focused_border=null] - Border color for focused panels.
 * @property {string|null} [panel.indent_guide=null] - Color for panel indent guides.
 * @property {string|null} [panel.indent_guide_active=null] - Color for active panel indent guides.
 * @property {string|null} [panel.indent_guide_hover=null] - Color for hovered panel indent guides.
 * @property {PlayerColorContent[]} [players=[]] - Array of player-specific color configurations.
 * @property {string|null} [predictive=null] - Color indicating predicted items, like code completions.
 * @property {string|null} [predictive.background=null] - Background color for predicted items.
 * @property {string|null} [predictive.border=null] - Border color for predicted items.
 * @property {string|null} [renamed=null] - Color indicating renamed items.
 * @property {string|null} [renamed.background=null] - Background color for renamed items.
 * @property {string|null} [renamed.border=null] - Border color for renamed items.
 * @property {string|null} [scrollbar.thumb.background=null] - Color of the scrollbar thumb.
 * @property {string|null} [scrollbar.thumb.border=null] - Border color of the scrollbar thumb.
 * @property {string|null} [scrollbar.thumb.hover_background=null] - Color of the scrollbar thumb when hovered.
 * @property {string|null} [scrollbar.track.background=null] - Background color of the scrollbar track.
 * @property {string|null} [scrollbar.track.border=null] - Border color of the scrollbar track.
 * @property {string|null} [search.match_background=null] - Background color for search matches.
 * @property {string|null} [status_bar.background=null] - Background color for the status bar.
 * @property {string|null} [success=null] - Color indicating successful operations.
 * @property {string|null} [success.background=null] - Background color for success indicators.
 * @property {string|null} [success.border=null] - Border color for success indicators.
 * @property {string|null} [surface.background=null] - Background color for grounded surfaces like panels or tabs.
 * @property {Object.<string, HighlightStyleContent>} [syntax={}] - Styles for syntax nodes.
 * @property {string|null} [tab.active_background=null] - Background color for active tabs.
 * @property {string|null} [tab.inactive_background=null] - Background color for inactive tabs.
 * @property {string|null} [tab_bar.background=null] - Background color for the tab bar.
 * @property {string|null} [terminal.ansi.background=null] - Terminal ANSI background color.
 * @property {string|null} [terminal.ansi.black=null] - Black ANSI terminal color.
 * @property {string|null} [terminal.ansi.blue=null] - Blue ANSI terminal color.
 * @property {string|null} [terminal.ansi.bright_black=null] - Bright black ANSI terminal color.
 * @property {string|null} [terminal.ansi.bright_blue=null] - Bright blue ANSI terminal color.
 * @property {string|null} [terminal.ansi.bright_cyan=null] - Bright cyan ANSI terminal color.
 * @property {string|null} [terminal.ansi.bright_green=null] - Bright green ANSI terminal color.
 * @property {string|null} [terminal.ansi.bright_magenta=null] - Bright magenta ANSI terminal color.
 * @property {string|null} [terminal.ansi.bright_red=null] - Bright red ANSI terminal color.
 * @property {string|null} [terminal.ansi.bright_white=null] - Bright white ANSI terminal color.
 * @property {string|null} [terminal.ansi.bright_yellow=null] - Bright yellow ANSI terminal color.
 * @property {string|null} [terminal.ansi.cyan=null] - Cyan ANSI terminal color.
 * @property {string|null} [terminal.ansi.dim_black=null] - Dim black ANSI terminal color.
 * @property {string|null} [terminal.ansi.dim_blue=null] - Dim blue ANSI terminal color.
 * @property {string|null} [terminal.ansi.dim_cyan=null] - Dim cyan ANSI terminal color.
 * @property {string|null} [terminal.ansi.dim_green=null] - Dim green ANSI terminal color.
 * @property {string|null} [terminal.ansi.dim_magenta=null] - Dim magenta ANSI terminal color.
 * @property {string|null} [terminal.ansi.dim_red=null] - Dim red ANSI terminal color.
 * @property {string|null} [terminal.ansi.dim_white=null] - Dim white ANSI terminal color.
 * @property {string|null} [terminal.ansi.dim_yellow=null] - Dim yellow ANSI terminal color.
 * @property {string|null} [terminal.ansi.green=null] - Green ANSI terminal color.
 * @property {string|null} [terminal.ansi.magenta=null] - Magenta ANSI terminal color.
 * @property {string|null} [terminal.ansi.red=null] - Red ANSI terminal color.
 * @property {string|null} [terminal.ansi.white=null] - White ANSI terminal color.
 * @property {string|null} [terminal.ansi.yellow=null] - Yellow ANSI terminal color.
 * @property {string|null} [terminal.background=null] - Background color for the terminal.
 * @property {string|null} [terminal.bright_foreground=null] - Bright foreground color for the terminal.
 * @property {string|null} [terminal.dim_foreground=null] - Dim foreground color for the terminal.
 * @property {string|null} [terminal.foreground=null] - Foreground color for the terminal.
 * @property {string|null} [text=null] - Default text color.
 * @property {string|null} [text.accent=null] - Color for accented text.
 * @property {string|null} [text.disabled=null] - Color for disabled text.
 * @property {string|null} [text.muted=null] - Text Color. Color of muted or deemphasized text. It is a subdued version of the standard text color.
 * @property {string|null} [text.placeholder=null] - Text Color. Color of the placeholder text typically shown in input fields to guide the user to enter valid data.
 * @property {string|null} [title_bar.background=null] - Background color for the title bar.
 * @property {string|null} [title_bar.inactive_background=null] - Background color for inactive title bars.
 * @property {string|null} [toolbar.background=null] - Background color for the toolbar.
 * @property {string|null} [unreachable=null] - Color indicating unreachable code or elements.
 * @property {string|null} [unreachable.background=null] - Background color for unreachable elements.
 * @property {string|null} [unreachable.border=null] - Border color for unreachable elements.
 * @property {string|null} [warning=null] - Color indicating a warning status.
 * @property {string|null} [warning.background=null] - Background color for warning indicators.
 * @property {string|null} [warning.border=null] - Border color for warning indicators.
 */

/**
 * @typedef {'opaque'|'transparent'|'blurred'|null} WindowBackgroundContent
 */

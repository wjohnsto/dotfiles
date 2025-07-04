import colors from "./colors";
import fs from "fs/promises";

/**
 * @typedef {typeof colors.bg[0]} Color
 */

/**
 * @param {"light" | "dark"} variant
 */
function getPalette(variant) {
  return {
    bg0: colors.bg[0][variant],
    bg1: colors.bg[1][variant],
    bg2: colors.bg[2][variant],
    bg3: colors.bg[3][variant],
    bg4: colors.bg[4][variant],

    fg0: colors.fg[0][variant],
    fg1: colors.fg[1][variant],
    fg2: colors.fg[2][variant],
    fg3: colors.fg[3][variant],

    black: colors.black.default[variant],
    blackBright: colors.black.bright[variant],
    blackDim: colors.black.dim[variant],

    blue: colors.blue.default[variant],
    blueBright: colors.blue.bright[variant],
    blueDim: colors.blue.dim[variant],

    comment: colors.comment[variant],

    cyan: colors.cyan.default[variant],
    cyanBright: colors.cyan.bright[variant],
    cyanDim: colors.cyan.dim[variant],

    green: colors.green.default[variant],
    greenBright: colors.green.bright[variant],
    greenDim: colors.green.dim[variant],

    magenta: colors.magenta.default[variant],
    magentaBright: colors.magenta.bright[variant],
    magentaDim: colors.magenta.dim[variant],

    orange: colors.orange.default[variant],
    orangeBright: colors.orange.bright[variant],
    orangeDim: colors.orange.dim[variant],

    pink: colors.pink.default[variant],
    pinkBright: colors.pink.bright[variant],
    pinkDim: colors.pink.dim[variant],

    red: colors.red.default[variant],
    redBright: colors.red.bright[variant],
    redDim: colors.red.dim[variant],

    sel0: colors.sel[0][variant],
    sel1: colors.sel[1][variant],

    white: colors.white.default[variant],
    whiteBright: colors.white.bright[variant],
    whiteDim: colors.white.dim[variant],

    yellow: colors.yellow.default[variant],
    yellowBright: colors.yellow.bright[variant],
    yellowDim: colors.yellow.dim[variant],
  };
}

function alpha(color, a) {
  // kjasdflakjsdf
  return `${color}${a}`;
}

/**
 * @param {"light" | "dark"} variant
 * @returns {import("./schema").ThemeContent}
 */
function generate(variant) {
  const {
    bg0,
    bg1,
    bg2,
    bg3,
    bg4,
    fg0,
    fg1,
    fg2,
    fg3,
    black,
    blackBright,
    blackDim,
    blue,
    blueBright,
    blueDim,
    comment,
    cyan,
    cyanBright,
    cyanDim,
    green,
    greenBright,
    greenDim,
    magenta,
    magentaBright,
    magentaDim,
    orange,
    orangeBright,
    orangeDim,
    pink,
    pinkBright,
    pinkDim,
    red,
    redBright,
    redDim,
    sel0,
    sel1,
    white,
    whiteBright,
    whiteDim,
    yellow,
    yellowBright,
    yellowDim,
  } = getPalette(variant);

  return {
    name: `MyTheme ${variant.charAt(0).toUpperCase() + variant.slice(1)}`,
    appearance: variant,
    style: {
      border: fg1,
      "border.variant": fg2,
      "border.focused": fg3,
      "border.selected": fg3,
      "border.transparent": black,
      "border.disabled": fg3,
      "elevated_surface.background": bg4,
      "surface.background": bg4,
      background: bg0,
      "element.background": bg1,
      "element.hover": sel0,
      "element.active": sel0,
      "element.selected": sel0,
      "element.disabled": bg1,
      "drop_target.background": alpha(bg4, "80"),
      "ghost_element.background": black,
      "ghost_element.hover": sel0,
      "ghost_element.active": sel0,
      "ghost_element.selected": sel0,
      "ghost_element.disabled": bg1,
      text: fg0,
      "text.muted": fg1,
      "text.placeholder": fg2,
      "text.disabled": fg2,
      "text.accent": blue,
      icon: fg0,
      "icon.muted": fg1,
      "icon.disabled": fg2,
      "icon.placeholder": fg1,
      "icon.accent": blue,
      "status_bar.background": bg0,
      "title_bar.background": bg0,
      "title_bar.inactive_background": bg1,
      "toolbar.background": bg0,
      "tab_bar.background": bg0,
      "tab.inactive_background": bg0,
      "tab.active_background": bg3,
      "search.match_background": sel1,
      "panel.background": bg0,
      "panel.focused_border": null,
      "pane.focused_border": null,
      "scrollbar.thumb.background": alpha(fg2, "4c"),
      "scrollbar.thumb.hover_background": fg2,
      "scrollbar.thumb.border": fg2,
      "scrollbar.track.background": black,
      "scrollbar.track.border": bg3,
      "editor.foreground": fg0,
      "editor.background": bg0,
      "editor.gutter.background": bg0,
      "editor.subheader.background": bg4,
      "editor.active_line.background": alpha(bg4, "60"), // transparent(sel1, "8f"),
      "editor.highlighted_line.background": bg4,
      "editor.line_number": fg3,
      "editor.active_line_number": fg1,
      "editor.hover_line_number": fg2,
      "editor.invisible": fg2,
      "editor.wrap_guide": alpha(sel1, "0d"),
      "editor.active_wrap_guide": alpha(sel1, "1a"),
      "editor.document_highlight.read_background": alpha(
        blueBright,
        "1a",
      ),
      "editor.document_highlight.write_background": alpha(
        blackBright,
        "66",
      ),
      "editor.document_highlight.bracket_background": alpha(
        blueBright,
        "1a",
      ),
      "terminal.background": bg0,
      "terminal.foreground": fg0,
      "terminal.bright_foreground": fg0,
      "terminal.dim_foreground": bg0,
      "terminal.ansi.black": bg0,
      "terminal.ansi.bright_black": blackBright,
      "terminal.ansi.dim_black": fg0,
      "terminal.ansi.red": red,
      "terminal.ansi.bright_red": redBright,
      "terminal.ansi.dim_red": redDim,
      "terminal.ansi.green": green,
      "terminal.ansi.bright_green": greenBright,
      "terminal.ansi.dim_green": greenDim,
      "terminal.ansi.yellow": yellow,
      "terminal.ansi.bright_yellow": yellowBright,
      "terminal.ansi.dim_yellow": yellowDim,
      "terminal.ansi.blue": blue,
      "terminal.ansi.bright_blue": blueBright,
      "terminal.ansi.dim_blue": blueDim,
      "terminal.ansi.magenta": magenta,
      "terminal.ansi.bright_magenta": magentaBright,
      "terminal.ansi.dim_magenta": magentaDim,
      "terminal.ansi.cyan": cyan,
      "terminal.ansi.bright_cyan": cyanBright,
      "terminal.ansi.dim_cyan": cyanDim,
      "terminal.ansi.white": white,
      "terminal.ansi.bright_white": whiteBright,
      "terminal.ansi.dim_white": whiteDim,
      "link_text.hover": blue,
      "version_control.added": greenDim,
      "version_control.modified": yellowDim,
      "version_control.deleted": redDim,
      "version_control.conflict_marker.ours": alpha(greenDim, "1a"),
      "version_control.conflict_marker.theirs": alpha(blueDim, "1a"),
      conflict: yellow,
      "conflict.background": alpha(yellow, "1a"),
      "conflict.border": greenDim,
      created: green,
      "created.background": alpha(green, "1a"),
      "created.border": greenDim,
      deleted: red,
      "deleted.background": alpha(red, "1a"),
      "deleted.border": redDim,
      error: red,
      "error.background": alpha(red, "1a"),
      "error.border": redDim,
      hidden: fg2,
      "hidden.background": alpha(fg2, "1a"),
      "hidden.border": fg3,
      hint: cyanDim,
      "hint.background": alpha(cyanDim, "1a"),
      "hint.border": fg3,
      ignored: fg2,
      "ignored.background": alpha(fg2, "1a"),
      "ignored.border": fg1,
      info: blue,
      "info.background": alpha(blue, "1a"),
      "info.border": fg3,
      modified: yellow,
      "modified.background": alpha(yellow, "1a"),
      "modified.border": greenDim,
      predictive: fg2,
      "predictive.background": alpha(bg4, "60"),
      "predictive.border": fg1,
      renamed: blue,
      "renamed.background": alpha(blue, "1a"),
      "renamed.border": fg3,
      success: green,
      "success.background": alpha(green, "1a"),
      "success.border": greenDim,
      unreachable: fg1,
      "unreachable.background": alpha(fg1, "1a"),
      "unreachable.border": fg1,
      warning: yellow,
      "warning.background": alpha(yellow, "1a"),
      "warning.border": greenDim,
      players: [
        {
          cursor: blue,
          background: blue,
          selection: alpha(blue, "3d"),
        },
        {
          cursor: magenta,
          background: magenta,
          selection: alpha(magenta, "3d"),
        },
        {
          cursor: orange,
          background: orange,
          selection: alpha(orange, "3d"),
        },
        {
          cursor: pink,
          background: pink,
          selection: alpha(pink, "3d"),
        },
        {
          cursor: cyan,
          background: cyan,
          selection: alpha(cyan, "3d"),
        },
        {
          cursor: red,
          background: red,
          selection: alpha(red, "3d"),
        },
        {
          cursor: yellow,
          background: yellow,
          selection: alpha(yellow, "3d"),
        },
        {
          cursor: green,
          background: green,
          selection: alpha(green, "3d"),
        },
      ],
      syntax: {
        attribute: {
          color: greenBright,
          font_style: null,
          font_weight: null,
        },
        boolean: {
          color: yellowDim,
          font_style: null,
          font_weight: null,
        },
        comment: {
          color: comment,
          font_style: null,
          font_weight: null,
        },
        "comment.doc": {
          color: comment,
          font_style: null,
          font_weight: null,
        },
        constant: {
          color: yellowDim,
          font_style: null,
          font_weight: null,
        },
        constructor: {
          color: yellow,
          font_style: null,
          font_weight: null,
        },
        embedded: {
          color: fg0,
          font_style: null,
          font_weight: null,
        },
        emphasis: {
          color: blue,
          font_style: null,
          font_weight: null,
        },
        "emphasis.strong": {
          color: orange,
          font_style: null,
          font_weight: 700,
        },
        enum: {
          color: red,
          font_style: null,
          font_weight: null,
        },
        function: {
          color: yellow,
          font_style: null,
          font_weight: null,
        },
        hint: {
          color: cyanDim,
          font_style: null,
          font_weight: 700,
        },
        keyword: {
          color: blueBright,
          font_style: null,
          font_weight: null,
        },
        label: {
          color: blue,
          font_style: null,
          font_weight: null,
        },
        link_text: {
          color: yellow,
          font_style: "normal",
          font_weight: null,
        },
        link_uri: {
          color: cyan,
          font_style: null,
          font_weight: null,
        },
        namespace: {
          color: fg0,
          font_style: null,
          font_weight: null,
        },
        number: {
          color: orange,
          font_style: null,
          font_weight: null,
        },
        operator: {
          color: cyan,
          font_style: null,
          font_weight: null,
        },
        predictive: {
          color: fg1,
          font_style: "italic",
          font_weight: null,
        },
        preproc: {
          color: fg0,
          font_style: null,
          font_weight: null,
        },
        primary: {
          color: fg0,
          font_style: null,
          font_weight: null,
        },
        property: {
          color: greenBright,
          font_style: null,
          font_weight: null,
        },
        punctuation: {
          color: fg0,
          font_style: null,
          font_weight: null,
        },
        "punctuation.bracket": {
          color: fg2,
          font_style: null,
          font_weight: null,
        },
        "punctuation.delimiter": {
          color: fg2,
          font_style: null,
          font_weight: null,
        },
        "punctuation.list_marker": {
          color: red,
          font_style: null,
          font_weight: null,
        },
        "punctuation.special": {
          color: greenBright,
          font_style: null,
          font_weight: null,
        },
        selector: {
          color: yellowDim,
          font_style: null,
          font_weight: null,
        },
        "selector.pseudo": {
          color: blue,
          font_style: null,
          font_weight: null,
        },
        string: {
          color: yellowDim,
          font_style: null,
          font_weight: null,
        },
        "string.escape": {
          color: fg3,
          font_style: null,
          font_weight: null,
        },
        "string.regex": {
          color: yellow,
          font_style: null,
          font_weight: null,
        },
        "string.special": {
          color: yellow,
          font_style: null,
          font_weight: null,
        },
        "string.special.symbol": {
          color: yellow,
          font_style: null,
          font_weight: null,
        },
        tag: {
          color: greenDim,
          font_style: null,
          font_weight: null,
        },
        "text.literal": {
          color: green,
          font_style: null,
          font_weight: null,
        },
        title: {
          color: red,
          font_style: null,
          font_weight: 400,
        },
        type: {
          color: cyan,
          font_style: null,
          font_weight: null,
        },
        variable: {
          color: fg1,
          font_style: null,
          font_weight: null,
        },
        "variable.special": {
          color: orange,
          font_style: null,
          font_weight: null,
        },
        variant: {
          color: yellow,
          font_style: null,
          font_weight: null,
        },
      },
    },
  };
}

const light = generate("light");
const dark = generate("dark");

await fs.writeFile(
  "../my-theme.json",
  JSON.stringify(
    /** @type {import("./schema").ThemeFamilyContent} */ ({
      id: "my-theme",
      $schema: "https://zed.dev/schema/themes/v0.2.0.json",
      author: "wwj",
      name: "My Theme",
      themes: [light, dark],
    }),
    null,
    2,
  ),
);

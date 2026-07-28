{ lib, palette }:
let
  inherit (palette)
    opaque
    a03
    a05
    a08
    a10
    a15
    a18
    a20
    a24
    a25
    a35
    a40
    transparent
    ;

  status =
    prefix: fg: border:
    {
      "${prefix}" = opaque fg;
      "${prefix}.background" = a10 fg;
      "${prefix}.border" = opaque border;
    };

  variant =
    name: appearance: c:
    let
      isDark = appearance == "dark";

      film = step: step c.overlay;

      scrollbar =
        if isDark then
          {
            idle = film a10;
            hover = film a18;
            active = film a25;
          }
        else
          {
            idle = film a15;
            hover = film a25;
            active = film a35;
          };

      thumb = {
        "thumb.background" = scrollbar.idle;
        "thumb.hover_background" = scrollbar.hover;
        "thumb.active_background" = scrollbar.active;
        "thumb.border" = transparent;
      };

      prefixAttrs = prefix: lib.mapAttrs' (k: v: lib.nameValuePair "${prefix}.${k}" v);
    in
    {
      inherit name appearance;

      style =
        {
          background = opaque c.bg;
          "surface.background" = opaque c.surface;
          "elevated_surface.background" = opaque c.elevated;

          border = opaque c.border;
          "border.variant" = opaque c.borderVariant;
          "border.focused" = opaque c.borderFocused;
          "border.selected" = opaque c.borderSelected;
          "border.transparent" = transparent;
          "border.disabled" = opaque c.borderVariant;

          text = opaque c.fg;
          "text.muted" = opaque c.muted;
          "text.placeholder" = opaque c.placeholder;
          "text.disabled" = opaque c.disabled;
          "text.accent" = opaque c.accent;
          "link_text.hover" = opaque c.accentBright;

          icon = opaque c.fg;
          "icon.muted" = opaque c.muted;
          "icon.disabled" = opaque c.disabled;
          "icon.placeholder" = opaque c.placeholder;
          "icon.accent" = opaque c.accent;

          "title_bar.background" = opaque c.bg;
          "title_bar.inactive_background" = opaque c.inactive;
          "status_bar.background" = opaque c.bg;
          "toolbar.background" = opaque c.bg;
          "tab_bar.background" = opaque c.inactive;
          "tab.active_background" = opaque c.tabActive;
          "tab.inactive_background" = opaque c.inactive;

          "panel.background" = opaque c.panel;
          "panel.focused_border" = opaque c.borderFocused;
          "panel.indent_guide" = opaque c.border;
          "panel.indent_guide_active" = opaque c.borderFocused;
          "panel.indent_guide_hover" = opaque c.borderSubtle;
          "panel.overlay_background" = film a05;
          "panel.overlay_hover" = film a08;
          "pane.focused_border" = opaque c.borderFocused;

          "element.background" = opaque c.element;
          "element.hover" = opaque c.elementHover;
          "element.active" = opaque c.elementActive;
          "element.selected" = a10 c.accent;
          "element.selection_background" = a24 c.accent;
          "element.disabled" = opaque c.inactive;

          "ghost_element.background" = transparent;
          "ghost_element.hover" = film a05;
          "ghost_element.active" = film a08;
          "ghost_element.selected" = a10 c.accent;
          "ghost_element.disabled" = transparent;

          "drop_target.background" = a20 c.accent;

          "scrollbar.track.background" = transparent;
          "scrollbar.track.border" = opaque c.borderVariant;

          "editor.foreground" = opaque c.fg;
          "editor.background" = opaque c.bg;
          "editor.gutter.background" = opaque c.bg;
          "editor.subheader.background" = opaque c.surface;
          "editor.active_line.background" = film a03;
          "editor.highlighted_line.background" = film a05;
          "editor.debugger_active_line.background" = a10 c.accent;
          "editor.line_number" = opaque c.disabled;
          "editor.active_line_number" = opaque c.fg;
          "editor.hover_line_number" = opaque c.muted;
          "editor.invisible" = opaque c.invisible;
          "editor.wrap_guide" = film a05;
          "editor.active_wrap_guide" = film a10;
          "editor.indent_guide" = opaque c.border;
          "editor.indent_guide_active" = opaque c.borderFocused;
          "editor.document_highlight.read_background" = a10 c.accent;
          "editor.document_highlight.write_background" = a20 c.accent;
          "editor.document_highlight.bracket_background" = a20 c.accent;

          "search.match_background" = a40 c.accent;

          "version_control.added" = opaque c.green;
          "version_control.deleted" = opaque c.red;
          "version_control.modified" = opaque c.yellow;
          "version_control.renamed" = opaque c.info;
          "version_control.conflict" = opaque c.yellow;
          "version_control.ignored" = opaque c.muted;
          "version_control.conflict_marker.ours" = a20 c.green;
          "version_control.conflict_marker.theirs" = a20 c.info;

          "terminal.background" = opaque c.terminalBg;
          "terminal.foreground" = opaque c.terminalFg;
          "terminal.bright_foreground" = opaque c.terminalFgBright;
          "terminal.dim_foreground" = opaque c.muted;

          players = map (x: {
            cursor = opaque x;
            background = opaque x;
            selection = a24 x;
          }) [ c.accent c.red c.yellow c.magenta c.cyan c.green c.orange c.pink ];

          syntax = lib.mapAttrs (_: color: { color = opaque color; }) {
            comment = c.placeholder;
            "comment.doc" = c.commentDoc;
            keyword = c.magenta;
            string = c.green;
            "string.escape" = c.cyan;
            "string.regex" = c.cyan;
            function = c.info;
            "function.method" = c.info;
            type = c.yellow;
            constructor = c.info;
            number = c.orange;
            boolean = c.orange;
            constant = c.orange;
            variable = c.fg;
            "variable.special" = c.red;
            property = c.red;
            operator = c.info;
            punctuation = c.muted;
            "punctuation.bracket" = c.muted;
            tag = c.red;
            attribute = c.yellow;
            title = c.info;
            emphasis = c.accent;
            link_uri = c.green;
            link_text = c.orange;
          };
        }
        // prefixAttrs "scrollbar" thumb
        // prefixAttrs "minimap" thumb
        // merge [
          (status "hint" c.muted c.mutedBorder)
          (status "info" c.info c.infoBorder)
          (status "success" c.green c.successBorder)
          (status "warning" c.yellow c.warningBorder)
          (status "error" c.red c.errorBorder)
          (status "created" c.green c.successBorder)
          (status "modified" c.yellow c.warningBorder)
          (status "deleted" c.red c.errorBorder)
          (status "conflict" c.yellow c.warningBorder)
          (status "renamed" c.info c.infoBorder)
          (status "hidden" c.muted c.hiddenBorder)
          (status "ignored" c.muted c.mutedBorder)
          (status "predictive" c.predictive c.borderSelected)
          (status "unreachable" c.placeholder c.mutedBorder)
        ]
        // lib.mapAttrs' (k: v: lib.nameValuePair "terminal.ansi.${snake k}" (opaque v)) c.ansi;
    };

  merge = builtins.foldl' (acc: x: acc // x) { };

  upper = lib.stringToCharacters "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  snake = lib.replaceStrings upper (map (x: "_${lib.toLower x}") upper);
in
{
  "$schema" = "https://zed.dev/schema/themes/v0.2.0.json";
  name = "Nocturne";
  author = "whisky";
  description = "meow";
  isUserGenerated = true;

  themes = [
    (variant "Nocturne Dark" "dark" palette.dark)
    (variant "Nocturne Light" "light" palette.light)
  ];
}

{ lib, palette }:
let
  c = palette.dark;
  inherit (palette) hex;

  groups = {
    Normal = {
      fg = hex c.fg;
      bg = hex c.bg;
    };
    NormalFloat = {
      fg = hex c.fg;
      bg = hex c.surface;
    };
    FloatBorder = {
      fg = hex c.border;
      bg = hex c.surface;
    };
    FloatTitle = {
      fg = hex c.accent;
      bg = hex c.surface;
    };
    EndOfBuffer.fg = hex c.bg;
    Cursor = {
      fg = hex c.bg;
      bg = hex c.accent;
    };
    lCursor = {
      fg = hex c.bg;
      bg = hex c.accent;
    };
    CursorLine.bg = hex c.surface;
    CursorColumn.bg = hex c.surface;
    ColorColumn.bg = hex c.surface;
    LineNr.fg = hex c.disabled;
    CursorLineNr = {
      fg = hex c.fg;
      bold = true;
    };
    SignColumn.bg = hex c.bg;
    WinSeparator.fg = hex c.border;
    VertSplit.fg = hex c.border;

    Visual.bg = hex c.selection;
    VisualNOS.bg = hex c.selection;

    Search.bg = hex c.selection;
    IncSearch = {
      fg = hex c.bg;
      bg = hex c.accent;
    };
    CurSearch = {
      fg = hex c.bg;
      bg = hex c.accent;
    };
    MatchParen = {
      fg = hex c.accent;
      bold = true;
    };

    StatusLine = {
      fg = hex c.fg;
      bg = hex c.surface;
    };
    StatusLineNC = {
      fg = hex c.muted;
      bg = hex c.panel;
    };
    TabLine = {
      fg = hex c.muted;
      bg = hex c.panel;
    };
    TabLineFill.bg = hex c.panel;
    TabLineSel = {
      fg = hex c.fg;
      bg = hex c.bg;
    };
    WinBar = {
      fg = hex c.fg;
      bg = hex c.bg;
    };
    WinBarNC = {
      fg = hex c.muted;
      bg = hex c.bg;
    };

    Pmenu = {
      fg = hex c.fg;
      bg = hex c.surface;
    };
    PmenuSel = {
      fg = hex c.fg;
      bg = hex c.selection;
    };
    PmenuSbar.bg = hex c.elevated;
    PmenuThumb.bg = hex c.borderSubtle;
    WildMenu = {
      fg = hex c.fg;
      bg = hex c.selection;
    };

    Folded = {
      fg = hex c.muted;
      bg = hex c.surface;
    };
    FoldColumn.fg = hex c.disabled;
    Conceal.fg = hex c.muted;
    NonText.fg = hex c.invisible;
    Whitespace.fg = hex c.invisible;
    SpecialKey.fg = hex c.invisible;
    Directory.fg = hex c.accent;
    Title = {
      fg = hex c.info;
      bold = true;
    };
    Question.fg = hex c.green;
    MoreMsg.fg = hex c.green;
    ModeMsg = {
      fg = hex c.fg;
      bold = true;
    };
    ErrorMsg.fg = hex c.red;
    WarningMsg.fg = hex c.yellow;
    QuickFixLine.bg = hex c.selection;

    DiagnosticError.fg = hex c.red;
    DiagnosticWarn.fg = hex c.yellow;
    DiagnosticInfo.fg = hex c.info;
    DiagnosticHint.fg = hex c.muted;
    DiagnosticOk.fg = hex c.green;
    DiagnosticUnderlineError = {
      undercurl = true;
      sp = hex c.red;
    };
    DiagnosticUnderlineWarn = {
      undercurl = true;
      sp = hex c.yellow;
    };
    DiagnosticUnderlineInfo = {
      undercurl = true;
      sp = hex c.info;
    };
    DiagnosticUnderlineHint = {
      undercurl = true;
      sp = hex c.muted;
    };

    DiffAdd.bg = hex c.successBorder;
    DiffDelete.fg = hex c.red;
    DiffChange.bg = hex c.infoBorder;
    DiffText.bg = hex c.borderSelected;
    Added.fg = hex c.green;
    Removed.fg = hex c.red;
    Changed.fg = hex c.yellow;

    Comment = {
      fg = hex c.placeholder;
      italic = true;
    };
    Constant.fg = hex c.orange;
    String.fg = hex c.green;
    Character.fg = hex c.green;
    Number.fg = hex c.orange;
    Boolean.fg = hex c.orange;
    Float.fg = hex c.orange;
    Identifier.fg = hex c.fg;
    Function.fg = hex c.info;
    Statement.fg = hex c.magenta;
    Conditional.fg = hex c.magenta;
    Repeat.fg = hex c.magenta;
    Label.fg = hex c.magenta;
    Operator.fg = hex c.info;
    Keyword.fg = hex c.magenta;
    Exception.fg = hex c.magenta;
    PreProc.fg = hex c.magenta;
    Include.fg = hex c.magenta;
    Define.fg = hex c.magenta;
    Macro.fg = hex c.magenta;
    PreCondit.fg = hex c.magenta;
    Type.fg = hex c.yellow;
    StorageClass.fg = hex c.yellow;
    Structure.fg = hex c.yellow;
    Typedef.fg = hex c.yellow;
    Special.fg = hex c.cyan;
    SpecialChar.fg = hex c.cyan;
    Tag.fg = hex c.red;
    Delimiter.fg = hex c.muted;
    SpecialComment = {
      fg = hex c.commentDoc;
      italic = true;
    };
    Debug.fg = hex c.orange;
    Underlined.underline = true;
    Ignore.fg = hex c.disabled;
    Error.fg = hex c.red;
    Todo = {
      fg = hex c.yellow;
      bold = true;
    };

    "@variable".fg = hex c.fg;
    "@variable.builtin".fg = hex c.red;
    "@variable.parameter".fg = hex c.fg;
    "@variable.member".fg = hex c.red;
    "@property".fg = hex c.red;
    "@constant".fg = hex c.orange;
    "@constant.builtin".fg = hex c.orange;
    "@string.escape".fg = hex c.cyan;
    "@string.regexp".fg = hex c.cyan;
    "@string.special".fg = hex c.cyan;
    "@function".fg = hex c.info;
    "@function.builtin".fg = hex c.info;
    "@function.call".fg = hex c.info;
    "@function.method".fg = hex c.info;
    "@constructor".fg = hex c.info;
    "@keyword".fg = hex c.magenta;
    "@keyword.import".fg = hex c.magenta;
    "@type".fg = hex c.yellow;
    "@type.builtin".fg = hex c.yellow;
    "@attribute".fg = hex c.yellow;
    "@operator".fg = hex c.info;
    "@punctuation.delimiter".fg = hex c.muted;
    "@punctuation.bracket".fg = hex c.muted;
    "@punctuation.special".fg = hex c.cyan;
    "@comment".fg = hex c.placeholder;
    "@comment.documentation".fg = hex c.commentDoc;
    "@tag".fg = hex c.red;
    "@tag.attribute".fg = hex c.yellow;
    "@tag.delimiter".fg = hex c.muted;
    "@markup.heading" = {
      fg = hex c.info;
      bold = true;
    };
    "@markup.strong".bold = true;
    "@markup.italic".italic = true;
    "@markup.link".fg = hex c.orange;
    "@markup.link.url" = {
      fg = hex c.green;
      underline = true;
    };
    "@markup.raw".fg = hex c.green;
    "@markup.list".fg = hex c.accent;
    "@diff.plus".fg = hex c.green;
    "@diff.minus".fg = hex c.red;
    "@diff.delta".fg = hex c.yellow;
  };

  renderValue = v: if builtins.isBool v then lib.boolToString v else ''"${v}"'';

  renderGroup =
    name: attrs:
    let
      body = lib.concatStringsSep ", " (lib.mapAttrsToList (k: v: "${k} = ${renderValue v}") attrs);
    in
    ''hl(0, "${name}", { ${body} })'';
in
''
  -- Nocturne. generated from lib/palette.nix.
  vim.cmd.highlight("clear")
  if vim.fn.exists("syntax_on") == 1 then
    vim.cmd.syntax("reset")
  end

  vim.o.background = "dark"
  vim.g.colors_name = "nocturne"

  local hl = vim.api.nvim_set_hl

  ${lib.concatStringsSep "\n" (lib.mapAttrsToList renderGroup groups)}

  vim.g.terminal_color_0 = "${hex c.ansi.black}"
  vim.g.terminal_color_1 = "${hex c.ansi.red}"
  vim.g.terminal_color_2 = "${hex c.ansi.green}"
  vim.g.terminal_color_3 = "${hex c.ansi.yellow}"
  vim.g.terminal_color_4 = "${hex c.ansi.blue}"
  vim.g.terminal_color_5 = "${hex c.ansi.magenta}"
  vim.g.terminal_color_6 = "${hex c.ansi.cyan}"
  vim.g.terminal_color_7 = "${hex c.ansi.white}"
  vim.g.terminal_color_8 = "${hex c.ansi.brightBlack}"
  vim.g.terminal_color_9 = "${hex c.ansi.brightRed}"
  vim.g.terminal_color_10 = "${hex c.ansi.brightGreen}"
  vim.g.terminal_color_11 = "${hex c.ansi.brightYellow}"
  vim.g.terminal_color_12 = "${hex c.ansi.brightBlue}"
  vim.g.terminal_color_13 = "${hex c.ansi.brightMagenta}"
  vim.g.terminal_color_14 = "${hex c.ansi.brightCyan}"
  vim.g.terminal_color_15 = "${hex c.ansi.brightWhite}"
''

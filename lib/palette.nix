rec {
  hex = c: "#${c}";
  rgba = alpha: c: "#${c}${alpha}";
  opaque = rgba "ff";

  a03 = rgba "08";
  a05 = rgba "0d";
  a08 = rgba "14";
  a10 = rgba "1a";
  a15 = rgba "26";
  a18 = rgba "2e";
  a20 = rgba "33";
  a24 = rgba "3d";
  a25 = rgba "40";
  a35 = rgba "59";
  a40 = rgba "66";

  transparent = "#00000000";

  dark = {
    bg = "0a0a0d";
    panel = "0e0e0e";
    inactive = "0e0e0e";
    tabActive = "0a0a0d";
    surface = "111111";
    elevated = "151515";
    element = "161616";
    elementHover = "1f1f1f";
    elementActive = "2a2a2a";

    terminalBg = "0a0a0a";

    overlay = "ffffff";

    border = "252525";
    borderVariant = "1a1a1a";
    borderFocused = "4f72b2";
    borderSelected = "2e3f5c";
    borderSubtle = "3a3a3a";
    mutedBorder = "2a2a2a";
    hiddenBorder = "414754";

    fg = "dedede";
    terminalFg = "e0e0e0";
    terminalFgBright = "ffffff";
    muted = "9e9e9e";
    placeholder = "6b6b6b";
    commentDoc = "808080";
    disabled = "5a5a5a";
    invisible = "3a3a3a";
    predictive = "5a6a87";

    accent = "7e9fdc";
    accentBright = "a0b8e0";
    info = "7db4e0";
    green = "70d4a0";
    yellow = "e8c840";
    red = "e06060";
    orange = "d4a070";
    magenta = "b49bd4";
    cyan = "70c8d4";
    pink = "d490b8";

    infoBorder = "1e4078";
    successBorder = "1e503c";
    warningBorder = "644614";
    errorBorder = "641e1e";

    selection = "2e3f5c";

    ansi = {
      black = "1a1a1a";
      red = "e06060";
      green = "70d4a0";
      yellow = "e8c840";
      blue = "7e9fdc";
      magenta = "b49bd4";
      cyan = "70c8d4";
      white = "c0c0c0";

      brightBlack = "5a5a5a";
      brightRed = "f0a0a0";
      brightGreen = "90e4b8";
      brightYellow = "f0d870";
      brightBlue = "a0b8e0";
      brightMagenta = "c8b0e0";
      brightCyan = "98dce6";
      brightWhite = "ffffff";

      dimBlack = "141414";
      dimRed = "8a4040";
      dimGreen = "4a8a6c";
      dimYellow = "9a8430";
      dimBlue = "54688c";
      dimMagenta = "78688c";
      dimCyan = "4a848c";
      dimWhite = "808080";
    };
  };

  light = {
    bg = "fdfdf7";
    panel = "f7f7f2";
    inactive = "f5f5f0";
    tabActive = "ffffff";
    surface = "ffffff";
    elevated = "ffffff";
    element = "f0f0f0";
    elementHover = "e8e8e8";
    elementActive = "dcdcdc";

    terminalBg = "fdfdf7";

    overlay = "000000";

    border = "e0e0e0";
    borderVariant = "ececec";
    borderFocused = "4a6fa5";
    borderSelected = "c4d2e6";
    borderSubtle = "cacaca";
    mutedBorder = "d0d0d0";
    hiddenBorder = "d0d0d0";

    fg = "1a1a1a";
    terminalFg = "1a1a1a";
    terminalFgBright = "000000";
    muted = "6b6b6b";
    placeholder = "9a9a9a";
    commentDoc = "888888";
    disabled = "ababab";
    invisible = "c4c4c4";
    predictive = "8a9bb8";

    accent = "4a6fa5";
    accentBright = "3a5785";
    info = "2a5090";
    green = "206040";
    yellow = "6a4a10";
    red = "8a2020";
    orange = "a0641e";
    magenta = "7a4a8a";
    cyan = "2a6a78";
    pink = "9a4a7a";

    infoBorder = "b8cce6";
    successBorder = "bbe0cc";
    warningBorder = "e6d9b0";
    errorBorder = "e6c4c4";

    selection = "c4d2e6";

    ansi = {
      black = "1a1a1a";
      red = "8a2020";
      green = "206040";
      yellow = "6a4a10";
      blue = "4a6fa5";
      magenta = "7a4a8a";
      cyan = "2a6a78";
      white = "6b6b6b";

      brightBlack = "9a9a9a";
      brightRed = "b83a3a";
      brightGreen = "2e8a5c";
      brightYellow = "9a7020";
      brightBlue = "5a7fb8";
      brightMagenta = "9a6aaa";
      brightCyan = "3a8a9a";
      brightWhite = "1a1a1a";

      dimBlack = "5a5a5a";
      dimRed = "b07070";
      dimGreen = "6fa88a";
      dimYellow = "a89060";
      dimBlue = "8aa0c4";
      dimMagenta = "a88ab4";
      dimCyan = "7aa8b0";
      dimWhite = "b0b0b0";
    };
  };
}

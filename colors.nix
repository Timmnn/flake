rec { # <--- Add 'rec' here
  primary = "#6D9DC5";

  # Function to convert rgba(RRGGBBAA) to #RRGGBB
  rgbaToHex = rgbaColor:
    let
      # Extract the hexadecimal color and alpha parts
      # This assumes the input format is always "rgba(RRGGBBAA)"
      hexColor = builtins.substring 6 6 rgbaColor;
    in "#${hexColor}";

  # Function to convert #RRGGBB to rgba(RRGGBBFF)
  # Assumes a default alpha of FF (fully opaque)
  hexToRgba = hexColor:
    let
      # Remove the '#' prefix
      colorCode =
        builtins.substring 1 (builtins.stringLength hexColor - 1) hexColor;
    in "rgba(${colorCode}ff)"; # Appends 'ff' for full opacity

  # Helper to convert a 2-digit hex string to an integer
  hexToInt = hexStr:
    let
      # Helper to convert a single hex char to its integer value
      hexCharToInt = char:
        if char == "0" then
          0
        else if char == "1" then
          1
        else if char == "2" then
          2
        else if char == "3" then
          3
        else if char == "4" then
          4
        else if char == "5" then
          5
        else if char == "6" then
          6
        else if char == "7" then
          7
        else if char == "8" then
          8
        else if char == "9" then
          9
        else if char == "a" || char == "A" then
          10
        else if char == "b" || char == "B" then
          11
        else if char == "c" || char == "C" then
          12
        else if char == "d" || char == "D" then
          13
        else if char == "e" || char == "E" then
          14
        else if char == "f" || char == "F" then
          15
        else
          throw "Invalid hex character: ${char}";
    in (hexCharToInt (builtins.substring 0 1 hexStr) * 16)
    + (hexCharToInt (builtins.substring 1 1 hexStr));

  # Helper to convert an integer (0-255) to a 2-digit hex string
  intToHex = int:
    let
      # Helper to convert an integer (0-15) to a single hex char
      intToHexChar = n:
        if n < 10 then
          builtins.toString n
        else if n == 10 then
          "A"
        else if n == 11 then
          "B"
        else if n == 12 then
          "C"
        else if n == 13 then
          "D"
        else if n == 14 then
          "E"
        else if n == 15 then
          "F"
        else
          throw "Invalid integer for hex char: ${builtins.toString n}";
      firstDigit = builtins.div int 16;
      secondDigit = builtins.mod int 16;
    in "${intToHexChar firstDigit}${intToHexChar secondDigit}";

  # Function to darken a hex color by a given percentage
  # percentage: a value between 0 and 100
  darken = hexColor: percentage:
    let
      # Remove the '#' prefix
      colorCode = builtins.substring 1 6 hexColor;

      # Extract R, G, B components as integers
      r = hexToInt
        (builtins.substring 0 2 colorCode); # <--- hexToInt is now defined
      g = hexToInt (builtins.substring 2 2 colorCode);
      b = hexToInt (builtins.substring 4 2 colorCode);

      # Calculate the darkening factor
      # E.g., for 10% darkening, factor = 0.1
      darkeningFactor = (builtins.div (percentage * 1.0) 100.0);

      # Apply darkening and ensure values don't go below 0
      newR = builtins.max 0 (r - builtins.floor (r * darkeningFactor));
      newG = builtins.max 0 (g - builtins.floor (g * darkeningFactor));
      newB = builtins.max 0 (b - builtins.floor (b * darkeningFactor));

      # Convert new RGB values back to hex
      newHexR = intToHex newR; # <--- intToHex is now defined
      newHexG = intToHex newG;
      newHexB = intToHex newB;
    in "#${newHexR}${newHexG}${newHexB}";
}

import 'package:flutter/material.dart';

class RetroColors {
  // 🔴 Vermelho retrô
  static const MaterialColor red = MaterialColor(_redPrimary, _redShades);
  static const int _redPrimary = 0xFFDE2C2C;
  static const Map<int, Color> _redShades = {
    50: Color(0xFFFBEAEA),
    100: Color(0xFFF6CACA),
    200: Color(0xFFF09A9A),
    300: Color(0xFFEB6B6B),
    400: Color(0xFFE54B4B),
    500: Color(_redPrimary),
    600: Color(0xFFC82626),
    700: Color(0xFFB32020),
    800: Color(0xFF9E1A1A),
    900: Color(0xFF731212),
  };

  // 🟢 Verde retrô
  static const MaterialColor green = MaterialColor(_greenPrimary, _greenShades);
  static const int _greenPrimary = 0xFF2C9F46;
  static const Map<int, Color> _greenShades = {
    50: Color(0xFFE6F4EB),
    100: Color(0xFFC0E3C9),
    200: Color(0xFF99D2A6),
    300: Color(0xFF73C183),
    400: Color(0xFF4CAF61),
    500: Color(_greenPrimary),
    600: Color(0xFF278E3F),
    700: Color(0xFF227E37),
    800: Color(0xFF1D6E30),
    900: Color(0xFF14501F),
  };

  // 🔵 Azul retrô
  static const MaterialColor blue = MaterialColor(_bluePrimary, _blueShades);
  static const int _bluePrimary = 0xFF3A7BD7;
  static const Map<int, Color> _blueShades = {
    50: Color(0xFFE8F1FA),
    100: Color(0xFFC5DAF2),
    200: Color(0xFFA2C2E9),
    300: Color(0xFF7FAAE1),
    400: Color(0xFF5D93D9),
    500: Color(_bluePrimary),
    600: Color(0xFF336DC2),
    700: Color(0xFF2C5FAC),
    800: Color(0xFF254F96),
    900: Color(0xFF1A386E),
  };

  // ⚫ Preto retrô
  static const MaterialColor black = MaterialColor(_blackPrimary, _blackShades);
  static const int _blackPrimary = 0xFF333333;
  static const Map<int, Color> _blackShades = {
    50: Color(0xFFEAEAEA),
    100: Color(0xFFBFBFBF),
    200: Color(0xFF969696),
    300: Color(0xFF6D6D6D),
    400: Color(0xFF4F4F4F),
    500: Color(_blackPrimary),
    600: Color(0xFF2E2E2E),
    700: Color(0xFF292929),
    800: Color(0xFF232323),
    900: Color(0xFF1A1A1A),
  };

  // 🟤 Marrom retrô
  static const MaterialColor brown = MaterialColor(_brownPrimary, _brownShades);
  static const int _brownPrimary = 0xFF8D6E63;
  static const Map<int, Color> _brownShades = {
    50: Color(0xFFF1E7E4),
    100: Color(0xFFDFCFC9),
    200: Color(0xFFCCB6AD),
    300: Color(0xFFB99E92),
    400: Color(0xFFA9877A),
    500: Color(_brownPrimary),
    600: Color(0xFF7A5C53),
    700: Color(0xFF6A4D45),
    800: Color(0xFF5B3F38),
    900: Color(0xFF402B26),
  };

  // 🟡 Amarelo retrô (mustard)
  static const MaterialColor yellow = MaterialColor(_yellowPrimary, _yellowShades);
  static const int _yellowPrimary = 0xFFF2C94C;
  static const Map<int, Color> _yellowShades = {
    50: Color(0xFFFFF9E5),
    100: Color(0xFFFDF1BE),
    200: Color(0xFFFBE997),
    300: Color(0xFFF9E170),
    400: Color(0xFFF6D94A),
    500: Color(_yellowPrimary),
    600: Color(0xFFDDB83E),
    700: Color(0xFFC3A031),
    800: Color(0xFFA98825),
    900: Color(0xFF7A6119),
  };

  // 🟠 Laranja queimado
  static const MaterialColor orange = MaterialColor(_orangePrimary, _orangeShades);
  static const int _orangePrimary = 0xFFE67E22;
  static const Map<int, Color> _orangeShades = {
    50: Color(0xFFFDEFE5),
    100: Color(0xFFFAD6BD),
    200: Color(0xFFF6BD94),
    300: Color(0xFFF3A46B),
    400: Color(0xFFEF8C42),
    500: Color(_orangePrimary),
    600: Color(0xFFCF701E),
    700: Color(0xFFB8611A),
    800: Color(0xFFA05216),
    900: Color(0xFF733A0F),
  };

  // 🟦 Azul-petróleo (teal retrô)
  static const MaterialColor teal = MaterialColor(_tealPrimary, _tealShades);
  static const int _tealPrimary = 0xFF008080;
  static const Map<int, Color> _tealShades = {
    50: Color(0xFFE0F2F2),
    100: Color(0xFFB3DCDC),
    200: Color(0xFF80C6C6),
    300: Color(0xFF4DAFAF),
    400: Color(0xFF269D9D),
    500: Color(_tealPrimary),
    600: Color(0xFF007373),
    700: Color(0xFF006666),
    800: Color(0xFF005959),
    900: Color(0xFF004040),
  };
}

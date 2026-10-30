import 'package:material_ui/material_ui.dart';

class AppColors {
  static const marinho = Color(0xFF0B2A4F);
  static const azul = Color(0xFF1E40AF);
  static const teal = Color(0xFF0E7C8B);
  static const fundo = Color(0xFFF4F7FA);
  static const textoSecundario = Color(0xFF5B6B7F);
  static const borda = Color(0xFFDDE4EC);

  static const verde = Color(0xFF166534);
  static const verdeFundo = Color(0xFFDCFCE7);
  static const vermelho = Color(0xFFDC2626);
  static const vermelhoFundo = Color(0xFFFEE2E2);
  static const ambar = Color(0xFFB45309);
  static const ambarFundo = Color(0xFFFEF3C7);
  static const azulFundo = Color(0xFFDBEAFE);
  static const cinzaFundo = Color(0xFFE5E7EB);
}

ThemeData buildAppTheme() {
  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.fundo,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.azul,
      primary: AppColors.azul,
      surface: Colors.white,
    ),
    fontFamily: 'Roboto',
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.marinho,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 1,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );
}
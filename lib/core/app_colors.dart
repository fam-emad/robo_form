import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const bg = Color(0xFF070B12);
  static const card = Color(0xFF0C131D);
  static const cardAlt = Color(0xFF0A1018);
  static const border = Color(0xFF1B2735);
  static const cyan = Color(0xFF35D0E6);
  static const red = Color(0xFFD94A5B);
  static const redDark = Color(0xFFB8334A);
  static const green = Color(0xFF2ECC71);
  static const amber = Color(0xFFE0A84C);
  static const textPrimary = Colors.white;
  static const textMuted = Color(0xFF8A97A8);
  static const textDim = Color(0xFF5C6877);

  /// ألوان التمييز بالتبادل (كروت اللجان، تاجات اللجان في صفحة النجاح).
  static const accents = [cyan, red];
  static Color accent(int index) => accents[index % accents.length];
}

import 'package:flutter/material.dart';

abstract class MovieGenreColors {
  static Map<int, Color> get _genreColors => {
        28: const Color(0xFF2B50D6),
        12: const Color(0xFF576FC2),
        16: const Color(0xFF579BC2),
        35: const Color(0xFF57C282),
        80: const Color(0xFF7E57C2),
        99: const Color(0xFFA54F00),
        18: const Color(0xFFFFCC33),
        10751: const Color(0xFF809C5F),
        14: const Color(0xFF57C2AF),
        36: const Color(0xFFA50028),
        27: const Color(0xFFD62B2B),
        10402: const Color(0xFFC2BE57),
        9648: const Color(0xFF6657C2),
        10749: const Color(0xFFC2578A),
        878: const Color(0xFF57C2AF),
        10770: const Color(0xFFC2B757),
        53: const Color(0xFF6057C2),
        10752: const Color(0xFFCECECE),
        37: const Color(0xFFC28A57),
      };

  static Color getColor(int genreId) {
    return _genreColors[genreId];
  }
}

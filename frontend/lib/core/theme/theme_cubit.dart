import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../core/storage/storage_service.dart';

// States
abstract class ThemeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ThemeInitial extends ThemeState {}
class ThemeChanged extends ThemeState {
  final ThemeMode themeMode;
  ThemeChanged(this.themeMode);
  @override
  List<Object?> get props => [themeMode];
}

// Cubit
class ThemeCubit extends Cubit<ThemeState> {
  final StorageService _storage;
  static const String _themeKey = 'app_theme_mode';

  ThemeCubit(this._storage) : super(ThemeInitial()) {
    _loadSavedTheme();
  }

  // Charger le thème sauvegardé
  Future<void> _loadSavedTheme() async {
    final savedTheme = await _storage.getString(_themeKey);
    final themeMode = _parseThemeMode(savedTheme);
    emit(ThemeChanged(themeMode));
  }

  // Changer le thème
  Future<void> toggleTheme(ThemeMode newMode) async {
    await _storage.setString(_themeKey, newMode.toString());
    emit(ThemeChanged(newMode));
  }

  // Helper pour parser la valeur sauvegardée
  ThemeMode _parseThemeMode(String? value) {
    switch (value) {
      case 'ThemeMode.light':
        return ThemeMode.light;
      case 'ThemeMode.dark':
        return ThemeMode.dark;
      case 'ThemeMode.system':
        return ThemeMode.system;
      default:
        return ThemeMode.system; // Default
    }
  }

  // Getter pratique pour l'UI
  ThemeMode get currentMode {
    if (state is ThemeChanged) {
      return (state as ThemeChanged).themeMode;
    }
    return ThemeMode.system;
  }
}
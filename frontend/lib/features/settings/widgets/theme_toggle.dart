import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../core/theme/theme_cubit.dart';

class ThemeToggle extends StatelessWidget {
  const ThemeToggle({super.key});

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.read<ThemeCubit>();

    return PopupMenuButton<ThemeMode>(
      icon: const Icon(Icons.brightness_6),
      tooltip: 'Changer le thème',
      onSelected: (ThemeMode mode) {
        themeCubit.toggleTheme(mode);
      },
      itemBuilder: (context) => [
        CheckedPopupMenuItem(
          value: ThemeMode.light,
          checked: themeCubit.currentMode == ThemeMode.light,
          child: const Row(
            children: [
              Icon(Icons.light_mode, color: Colors.orange),
              SizedBox(width: 8),
              Text('Mode Clair'),
            ],
          ),
        ),
        CheckedPopupMenuItem(
          value: ThemeMode.dark,
          checked: themeCubit.currentMode == ThemeMode.dark,
          child: const Row(
            children: [
              Icon(Icons.dark_mode, color: Colors.blue),
              SizedBox(width: 8),
              Text('Mode Sombre'),
            ],
          ),
        ),
        CheckedPopupMenuItem(
          value: ThemeMode.system,
          checked: themeCubit.currentMode == ThemeMode.system,
          child: const Row(
            children: [
              Icon(Icons.settings_brightness, color: Colors.grey),
              SizedBox(width: 8),
              Text('Système'),
            ],
          ),
        ),
      ],
    );
  }
}
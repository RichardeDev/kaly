import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';

import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../widgets/user_dashboard.dart';
import '../widgets/pro_dashboard.dart';
import '../widgets/admin_dashboard.dart';
import '../../../settings/widgets/theme_toggle.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthAuthenticated) {
          final user = state.user;
          final currentRole = user['currentRole'] as String;

          return Scaffold(
            appBar: AppBar(
              title: Text(_getDashboardTitle(currentRole)),
              centerTitle: true,
              actions: [

                const ThemeToggle(),
                // Language Selector
                PopupMenuButton<String>(
                  icon: const Icon(Icons.language),
                  onSelected: (value) {
                    context.setLocale(Locale(value));
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(value: 'fr', child: Text('Français')),
                    const PopupMenuItem(value: 'en', child: Text('English')),
                    const PopupMenuItem(value: 'mg', child: Text('Malagasy')),
                  ],
                ),
                // Logout Button
                IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: () {
                    context.read<AuthBloc>().add(AuthLogoutRequested());
                    context.go('/login');
                  },
                  tooltip: 'common.logout'.tr(),
                ),
              ],
            ),
            body: _buildDashboard(currentRole, user),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  String _getDashboardTitle(String role) {
    switch (role) {
      case 'ADMIN':
        return 'Dashboard Admin';
      case 'USER_SIMPLE':
        return 'Mon Espace';
      default:
        return 'Espace Professionnel';
    }
  }

  Widget _buildDashboard(String role, Map<String, dynamic> user) {
    if (role == 'ADMIN') {
      return const AdminDashboard();
    } else if (role.startsWith('PRO_')) {
      return ProDashboard(user: user);
    } else {
      return UserDashboard(user: user);
    }
  }
}
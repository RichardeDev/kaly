import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

// Core
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_cubit.dart';
import 'core/utils/locale_helper.dart';

// Features
import 'features/auth/presentation/bloc/auth_bloc.dart';

// Injection
import 'injection.dart';

final sl = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await EasyLocalization.ensureInitialized();
  await configureInjection();

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('fr'),
        Locale('en'),
        Locale('mg'),
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('fr'),
      startLocale: const Locale('fr'),
      useOnlyLangCode: true,
      child: const KalyApp(),
    ),
  );
}

class KalyApp extends StatelessWidget {
  const KalyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final materialLocale = LocaleHelper.getMaterialLocale(context.locale);

    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => sl<AuthBloc>(),
        ),
        BlocProvider<ThemeCubit>(
          create: (_) => sl<ThemeCubit>(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, themeState) {
          final themeMode = themeState is ThemeChanged 
              ? themeState.themeMode 
              : ThemeMode.system;

          return MaterialApp.router(
            // ───────── Localizations ─────────
            localizationsDelegates: [
              ...context.localizationDelegates,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('fr'),
              Locale('en'),
              // 'mg' géré par EasyLocalization uniquement
            ],
            locale: materialLocale,
            
            // ───────── Theme ─────────
            title: 'Kaly App',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeMode,  
            
            // ───────── Router ─────────
            routerConfig: configureRouter(),
            debugShowCheckedModeBanner: false,
            
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
                child: child!,
              );
            },
          );
        },
      ),
    );
  }
}
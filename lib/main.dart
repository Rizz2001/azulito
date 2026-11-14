import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'features/pos/presentation/main_layout_shell.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const ProviderScope(
      child: AzulitoApp(),
    ),
  );
}

class AzulitoApp extends ConsumerWidget {
  const AzulitoApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final primaryColor = ref.watch(primaryColorProvider);

    return MaterialApp(
      title: 'Azulito POS - Sistema de Punto de Venta',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.getTheme(primaryColor),
      home: const MainLayoutShell(),
    );
  }
}


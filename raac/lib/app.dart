import 'package:flutter/material.dart';
import 'package:raac/core/routing/app_router.dart';
import 'package:raac/core/theme/app_theme.dart';
import 'package:raac/features/splash/presentation/splash_screen.dart';

class RAACApp extends StatefulWidget {
  final AppRouter router;

  const RAACApp({
    super.key,
    required this.router,
  });

  @override
  State<RAACApp> createState() => _RAACAppState();
}

class _RAACAppState extends State<RAACApp> {
  late final Future<Widget> _homeFuture;

  @override
  void initState() {
    super.initState();
    _homeFuture = _resolveHome();
  }

  Future<Widget> _resolveHome() async {
    final home = await widget.router.resolveHome("mockUid");
    await Future.delayed(const Duration(milliseconds: 900));
    return home;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      home: FutureBuilder<Widget>(
        future: _homeFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const SplashScreen();
          }
          if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text('Failed to load home: ${snapshot.error}'),
              ),
            );
          }
          final home = snapshot.data;
          if (home == null) {
            return const Scaffold(
              body: Center(child: Text('No home screen available')),
            );
          }
          return home;
        },
      ),
    );
  }
}

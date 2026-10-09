import 'package:flutter/material.dart';

import 'screens/wallet_login_screen.dart';
import 'theme/wallet_colors.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wallet',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: WalletColors.orange,
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: WalletColors.background,
        // No Material ripple, highlight or hover anywhere in the app.
        splashFactory: NoSplash.splashFactory,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
      ),
      home: const WalletLoginScreen(),
    );
  }
}

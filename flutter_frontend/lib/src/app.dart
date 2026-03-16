import 'package:flutter/material.dart';
import 'package:tic_tac_toe/src/theme/app_theme.dart';
import 'package:tic_tac_toe/src/tic_tac_toe/tic_tac_toe_page.dart';

class TicTacToeApp extends StatelessWidget {
  const TicTacToeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const TicTacToePage(),
    );
  }
}

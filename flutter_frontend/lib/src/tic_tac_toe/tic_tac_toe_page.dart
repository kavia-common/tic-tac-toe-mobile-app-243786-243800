import 'package:flutter/material.dart';

class TicTacToePage extends StatefulWidget {
  const TicTacToePage({super.key});

  @override
  State<TicTacToePage> createState() => _TicTacToePageState();
}

class _TicTacToePageState extends State<TicTacToePage> {
  static const int _boardSize = 9;

  final List<String?> _board = List<String?>.filled(_boardSize, null);
  bool _xIsNext = true;

  /// If non-null, game ended in a win.
  String? _winner;

  /// True when board is full and there is no winner.
  bool _isDraw = false;

  void _resetGame() {
    setState(() {
      for (var i = 0; i < _board.length; i++) {
        _board[i] = null;
      }
      _xIsNext = true;
      _winner = null;
      _isDraw = false;
    });
  }

  void _handleTap(int index) {
    if (_winner != null || _isDraw) return;
    if (_board[index] != null) return;

    setState(() {
      _board[index] = _xIsNext ? 'X' : 'O';
      _xIsNext = !_xIsNext;

      _winner = _calculateWinner(_board);
      _isDraw = _winner == null && _board.every((c) => c != null);
    });
  }

  String _statusText() {
    if (_winner != null) return 'Winner: $_winner';
    if (_isDraw) return 'Draw';
    return 'Turn: ${_xIsNext ? 'X' : 'O'}';
  }

  Color _statusPillColor(ThemeData theme) {
    if (_winner != null) return theme.colorScheme.secondary;
    if (_isDraw) return theme.colorScheme.primary.withAlpha(28);
    return theme.colorScheme.primary.withAlpha(18);
  }

  Color _statusTextColor(ThemeData theme) {
    if (_winner != null) return theme.colorScheme.onSecondary;
    return theme.colorScheme.onSurface;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tic Tac Toe'),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _PlayerIndicators(
                    xIsNext: _xIsNext,
                    winner: _winner,
                    isDraw: _isDraw,
                  ),
                  const SizedBox(height: 14),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: _statusPillColor(theme),
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(
                        color: theme.dividerColor,
                      ),
                    ),
                    child: Text(
                      _statusText(),
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: _statusTextColor(theme),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  AspectRatio(
                    aspectRatio: 1,
                    child: _Board(
                      board: _board,
                      onTap: _handleTap,
                    ),
                  ),
                  const SizedBox(height: 18),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: _resetGame,
                      child: const Text('Reset'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Returns "X" or "O" if there is a winner, otherwise null.
String? _calculateWinner(List<String?> board) {
  const lines = <List<int>>[
    // Rows
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    // Columns
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    // Diagonals
    [0, 4, 8],
    [2, 4, 6],
  ];

  for (final line in lines) {
    final a = board[line[0]];
    final b = board[line[1]];
    final c = board[line[2]];
    if (a != null && a == b && a == c) {
      return a;
    }
  }
  return null;
}

class _PlayerIndicators extends StatelessWidget {
  const _PlayerIndicators({
    required this.xIsNext,
    required this.winner,
    required this.isDraw,
  });

  final bool xIsNext;
  final String? winner;
  final bool isDraw;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final xActive = winner == null && !isDraw && xIsNext;
    final oActive = winner == null && !isDraw && !xIsNext;

    return Row(
      children: [
        Expanded(
          child: _IndicatorCard(
            label: 'Player X',
            active: xActive,
            symbol: 'X',
            activeColor: theme.colorScheme.primary,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _IndicatorCard(
            label: 'Player O',
            active: oActive,
            symbol: 'O',
            activeColor: theme.colorScheme.secondary,
          ),
        ),
      ],
    );
  }
}

class _IndicatorCard extends StatelessWidget {
  const _IndicatorCard({
    required this.label,
    required this.active,
    required this.symbol,
    required this.activeColor,
  });

  final String label;
  final bool active;
  final String symbol;
  final Color activeColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: theme.cardTheme.color,
        border: Border.all(
          color: active ? activeColor.withAlpha(140) : theme.dividerColor,
          width: active ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(8),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: active
                  ? activeColor.withAlpha(30)
                  : theme.colorScheme.primary.withAlpha(16),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: active ? activeColor.withAlpha(120) : theme.dividerColor,
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              symbol,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
                color: active ? activeColor : theme.colorScheme.onSurface,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Board extends StatelessWidget {
  const _Board({
    required this.board,
    required this.onTap,
  });

  final List<String?> board;
  final void Function(int index) onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: theme.cardTheme.color,
        border: Border.all(color: theme.dividerColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(10),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: board.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemBuilder: (context, index) {
          final value = board[index];
          return _Cell(
            value: value,
            onTap: () => onTap(index),
          );
        },
      ),
    );
  }
}

class _Cell extends StatelessWidget {
  const _Cell({
    required this.value,
    required this.onTap,
  });

  final String? value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final isX = value == 'X';
    final isO = value == 'O';

    final Color symbolColor;
    if (isX) {
      symbolColor = theme.colorScheme.primary;
    } else if (isO) {
      symbolColor = theme.colorScheme.secondary;
    } else {
      symbolColor = theme.colorScheme.onSurface.withAlpha(120);
    }

    return Material(
      color: theme.colorScheme.surface,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: theme.dividerColor),
            color: theme.colorScheme.surface,
          ),
          alignment: Alignment.center,
          child: Text(
            value ?? '',
            style: theme.textTheme.displaySmall?.copyWith(
              fontWeight: FontWeight.w900,
              letterSpacing: 1.5,
              color: symbolColor,
            ),
          ),
        ),
      ),
    );
  }
}

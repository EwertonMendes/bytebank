import 'package:flutter/material.dart';

import 'screens/transferencia/lista.dart';

void main() {
  runApp(const BytebankApp());
}

class BytebankApp extends StatelessWidget {
  const BytebankApp({Key? key}) : super(key: key);

  ThemeData theme1() {
    return ThemeData(
        colorScheme: ColorScheme(
            primary: Colors.indigo[900]!,
            onPrimary: Colors.white,
            secondary: Colors.indigo[500]!,
            onSecondary: Colors.white,
            error: Colors.red[900]!,
            onError: Colors.white,
            background: Colors.white,
            brightness: Brightness.light,
            onBackground: Colors.white,
            onSurface: Colors.white,
            surface: Colors.white));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ListaTransferencias(),
      theme: theme1(),
    );
  }
}

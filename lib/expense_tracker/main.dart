import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test/expense_tracker/widget/main_expense.dart';

var kColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 179, 59, 181));

var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 5, 99, 125),
);

getTheme(ColorScheme colorScheme) {
  return ThemeData(
    colorScheme: colorScheme,
    appBarTheme: AppBarTheme(
      // color: const Color.fromARGB(127, 136, 59, 181),
      backgroundColor: colorScheme.onPrimaryContainer,
      foregroundColor: colorScheme.primaryContainer,
    ),
    textTheme: ThemeData().textTheme.copyWith(
          titleLarge: GoogleFonts.montserrat(
              fontWeight: FontWeight.bold,
              color: colorScheme.onSecondaryContainer,
              fontSize: 16),
        ),
    cardTheme: CardTheme(
      color: Colors.purple[50],
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.primaryContainer,
      ),
    ),
    snackBarTheme: SnackBarThemeData(
        actionTextColor: Colors.red,
        backgroundColor: Colors.deepPurple[100],
        contentTextStyle: const TextStyle(color: Colors.black)),
  );
}

// 畫面不會跟螢幕旋轉
// void main() {
//   // 防止畫面會跟著螢幕旋轉
//   // 1. WidgetsFlutterBinding.ensureInitialized();
//   //    確保螢幕已經初始化
//   WidgetsFlutterBinding.ensureInitialized();
//   // 設置畫面的方向
//   // 2. SystemChrome.setPreferredOrientations([...])
//   //    限制畫面只能是直立方向 (portraitUp)
//   SystemChrome.setPreferredOrientations([
//     DeviceOrientation.portraitUp,
//   ]).then((fn) {
//     runApp(MaterialApp(
//       darkTheme: getTheme(kDarkColorScheme),
//       theme: getTheme(kColorScheme),
//       home: const ExpenseTracker(),
//     ));
//   });
// }

// 畫面會跟螢幕旋轉
void main() {
  runApp(MaterialApp(
    darkTheme: getTheme(kDarkColorScheme),
    theme: getTheme(kColorScheme),
    home: const ExpenseTracker(),
  ));
}

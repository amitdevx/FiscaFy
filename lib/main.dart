import 'package:expense_tracker/expenses.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

var kColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 0, 95, 247));
var kDarkModeScheme = ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 255, 255, 255));
void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
  //     .then((fn) {
  //   runApp(const MyApp());
  // });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: kDarkModeScheme,
        // appBarTheme: AppBarTheme().copyWith(
        //   backgroundColor: kColorScheme.onPrimaryFixedVariant,
        //   foregroundColor: kColorScheme.onSecondary,
        // ),
        dialogTheme: const DialogTheme().copyWith(
          backgroundColor: kColorScheme.inverseSurface,
        ),
        snackBarTheme: const SnackBarThemeData().copyWith(
          backgroundColor: kColorScheme.inverseSurface,
          // actionBackgroundColor: kColorScheme.inverseSurface
        ),

        bottomAppBarTheme: BottomAppBarTheme()
            .copyWith(color: const Color.fromARGB(255, 1, 42, 110)),
        floatingActionButtonTheme: FloatingActionButtonThemeData().copyWith(
          backgroundColor: kColorScheme.onSurface,
          foregroundColor: kColorScheme.onPrimary,
        ),
        bottomSheetTheme: const BottomSheetThemeData().copyWith(
          backgroundColor: kDarkModeScheme.outlineVariant,
        ),
        cardTheme: CardTheme().copyWith(
          color: kDarkModeScheme.onTertiaryFixedVariant,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kDarkModeScheme.primaryContainer,
          ),
        ),
      ),

      /// ThemeData is a class that holds the color, typography, and other visual properties of a material design theme.
      theme: ThemeData().copyWith(
        colorScheme: kColorScheme,
        // appBarTheme: AppBarTheme().copyWith(
        //   backgroundColor: kColorScheme.onPrimaryFixed,
        //   foregroundColor: kColorScheme.onSecondary,
        // ),
        bottomAppBarTheme: BottomAppBarTheme()
            .copyWith(color: const Color.fromARGB(255, 1, 42, 110)),
        floatingActionButtonTheme: FloatingActionButtonThemeData().copyWith(
          backgroundColor: kColorScheme.surface,
          foregroundColor: kColorScheme.onPrimaryContainer,
        ),
        cardTheme: CardTheme().copyWith(
          color: kColorScheme.onTertiary,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.primaryContainer,
          ),
        ),
        popupMenuTheme:
            PopupMenuThemeData().copyWith(color: kColorScheme.onTertiary),
        iconButtonTheme: IconButtonThemeData(
            style: IconButton.styleFrom(
          foregroundColor: kColorScheme.primaryContainer,
          backgroundColor: kColorScheme.onPrimaryContainer,
        )),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.normal,
                color: kColorScheme.onSecondaryContainer,
              ),
            ),
      ),
      themeMode: ThemeMode.system,
      home: const Expenses(),
    );
  }
}

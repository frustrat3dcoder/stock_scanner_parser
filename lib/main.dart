import 'package:flutter/material.dart';
import 'package:stock_scan_parser/utilities/utilities.dart';
import './injector.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init(); // dependency injector initialized
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stock Scan Parser',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        scaffoldBackgroundColor: Colors.black,
      ),
      initialRoute: RoutesName.stockScanHome,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}

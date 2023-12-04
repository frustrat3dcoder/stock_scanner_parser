import 'package:stock_scan_parser/presentation_layer/screens.dart';
import 'routes_name.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.stockScanHome:
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const StockListScreen());

      case RoutesName.stockDetailTile:
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const StockDetailScreen());

      default:
        throw Error();
    }
  }
}

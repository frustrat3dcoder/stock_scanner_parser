import 'package:stock_scan_parser/domain_layer/domain_layer.dart';

extension FailureParser on Failure {
  String mapFailureToMessage() {
    switch (runtimeType) {
      case const (ServerFailure):
        return "Oops, Server Error. Please try again!";
      case const (CacheFailure):
        return "Oops, cache failed. Please try again!";

      default:
        return "Oops, something went wrong. Please try again!";
    }
  }
}

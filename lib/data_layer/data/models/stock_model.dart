import 'package:equatable/equatable.dart';
import 'package:stock_scan_parser/domain_layer/domain_layer.dart';

class StockScanModel extends StockScanEntity with EquatableMixin {
  const StockScanModel({
    super.id,
    super.name,
    super.tag,
    super.color,
    super.criteria,
  });

  factory StockScanModel.fromJson(Map<String, dynamic> json) {
    return StockScanModel(
        id: json['id'] as int?,
        name: json['name'] as String?,
        tag: json['tag'] as String?,
        color: json['color'] as String?,
        criteria: (json['criteria'] as List?)
            ?.map((dynamic e) =>
                CriteriaEntity.fromJson(e as Map<String, dynamic>))
            .toList());
  }

  @override
  List<Object?> get props => [id, name, tag, color, criteria];
}

class CriteriaModel extends CriteriaEntity with EquatableMixin {
  const CriteriaModel({
    super.type,
    super.text,
  });

  factory CriteriaModel.fromJson(Map<String, dynamic> json) {
    return CriteriaModel(
        type: json['type'] as String?, text: json['text'] as String?);
  }

  @override
  List<Object?> get props => [type, text];
}

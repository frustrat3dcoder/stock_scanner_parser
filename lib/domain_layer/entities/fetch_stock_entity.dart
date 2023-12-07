import 'package:equatable/equatable.dart';

class StockScanEntity extends Equatable {
  final int? id;
  final String? name;
  final String? tag;
  final String? color;
  final List<CriteriaEntity>? criteria;

  const StockScanEntity({
    this.id,
    this.name,
    this.tag,
    this.color,
    this.criteria,
  });

  StockScanEntity.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?,
        tag = json['tag'] as String?,
        color = json['color'] as String?,
        criteria = (json['criteria'] as List?)
            ?.map((dynamic e) =>
                CriteriaEntity.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'tag': tag,
        'color': color,
        'criteria': criteria?.map((e) => e.toJson()).toList()
      };

  @override
  List<Object?> get props => [id, name, tag, color, criteria];
}

class CriteriaEntity extends Equatable {
  final String? type;
  final String? text;
  final Map<String, dynamic>? variable;

  const CriteriaEntity({this.type, this.text, this.variable});

  CriteriaEntity.fromJson(Map<String, dynamic> json)
      : type = json['type'] as String?,
        variable = json['variable'] as Map<String, dynamic>? ?? {},
        text = json['text'] as String?;

  Map<String, dynamic> toJson() =>
      {'type': type, 'text': text, 'variable': 'variable'};

  @override
  List<Object?> get props => [type, text, variable];
}

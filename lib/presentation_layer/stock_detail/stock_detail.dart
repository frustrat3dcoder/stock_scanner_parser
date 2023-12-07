import 'package:flutter/material.dart';
import 'package:stock_scan_parser/domain_layer/domain_layer.dart';
import 'package:stock_scan_parser/presentation_layer/widgets/custom_stock_parameter_tile.dart';
import 'package:stock_scan_parser/utilities/utilities.dart';

class StockDetailScreen extends StatefulWidget {
  const StockDetailScreen({super.key, required this.stockScanEntity});

  final StockScanEntity stockScanEntity;

  @override
  State<StockDetailScreen> createState() => _StockDetailScreenState();
}

class _StockDetailScreenState extends State<StockDetailScreen> {
  bool valueEditPressed = false;
  int selectedEditValueIndex = 0;
  String selectedKey = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                visible: valueEditPressed == false,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 15.0),
                  color: Colors.blue.shade200,
                  height: 80,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.stockScanEntity.name!,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 18.0),
                      ),
                      Text(
                        widget.stockScanEntity.tag!,
                        style: TextStyle(
                            color:
                                widget.stockScanEntity.color!.stringToColor(),
                            fontWeight: FontWeight.w700,
                            fontSize: 13.0),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                  child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.stockScanEntity.criteria!.length,
                itemBuilder: (context, index) {
                  List<String> stringSpanList =
                      widget.stockScanEntity.criteria![index].text!.split(' ');
                  return CustomParameterTile(
                    stringSpanList: stringSpanList,
                    index: index,
                    stockScanEntity: widget.stockScanEntity,
                    changeValue: (p0) {
                      setState(() {
                        valueEditPressed = true;
                        selectedEditValueIndex = p0.$1;
                        selectedKey = p0.$2;
                      });
                    },
                  );
                },
              )),
            ],
          ),
        ),
      ),
    );
  }
}

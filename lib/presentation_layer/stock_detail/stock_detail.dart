import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stock_scan_parser/domain_layer/domain_layer.dart';
import 'package:stock_scan_parser/utilities/utilities.dart';

class StockDetailScreen extends StatelessWidget {
  const StockDetailScreen({super.key, required this.stockScanEntity});

  final StockScanEntity stockScanEntity;

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
              Container(
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
                      stockScanEntity.name!,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 18.0),
                    ),
                    Text(
                      stockScanEntity.tag!,
                      style: TextStyle(
                          color: stockScanEntity.color!.stringToColor(),
                          fontWeight: FontWeight.w700,
                          fontSize: 13.0),
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: ListView.builder(
                shrinkWrap: true,
                itemCount: stockScanEntity.criteria!.length,
                itemBuilder: (context, index) {
                  List<String> stringSpanList =
                      stockScanEntity.criteria![index].text!.split(' ');
                  return CustomParameterTile(
                      stringSpanList: stringSpanList,
                      index: index,
                      stockScanEntity: stockScanEntity);
                },
              )),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomParameterTile extends StatefulWidget {
  const CustomParameterTile(
      {super.key,
      required this.stringSpanList,
      required this.stockScanEntity,
      required this.index});

  final List<String> stringSpanList;
  final StockScanEntity stockScanEntity;
  final int index;

  @override
  State<CustomParameterTile> createState() => _CustomParameterTileState();
}

class _CustomParameterTileState extends State<CustomParameterTile> {
  List<String> stringSpanList = [];
  late StockScanEntity stockScanEntity;

  @override
  void initState() {
    stringSpanList = widget.stringSpanList;
    stockScanEntity = widget.stockScanEntity;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: stringSpanList
          .map((e) =>
              stockScanEntity.criteria![widget.index].variable!.containsKey(e)
                  ? GestureDetector(
                      onTap: () => updateValue(e),
                      child: RichText(
                        text: TextSpan(
                            text: "(${e.replaceAll('\$', '')}) ",
                            style: const TextStyle(color: Colors.blue)),
                      ),
                    )
                  : Text(
                      "$e ",
                      style: const TextStyle(color: Colors.white),
                    ))
          .toList(),
    );
  }

  updateValue(String e) {
    int index = stringSpanList.indexWhere(
      (element) => element == e,
    );

    setState(() {
      stringSpanList[index] = "\$2";
      final value = stockScanEntity.criteria![widget.index].variable![e];

      stockScanEntity.criteria![widget.index].variable!.addAll({'\$2': value});
    });
  }
}

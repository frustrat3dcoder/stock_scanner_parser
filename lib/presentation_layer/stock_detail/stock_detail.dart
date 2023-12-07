import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stock_scan_parser/domain_layer/domain_layer.dart';
import 'package:stock_scan_parser/presentation_layer/widgets/custom_seperator.dart';
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

class CustomParameterTile extends StatefulWidget {
  const CustomParameterTile(
      {super.key,
      required this.stringSpanList,
      required this.stockScanEntity,
      required this.index,
      required this.changeValue});

  final List<String> stringSpanList;
  final StockScanEntity stockScanEntity;
  final int index;
  final Function((int selectedIndex, String selectedKey)) changeValue;

  @override
  State<CustomParameterTile> createState() => _CustomParameterTileState();
}

class _CustomParameterTileState extends State<CustomParameterTile> {
  List<String> stringSpanList = [];
  late StockScanEntity stockScanEntity;
  late TextEditingController _textEditingController;

  @override
  void initState() {
    stringSpanList = widget.stringSpanList;
    stockScanEntity = widget.stockScanEntity;
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: stringSpanList
          .map((e) =>
              stockScanEntity.criteria![widget.index].variable!.containsKey(e)
                  ? GestureDetector(
                      onTap: () => updateValue(context, e),
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

  updateValue(BuildContext context, String e) {
    openBottomSheet(context, e);
    // widget.changeValue((widget.index, e));

    // int index = stringSpanList.indexWhere(
    //   (element) => element == e,
    // );

    // setState(() {
    //   stringSpanList[index] = "\$2";
    //   final value = stockScanEntity.criteria![widget.index].variable![e];

    //   stockScanEntity.criteria![widget.index].variable!.addAll({'\$2': value});
    // });
  }

  void openBottomSheet(BuildContext context, String key) {
    GlobalKey<FormState> _formFieldKey = GlobalKey();
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      backgroundColor: const Color(0xff232323),
      builder: (context) {
        return stockScanEntity.criteria![widget.index].variable![key]['type'] ==
                'value'
            ? ListView.separated(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                itemCount: stockScanEntity
                    .criteria![widget.index].variable![key]['values'].length,
                itemBuilder: (context, index) => ListTile(
                  onTap: () {
                    int keyIndex =
                        stringSpanList.indexWhere((element) => element == key);

                    if (keyIndex != -1) {
                      setState(() {
                        stringSpanList[keyIndex] =
                            "\$${stockScanEntity.criteria![widget.index].variable![key]['values'][index]}";
                        final value = stockScanEntity
                            .criteria![widget.index].variable![key];

                        stockScanEntity.criteria![widget.index].variable!
                            .addAll({
                          "\$${stockScanEntity.criteria![widget.index].variable![key]['values'][index]}":
                              value
                        });
                      });
                      Navigator.pop(context);
                    }
                  },
                  title: Text(
                    stockScanEntity
                        .criteria![widget.index].variable![key]['values'][index]
                        .toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                separatorBuilder: (context, index) => const DottedDivider(),
              )
            : SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                    left: 10,
                    right: 10,
                    top: 10,
                  ),
                  color: Colors.white,
                  // height: 150,
                  width: double.infinity,
                  child: Form(
                    key: _formFieldKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        buildTextFormField(
                          value: stockScanEntity.criteria![widget.index]
                              .variable![key]['default_value']
                              .toString(),
                          min: stockScanEntity.criteria![widget.index]
                              .variable![key]['min_value'],
                          max: stockScanEntity.criteria![widget.index]
                              .variable![key]['max_value'],
                        ),
                        const SizedBox(height: 16.0),
                        Container(
                          width: 150,
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formFieldKey.currentState!.validate()) {
                                int keyIndex = stringSpanList
                                    .indexWhere((element) => element == key);

                                if (keyIndex != -1) {
                                  setState(() {
                                    stringSpanList[keyIndex] =
                                        "\$${_textEditingController.text}";

                                    stockScanEntity.criteria![widget.index]
                                            .variable![key]['default_value'] =
                                        _textEditingController.text;
                                    stockScanEntity
                                        .criteria![widget.index].variable!
                                        .addAll({
                                      "\$${_textEditingController.text}":
                                          stockScanEntity
                                              .criteria![widget.index]
                                              .variable![key]
                                    });
                                  });
                                }
                                _textEditingController.clear();
                                Navigator.pop(context);
                              }
                            },
                            child: Text('Save'),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                      ],
                    ),
                  ),
                ),
              );
      },
    );
  }

  buildTextFormField(
      {required String value, required int min, required int max}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: _textEditingController,
        keyboardType: TextInputType.number,
        validator: (newValue) {
          if (newValue!.isNotEmpty) {
            if (int.parse(newValue) < min || int.parse(newValue) > max) {
              return "Value should be between $min and $max";
            }
            return null;
          }
        },
        decoration: InputDecoration(
          hintText: value,
          errorStyle: const TextStyle(color: Colors.red),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }
}

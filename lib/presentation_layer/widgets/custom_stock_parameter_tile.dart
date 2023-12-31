import 'package:flutter/material.dart';
import 'package:stock_scan_parser/domain_layer/domain_layer.dart';
import 'package:stock_scan_parser/utilities/utilities.dart';

import 'custom_seperator.dart';

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

  void saveIndicatorData(String key) {
    // index to separate or replace it within stringSpanList
    int keyIndex = stringSpanList.indexWhere((element) => element == key);

    //keyIndex -1 means it doesn't exist in list
    if (keyIndex != -1) {
      setState(() {
        stringSpanList[keyIndex] =
            "\$${_textEditingController.text}"; // replacing curentValue within List<String>

        stockScanEntity.criteria![widget.index].variable![key]
                ['default_value'] =
            _textEditingController
                .text; // changing the value within variable so it can be save for future reference
        stockScanEntity.criteria![widget.index].variable!.addAll({
          "\$${_textEditingController.text}":
              stockScanEntity.criteria![widget.index].variable![key]
        }); // adding new variable so that we can highlight specific richText
      });
    }
    _textEditingController.clear(); // clearing default text controller
    Navigator.pop(context); // closing bottomsheet
  }

  void updateVariableValueType(String key, int index) {
    int keyIndex = stringSpanList.indexWhere((element) => element == key);

    //keyIndex -1 means it doesn't exist in list
    if (keyIndex != -1) {
      setState(() {
        stringSpanList[keyIndex] =
            "\$${stockScanEntity.criteria![widget.index].variable![key]['values'][index]}"; // changing the value within variable so it can be save for future reference
        final value = stockScanEntity.criteria![widget.index].variable![key];

        stockScanEntity.criteria![widget.index].variable!.addAll({
          "\$${stockScanEntity.criteria![widget.index].variable![key]['values'][index]}":
              value
        }); // adding new variable so that we can highlight specific richText
      });
      Navigator.pop(context); // closing bottomsheet
    }
  }

  @override
  Widget build(BuildContext context) {
    // This is the core logic where StringSpanList and variable key value is
    // responsible for showing widget in highlighted so that it can be edited
    return ListTile(
      minLeadingWidth: 0,
      title: Wrap(
        crossAxisAlignment: WrapCrossAlignment.end,
        children: stringSpanList
            .map((e) =>
                stockScanEntity.criteria![widget.index].variable!.containsKey(e)
                    ? GestureDetector(
                        onTap: () => openBottomSheet(context, e),
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
      ),
    );
  }

  void openBottomSheet(BuildContext context, String key) {
    GlobalKey<FormState> formFieldKey = GlobalKey();
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      backgroundColor: const Color(0xff232323),
      builder: (context) {
        return stockScanEntity.criteria![widget.index].variable![key]['type'] ==
                StockCriteriaEnum.value.name
            ? variableValueListView(key)
            : SingleChildScrollView(
                child: indicatorWidget(context, formFieldKey, key),
              );
      },
    );
  }

  Widget variableValueListView(String key) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      itemCount: stockScanEntity
          .criteria![widget.index].variable![key]['values'].length,
      itemBuilder: (context, index) => ListTile(
        onTap: () => updateVariableValueType(key, index),
        title: Text(
          stockScanEntity
              .criteria![widget.index].variable![key]['values'][index]
              .toString(),
          style: const TextStyle(color: Colors.white),
        ),
      ),
      separatorBuilder: (context, index) => const DottedDivider(),
    );
  }

  Widget indicatorWidget(
      BuildContext context, GlobalKey<FormState> formFieldKey, String key) {
    return Container(
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
        key: formFieldKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildTextFormField(
              value: stockScanEntity
                  .criteria![widget.index].variable![key]['default_value']
                  .toString(),
              min: stockScanEntity.criteria![widget.index].variable![key]
                  ['min_value'],
              max: stockScanEntity.criteria![widget.index].variable![key]
                  ['max_value'],
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              width: 150,
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  if (formFieldKey.currentState!.validate()) {
                    saveIndicatorData(key);
                  }
                },
                child: const Text('Save'),
              ),
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }

  buildTextFormField(
      {required String value, required int min, required int max}) {
    _textEditingController.text = value;
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
          return null;
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

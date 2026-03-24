import 'package:flutter/material.dart';

class Convertor extends StatefulWidget {
  const Convertor({super.key, required this.currencies, required this.result});

  final Map currencies;
  final Map result;

  @override
  State<Convertor> createState() => _ConvertorState();
}

class _ConvertorState extends State<Convertor> {
  TextEditingController amountController = TextEditingController();

  String dropdownValue1 = '';
  String dropdownValue2 = '';
  String answer = '';

  final formkey = GlobalKey<FormState>();

  void getResult(String amount, String baseCurr, String finalCurr) {
    String output =
        ((double.parse(amount) * widget.result[finalCurr]) /
                widget.result[baseCurr])
            .toStringAsFixed(2)
            .toString();

    setState(() {
      answer = ' The converted amount is $output';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Convert Currency',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return DropdownMenu<String>(
                        hintText: 'Select',
                        width: constraints.maxWidth,
                        menuStyle: MenuStyle(
                          fixedSize: WidgetStateProperty.all(
                            Size(constraints.maxWidth, 300),
                          ),
                        ),
                        dropdownMenuEntries: widget.currencies.keys
                            .toSet()
                            .toList()
                            .map<DropdownMenuEntry<String>>(
                              (e) =>
                                  DropdownMenuEntry<String>(label: e, value: e),
                            )
                            .toList(),
                        onSelected: (String? value) {
                          setState(() {
                            dropdownValue1 = value!;
                          });
                        },
                      );
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Text('To'),
                ),
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return DropdownMenu<String>(
                        hintText: 'Select',
                        width: constraints.maxWidth,
                        menuStyle: MenuStyle(
                          fixedSize: WidgetStateProperty.all(
                            Size(constraints.maxWidth, 300),
                          ),
                        ),
                        dropdownMenuEntries: widget.currencies.keys
                            .toSet()
                            .toList()
                            .map<DropdownMenuEntry<String>>(
                              (e) =>
                                  DropdownMenuEntry<String>(label: e, value: e),
                            )
                            .toList(),
                        onSelected: (String? value) {
                          setState(() {
                            dropdownValue2 = value!;
                          });
                        },
                      );
                    },
                  ),
                ),
              ],
            ),

            SizedBox(height: 20),
            TextFormField(
              key: ValueKey('amount'),
              controller: amountController,
              decoration: InputDecoration(
                hintText: 'Enter Amount',
                border: OutlineInputBorder(borderSide: BorderSide()),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  getResult(
                    amountController.text,
                    dropdownValue1,
                    dropdownValue2,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(5),
                  ),
                ),
                child: Text('Convert', style: TextStyle(fontSize: 18)),
              ),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text(answer)],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:currency_converter/components/convertor.dart';
import 'package:currency_converter/functions/functions.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<Map> allcurrencies;
  late Future<Map> result;

  @override
  void initState() {
    super.initState();
    setState(() {
      allcurrencies = fetchcurrencies();
      result = fetchRates();
    });
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.currency_exchange_outlined),
            SizedBox(width: 8),
            Text(
              'Currency Convertor',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ],
        ),
        titleSpacing: 0,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Container(
        height: h,
        width: w,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Center(
            child: FutureBuilder<Map>(
              future: allcurrencies,
              builder: (context, snapshot1) {
                if (snapshot1.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                return FutureBuilder(
                  future: result,
                  builder: (context, snapshot2) {
                    if (snapshot2.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    return Center(
                      child: Convertor(
                        currencies: snapshot1.data!,
                        result: snapshot2.data!,
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

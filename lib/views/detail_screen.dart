import 'package:flutter/material.dart';
import 'package:tatpmmobil/models/api_data_source.dart';
import '../models/currency_model.dart';
import '../models/product_model.dart';

class DetailProd extends StatefulWidget {
  final Products product;
  const DetailProd({super.key, required this.product});

  @override
  State<DetailProd> createState() => _DetailProdState();
}

class _DetailProdState extends State<DetailProd> {
  double exchangeRate=1;
  late Currency currency;

  @override
  void initState() {
    loadExchange();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail'),
      ),
      body: _buildProductBody(),
    );
  }

  Widget _buildProductBody(){
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children:[
            Image.network('${widget.product.thumbnail}'),
            Text('${widget.product.shoeName} (${widget.product.brand})'),
            SizedBox(height: 10),
            Text("Realese Date : "),
            Text('${widget.product.releaseDate}'),
            SizedBox(height: 10),
            Icon(Icons.attach_money, size: 18),
            Text((widget.product.retailPrice!.toDouble()*exchangeRate).toString()),

            ElevatedButton(
                onPressed: () {
                  setState(() {
                    exchangeRate = currency.conversionRates!.iDR!;
                  });
                },
                child: Text("IDR"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  exchangeRate = currency.conversionRates!.uSD! as double;
                });
              },
              child: Text("USD"),
            )
          ]
        ),
      ),
    );
  }

  void loadExchange(){
    ApiDataSource.instance.getCurrency().then((data){
      setState(() {
        currency = Currency.fromJson(data);
      });
    }).catchError((error){
      print('error');
    });
  }
}

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
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
  double exchangeRate = 1;
  late Currency currency;
  String selectedCurrency = 'USD';
  List<IconData> iconFavStyle = [
    Icons.star_border_outlined,
    Icons.star
  ];
  List<String> favs = [];
  int isFav = 0;
  final GetStorage storage = GetStorage('favorites');
  final GetStorage session = GetStorage('session');
  late String username = session.read('username');

  @override
  void initState() {
    loadExchange();
    loadFav();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.product.shoeName}', style: TextStyle(fontSize: 24)),
        actions: [
          IconButton(
            icon: Icon(iconFavStyle[isFav]),
            onPressed: reverseFav,
          )
        ],
      ),
      body: _buildProductBody(),
    );
  }

  Widget _buildProductBody() {
    return SingleChildScrollView(
        child: Column(
          children: [
            Image.network('${widget.product.thumbnail}', width: 400,),
            SizedBox(height: 10),
            Text(
              '${widget.product.shoeName}',
              style: TextStyle(fontSize: 22),
            ),
            SizedBox(height: 10),
            Text(
              "${widget.product.brand}",
              style: TextStyle(fontSize: 18),
            ),
            Text(
              "Release Date: ${widget.product.releaseDate}",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$selectedCurrency ',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Text(
                  (widget.product.retailPrice!.toDouble() * exchangeRate).toStringAsFixed(2),
                  style: TextStyle(fontSize: 22),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      exchangeRate = currency.conversionRates!.iDR!;
                      selectedCurrency = 'IDR';
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    textStyle: TextStyle(fontSize: 18),
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: Text("IDR"),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      exchangeRate = currency.conversionRates!.uSD! as double;
                      selectedCurrency = 'USD';
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    textStyle: TextStyle(fontSize: 18),
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: Text("USD"),
                ),
              ],
            ),
          ],
        ),
      );
  }

  void loadExchange() {
    ApiDataSource.instance.getCurrency().then((data) {
      setState(() {
        currency = Currency.fromJson(data);
      });
    }).catchError((error) {
      print('error');
    });
  }

  void loadFav(){
    if(storage.hasData(username)){
      setState(() {
        favs = storage.read(username);
        if(favs.contains(widget.product.sId)) {
          isFav = 1;
        }else{
          isFav = 0;
        }
      });

    }else{
      setState(() {
        storage.write(username,[]);
      });
    }
    print(favs);
  }

  void reverseFav(){
    setState(() {
      isFav=(isFav-1).abs();
      if(favs.contains(widget.product.sId)){
        favs.remove(widget.product.sId);
      }else{
        favs.add(widget.product.sId!);
      }
      print(favs);
      storage.write(username,favs);
    });
  }
}

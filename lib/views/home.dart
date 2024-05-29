import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tatpmmobil/models/most_popular_model.dart';
import 'package:tatpmmobil/models/product_model.dart';
import 'package:tatpmmobil/models/search.dart';
import 'package:tatpmmobil/views/detail_screen.dart';
import '../models/api_data_source.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String sId = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sneakers Store"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                  context: context,
                  delegate: SearchShoe()
              );
            },
          )
        ],
      ),
      body: _buildProductsBody()
    );
  }

  Widget _buildProductsBody(){
    return FutureBuilder(
      future: ApiDataSource.instance.getProducts(sId),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
        if(snapshot.hasError){
          print(snapshot.data.runtimeType);
          print(snapshot.error.toString());
          return _buildErrorSection();
        }
        if(snapshot.hasData){
          // MostPopular mostPopular = MostPopular.fromJson(snapshot.data);
          // return _buildSuccessSection(mostPopular);
          var data = snapshot.data;
          return _buildSuccessSection(data);
        }
        return _buildLoadingSection();
      },
    );
  }

  Widget _buildErrorSection(){
    return Container(
      child: Text("Ada Error _buildErrorSection "),
    );
  }

  Widget _buildLoadingSection(){
    return CircularProgressIndicator();
  }

  // Widget _buildSuccessSection(List<dynamic> popular){
  //   return ListView.builder(
  //       itemCount: popular.length,
  //       itemBuilder: (BuildContext context, int index){
  //         return _buildItemPopular(jsonDecode(popular.toString())[index]);
  //       }
  //   );
  // }

  Widget _buildSuccessSection(List<dynamic> prod) {
    return ListView.builder(
        itemCount: prod.length,
        itemBuilder: (BuildContext context, int index) {
          Products tes = Products.fromJson(prod[index]);
          return _buildItemProducts(tes);
        });
  }

  Widget _buildItemProducts(Products prod) {
    return InkWell(
      onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context)
      {
        return DetailProd(product: prod);
      }));
      },
      child: Card(
        child: Row(
          children: [
            SizedBox(
              width: 100,
              child: Image.network(prod.thumbnail!),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(prod.brand!),
                  Text(prod.shoeName!),
                  Row(
                    children: [
                      Icon(Icons.attach_money, size: 18),
                      Text(prod.retailPrice!.toString())
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

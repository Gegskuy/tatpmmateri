import 'dart:js';
import 'package:flutter/material.dart';
import 'package:tatpmmobil/models/product_model.dart';

import 'api_data_source.dart';

class SearchShoe extends SearchDelegate{
  String sId = "";
  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return _buildProductsBody();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    return Center(
      child: Text('Search Shoes'),
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
      onTap: () {},
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
                  Text(prod.retailPrice!.toString())
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
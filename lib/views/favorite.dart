import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tatpmmobil/models/api_data_source.dart';
import 'package:tatpmmobil/models/product_model.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final fav = GetStorage('favorites');
  final session = GetStorage('session');
  late String username;
  late List<String> userFav;
  List<Products> products = [];
  List<Products> filteredList = [];

  List<IconData> iconFavStyle = [
    Icons.star_border,
    Icons.star,
  ];

  @override
  void initState() {
    super.initState();
    username = session.read('username') ?? '';
    userFav = List<String>.from(fav.read(username) ?? []);
    print('Username: $username');
    print('User Favorites: $userFav');
    loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Favorites'),
        ),
        body: Center(
          child: filteredList.isEmpty
              ? Text('No favorites yet')
              : ListView.separated(
            itemBuilder: (context, index) {
              int state = userFav.contains(filteredList[index].sId) ? 1 : 0;
              return Container(
                child: Card(
                  child: ListTile(
                    title: Text(filteredList[index].shoeName!),
                    trailing: IconButton(
                      onPressed: () {
                        setState(() {
                          if (state == 1) {
                            userFav.remove(filteredList[index].sId);
                          } else {
                            userFav.add(filteredList[index].sId!);
                          }
                          fav.write(username, userFav);
                          filteredList = products.where((product) => userFav.contains(product.sId)).toList();
                          print('Updated User Favorites: $userFav');
                          print('Updated Filtered List Length: ${filteredList.length}');
                        });
                      },
                      icon: Icon(iconFavStyle[state]),
                      iconSize: 24.0,
                    ),
                  ),
                ),
              );
            },
            itemCount: filteredList.length,
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                height: 8.0,
              );
            },
          ),
        ),
      ),
    );
  }

  void loadProducts() {
    ApiDataSource.instance.getProducts('').then((data) {
      setState(() {
        products = data.map<Products>((json) => Products.fromJson(json)).toList();
        print('Total products loaded: ${products.length}');
        filteredList = products.where((product) => userFav.contains(product.sId)).toList();
        print('Filtered list length after loading products: ${filteredList.length}');
      });
    }).catchError((error) {
      setState(() {
        products = [];
        filteredList = [];
      });
      print('Error loading products: $error');
    });
  }
}

import 'package:tatpmmobil/models/base_network.dart';
import 'package:tatpmmobil/models/curr_api.dart';

class ApiDataSource{
  static ApiDataSource instance = ApiDataSource();

  Future<List<dynamic>> getMostPopular(){
    print(BaseNetwork.get("mostpopular"));
    return BaseNetwork.get("mostpopular");
  }


  Future<List<dynamic>> getProducts(String sId){
    return BaseNetwork.get("getproducts?keywords=shoes&limit=20");
  }

  // Future<List<dynamic>> getSpecific(String sId){
  //   return BaseNetwork.get("getproducts?keywords=shoes&limit=20");
  // }

  Future<Map<String, dynamic>> getCurrency(){
    return CurrApi.get("USD");
  }
}
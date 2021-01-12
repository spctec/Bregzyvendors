import 'dart:convert';
import 'dart:typed_data';
import 'package:bregzy_vendor/models/OrdersSummery.dart';
import 'package:bregzy_vendor/models/main_categories.dart';
import 'package:bregzy_vendor/models/orders.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool status;
List<categories> maincategories;
List<Orders> ordersdata;
OrdersSummery ordersSummery;

// ignore: non_constant_identifier_names
login({String email, String password}) async {
  String myUrl = "https://www.bregzy.com/wp-json/jwt-auth/v1/token";
  final response = await http.post(myUrl, headers: {
    "Accept": "application/json"
  }, body: {
    "username": "$email",
    "password": "$password",
  });

  var data = json.decode(response.body);

  if (response.statusCode != 200) {
    status = false;
  } else {
    status = true;
    print("token : ${data["token"]}");
    _save(data['token']);
    SaveId(id: data['id']);
  }
}

getProducts() async {
  final prefs = await SharedPreferences.getInstance();
  final key = 'token';
  final value = prefs.get(key) ?? null;

  String myUrl =
      "https://bregzy.com/wp-json/dokan/v1/products?parent=0&pages=100&per_page=100";
  http.Response response = await http.get(myUrl, headers: {
    'Accept': 'application/json',
    'Authorization': 'Bearer $value'
  });
  return json.decode(response.body);
}

void deleteProducts(int id) async {
  final prefs = await SharedPreferences.getInstance();
  final key = 'token';
  final value = prefs.get(key) ?? null;

  String myUrl = "https://bregzy.com/wp-json/dokan/v1/products/$id";
  http.delete(myUrl, headers: {
    'Accept': 'application/json',
    'Authorization': 'Bearer $value'
  }).then((response) {
    print('Response status : ${response.statusCode}');
    print('Response body : ${response.body}');
  });
}

SaveId({int id}) async {
  final prefs = await SharedPreferences.getInstance();
  final key = 'id';
  final value = id;
  prefs.setInt(key, value);
}

readId() async {
  final prefs = await SharedPreferences.getInstance();
  final key = 'id';
  final value = prefs.get(key) ?? 1;
  print('read : $value');
}

// ignore: unused_element
_save(String token) async {
  final prefs = await SharedPreferences.getInstance();
  final key = 'token';
  final value = token;
  prefs.setString(key, value);
}

read() async {
  final prefs = await SharedPreferences.getInstance();
  final key = 'token';
  final value = prefs.get(key) ?? 0;
  print('read : $value');
}

getVendorData() async {
  final prefs = await SharedPreferences.getInstance();
  final key = 'token';
  final value = prefs.get(key) ?? 0;
  final key2 = 'id';
  final id = prefs.get(key2) ?? null;

  // ignore: unnecessary_brace_in_string_interps
  String myUrl = "https://bregzy.com/wp-json/dokan/v1/stores/${id}";
  http.Response response = await http.get(myUrl, headers: {
    'Accept': 'application/json',
    'Authorization': 'Bearer $value'
  });
  var data = json.decode(response.body);
  print(data['store_name']);
  return data;
}

DeleteProducts(int productID) async {
  final prefs = await SharedPreferences.getInstance();
  final key = 'token';
  final value = prefs.get(key) ?? null;

  final response = await http.delete(
      'https://bregzy.com/wp-json/dokan/v1/products/$productID',
      headers: {"Authorization": "Bearer $value"});

  if (response.statusCode == 200) {
    print("Product Delete successfully");
  } else {
    print("Product Delete Failed");
    print(response.statusCode);
  }
}

/*Future<Map<String, dynamic>> Addnewproducts(
    {String productName,
    String categoryId,
    String productDesc,
    String productShortDesc,
    String productPrice,
    String productPricediscount,
    int stockQuantity,
    List<Asset> images}) async {
  final prefs = await SharedPreferences.getInstance();
  final key = 'token';
  final value = prefs.get(key) ?? null;

  List<MultipartFile> multipartImageList = new List<MultipartFile>();
  if (null != images) {
    for (Asset asset in images) {
      ByteData byteData = await asset.getByteData();
      List<int> imageData = byteData.buffer.asUint8List();
      MultipartFile multipartFile = new MultipartFile.fromBytes(
        imageData,
        filename: 'load_image',
        contentType: MediaType("image", "jpg"),
      );
      multipartImageList.add(multipartFile);
      print('$multipartFile');
    }

    FormData formData = FormData.fromMap({
      "name": '$productName',
      "description": '$productDesc',
      "short_description": '$productShortDesc',
      "regular_price": '$productPrice',
      "sale_price": "$productPricediscount",
      "stock_quantity": stockQuantity
    });

    Dio dio = new Dio();
    var response = await dio.post(
        "https://bregzy.com/wp-json/dokan/v1/products?categories[0][id]=$categoryId &images[0][src]=${multipartImageList.first} & images[0][position]=0",
        data: formData,
        options: Options(headers: {"Authorization": "Bearer $value"}));
    if (response.statusCode == 200) {
      print("created");
    } else {
      print("Not created");
    }
  }
}
*/
Future<Map<String, dynamic>> addNewProduct(
    {String productName,
      String categoryId,
      String productDesc,
      String productShortDesc,
      String productPrice,
      String productPricediscount,
      int stockQuantity,
      List images,
    }) async {
  final prefs = await SharedPreferences.getInstance();
  final key = 'token';
  final value = prefs.get(key) ?? null;
  Map<String,String> mm={
    "name": '$productName',
    "description": '$productDesc',
    "short_description": '$productShortDesc',
    "regular_price": '$productPrice',
    "sale_price": "$productPricediscount",
    "stock_quantity": stockQuantity.toString(),
  };
  int i=0;
  for(var x in images){
    if(x==null){
    }else{
      mm["images["+i.toString()+"][src]"]=x;
      i++;
    }
  }
  print(mm);
  FormData formData = FormData.fromMap(mm);
  var response = await Dio().post(
      "https://bregzy.com/wp-json/dokan/v1/products?categories[0][id]=$categoryId",
      data: formData,
     options: Options(
         headers: {"Authorization": "Bearer $value"}
     ));
  if (response.statusCode == 200) {
    status = true;
    print("created");
  } else {
    status = false;
    print("Not created");
  }
}
Future<List<categories>> getMaincategories() async {
  final prefs = await SharedPreferences.getInstance();
  final key = 'token';
  final value = prefs.get(key) ?? null;

  final response = await http.get(
      'https://bregzy.com/wp-json/wc/v3/products/categories?per_page=100',
      headers: {"Authorization": "Bearer ${value}"});

  if (response.statusCode == 200) {
    var data = json.decode(response.body) as List;
    maincategories =
        data.map<categories>((json) => categories.fromJson(json)).toList();
  }
  return maincategories;
}

Future<Map<String, dynamic>> Updateproducts({
  int productID,
  String productName,
  String categoryId,
  String productDesc,
  String productShortDesc,
  String productPrice,
  String productPricediscount,
  int stockQuantity,
}) async {
  print("$productName -- $productPrice -- $productDesc");
  final prefs = await SharedPreferences.getInstance();
  final key = 'token';
  final value = prefs.get(key) ?? null;

  FormData formData = FormData.fromMap({
    "name": '$productName',
    "regular_price": '$productPrice',
    "sale_price": '$productPricediscount',
    "description": '$productDesc',
    "short_description": '$productShortDesc',
    "stock_quantity": stockQuantity,
    "manage_stock": true
  });
  Dio dio = new Dio();
  var response = await dio.post(
      "https://bregzy.com/wp-json/dokan/v1/products/$productID",
      data: formData,
      options: Options(headers: {"Authorization": "Bearer $value"}));
  if (response.statusCode == 200) {
    status = true;
    print("updated");
  } else {
    status = false;
    print("Not updated");
  }
}

getCoupons() async {
  final prefs = await SharedPreferences.getInstance();
  final key = 'token';
  final value = prefs.get(key) ?? null;

  String myUrl = "https://bregzy.com/wp-json/dokan/v1/coupons/";
  http.Response response = await http.get(myUrl, headers: {
    'Accept': 'application/json',
    'Authorization': 'Bearer $value'
  });
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    return json.decode(response.body);
  }
}

Future<Map<String, dynamic>> addCoupons({
  String code,
  String amount,
  int usageLimit,
  List productsIds,
}) async {
  final prefs = await SharedPreferences.getInstance();
  final key = 'token';
  final value = prefs.get(key) ?? null;

  FormData formData = FormData.fromMap({
    "code": '$code',
    "amount": '$amount',
    "discount_type": "percent",
    "usage_count": 0,
    "usage_limit": usageLimit,
    "product_ids": productsIds,
  });
  Dio dio = new Dio();
  var response = await dio.post("https://bregzy.com/wp-json/dokan/v1/coupons/",
      data: formData,
      options: Options(headers: {"Authorization": "Bearer $value"}));
  if (response.statusCode == 200) {
    status = true;
    print("created");
  } else {
    status = false;
    print("Not created");
  }
}

Future<Map<String, dynamic>> updateCoupons({
  int couponId,
  String code,
  String amount,
  int usageLimit,
  List productsIds,
}) async {
  final prefs = await SharedPreferences.getInstance();
  final key = 'token';
  final value = prefs.get(key) ?? null;

  FormData formData = FormData.fromMap({
    "code": '$code',
    "amount": '$amount',
    "discount_type": "percent",
    "usage_count": 0,
    "usage_limit": usageLimit,
    "product_ids": productsIds,
  });
  Dio dio = new Dio();
  var response = await dio.put(
      "https://bregzy.com/wp-json/dokan/v1/coupons/$couponId",
      data: formData,
      options: Options(headers: {"Authorization": "Bearer $value"}));
  if (response.statusCode == 200) {
    status = true;
    print("created");
  } else {
    status = false;
    print("Not created");
  }
}

Future DeleteCoupon(int couponId) async {
  final prefs = await SharedPreferences.getInstance();
  final key = 'token';
  final value = prefs.get(key) ?? null;

  final response = await http.delete(
      'https://bregzy.com/wp-json/dokan/v1/coupons/$couponId',
      headers: {"Authorization": "Bearer $value"});

  if (response.statusCode == 200) {
    print("Product Delete successfully");
  } else {
    print("Product Delete Failed");
  }
}

Future<List<Orders>> getorders() async {
  final prefs = await SharedPreferences.getInstance();
  final key = 'token';
  final value = prefs.get(key) ?? null;

  final response = await http.get('https://bregzy.com/wp-json/dokan/v1/orders/',
      headers: {"Authorization": "Bearer $value"});

  if (response.statusCode == 200) {
    var data = json.decode(response.body) as List;
    ordersdata = data.map<Orders>((json) => Orders.fromJson(json)).toList();
  }
  print(ordersdata[0].number);

  return ordersdata;
}

getOrdersSummery() async {
  final prefs = await SharedPreferences.getInstance();
  final key = 'token';
  final value = prefs.get(key) ?? null;

  final response = await http.get(
      'https://bregzy.com/wp-json/dokan/v1/orders/summary',
      headers: {"Authorization": "Bearer $value"});

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    return data;
  } else {
    return response.statusCode;
  }
}

getReviews() async {
  final prefs = await SharedPreferences.getInstance();
  final key = 'token';
  final value = prefs.get(key) ?? null;

  String myUrl = "https://bregzy.com/wp-json/dokan/v1/reviews/";
  http.Response response = await http.get(myUrl, headers: {
    'Accept': 'application/json',
    'Authorization': 'Bearer $value'
  });
  return json.decode(response.body);
}

getReviewsSummary() async {
  final prefs = await SharedPreferences.getInstance();
  final key = 'token';
  final value = prefs.get(key) ?? null;

  String myUrl = "https://bregzy.com/wp-json/dokan/v1/reviews/summary";
  http.Response response = await http.get(myUrl, headers: {
    'Accept': 'application/json',
    'Authorization': 'Bearer $value'
  });
  return json.decode(response.body);
}

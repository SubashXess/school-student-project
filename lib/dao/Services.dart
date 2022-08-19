// import 'dart:convert';
// import 'package:finserve/constants/ApiConstant.dart';
// import 'package:finserve/model/CartItems.dart';
// import 'package:finserve/model/ProductModel.dart';
// import 'package:finserve/model/ShoppingProductModel.dart';
// import 'package:finserve/model/SubCategoryModel.dart';
// import 'package:finserve/model/categoryModel.dart';
// import 'package:finserve/model/items.dart';
// import 'package:finserve/model/plan.dart';
// import 'package:finserve/model/refer_earn.dart';
// import 'package:http/http.dart' as http;
//
// import 'DatabaseHelper22.dart';
// class Services {
//   final dbHelper = DatabaseHelper.instance;
//   String pref_type;
//   static int catageryLength;
//   static Future<List<categoryModel>> getCategory() async {
//     try {
//         // final response =await http.get(Uri.parse(ApiConstant.api1+"getCategory.php"));
//       final response =await http.get(Uri.parse(ApiConstant.api1+"getCategory.php"));
//         if (response.statusCode == 200) {
//           List<categoryModel> list = parseCategory(response.body);
//           catageryLength=list.length;
//           print('CatageryLength '+catageryLength.toString());
//           return list.sublist(0,6);
//           //return list;
//         } else {
//           throw Exception("Error");
//         }
//     }
//     catch (e) {
//       throw Exception(e.toString());
//     }
//   }
//
//   // Parse the JSON response and return list of Album Objects //
//   static List<categoryModel> parseCategory(String responseBody) {
//     final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
//     return parsed.map<categoryModel>((json) => categoryModel.fromJson(json)).toList();
//   }
//   static Future<List<categoryModel>> getRechargeCategory() async {
//     try {
//       final response =await http.get(Uri.parse(ApiConstant.api1+"getRechargeCategory.php"));
//       if (response.statusCode == 200) {
//         List<categoryModel> list = parseRechargeCategory(response.body);
//         catageryLength=list.length;
//         print('CatageryLength '+catageryLength.toString());
//         return list;
//         //return list;
//       } else {
//         throw Exception("Error");
//       }
//     }
//     catch (e) {
//       throw Exception(e.toString());
//     }
//   }
//
//   // Parse the JSON response and return list of Album Objects //
//   static List<categoryModel> parseRechargeCategory(String responseBody) {
//     final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
//     return parsed.map<categoryModel>((json) => categoryModel.fromJson(json)).toList();
//   }
//
//   static Future<List<SubCategoryModel>> getShopping() async {
//     try {
//       final response =await http.get(Uri.parse(ApiConstant.api1+"getShopping.php"));
//       if (response.statusCode == 200) {
//         List<SubCategoryModel> list = parseShopping(response.body);
//         catageryLength=list.length;
//         print('CatageryLength '+catageryLength.toString());
//         return list;
//         //return list;
//       } else {
//         throw Exception("Error");
//       }
//     }
//     catch (e) {
//       throw Exception(e.toString());
//     }
//   }
//
//   // Parse the JSON response and return list of Album Objects //
//   static List<SubCategoryModel> parseShopping(String responseBody) {
//     final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
//     return parsed.map<SubCategoryModel>((json) => SubCategoryModel.fromJson(json)).toList();
//   }
//   // static Future<List<Place>> getSearchCategory() async {
//   //   try {
//   //       final response =await http.get(Uri.parse("https://boowkly.com/bw_admin/Service/api/getCategory.php"));
//   //       if (response.statusCode == 200) {
//   //         List<Place> list = parseSearchCategory(response.body);
//   //         return list.sublist(0,6);
//   //         //return list;
//   //       } else {
//   //         throw Exception("Error");
//   //       }
//   //   }
//   //   catch (e) {
//   //     throw Exception(e.toString());
//   //   }
//   // }
//
//   // Parse the JSON response and return list of Album Objects //
//   // static List<Place> parseSearchCategory(String responseBody) {
//   //   final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
//   //   return parsed.map<Place>((json) => Place.fromJson(json)).toList();
//   // }
//   static Future<List<Splan>> getPlan() async {
//     try {
//       final response =await http.get(Uri.parse(ApiConstant.api1+'getPlan.php'));
//       //final response =await http.get(Uri.parse('http://intentitsolutions.com/P365TECH/api/getProfit.php?user_id=28'));
//       if (response.statusCode == 200) {
//         List<Splan> list = parsePlan(response.body);
//         return list;
//       } else {
//         throw Exception("Error");
//       }
//     }
//     catch (e) {
//       throw Exception(e.toString());
//     }
//   }
//
//   // Parse the JSON response and return list of Album Objects //
//   static List<Splan> parsePlan(String responseBody) {
//     final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
//     return parsed.map<Splan>((json) => Splan.fromJson(json)).toList();
//   }
//   static Future<List<refer_earn>> getRefer(String ref_code) async {
//     try {
//       final response =await http.get(Uri.parse(ApiConstant.api1+'getProfit.php?ref_code='+ref_code));
//       //final response =await http.get(Uri.parse('http://intentitsolutions.com/P365TECH/api/getProfit.php?user_id=28'));
//       if (response.statusCode == 200) {
//         List<refer_earn> list = parseRefer(response.body);
//         return list;
//       } else {
//         throw Exception("Error");
//       }
//     }
//     catch (e) {
//       throw Exception(e.toString());
//     }
//   }
//
//   // Parse the JSON response and return list of Album Objects //
//   static List<refer_earn> parseRefer(String responseBody) {
//     final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
//     return parsed.map<refer_earn>((json) => refer_earn.fromJson(json)).toList();
//   }
//   static Future<List<SubCategoryModel>> getSubcategories(String id) async {
//     //print('UID :'+user_id);
//     try {
//         final response =await http.get(Uri.parse(ApiConstant.api1+"getAllSubcategory.php?id="+id));
//         if (response.statusCode == 200) {
//           List<SubCategoryModel> list = parseBookingList(response.body);
//           return list;
//           //return list;
//         } else {
//           throw Exception("Error");
//         }
//     }
//     catch (e) {
//       throw Exception(e.toString());
//     }
//   }
//
//   // Parse the JSON response and return list of Album Objects //
//   static List<SubCategoryModel> parseBookingList(String responseBody) {
//     final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
//     return parsed.map<SubCategoryModel>((json) => SubCategoryModel.fromJson(json)).toList();
//   }
//
//
//   static Future<List<categoryModel>> getAllCategory() async {
//     try {
//         final response =await http.get(Uri.parse(ApiConstant.api1+"getCategory.php"));
//         if (response.statusCode == 200) {
//           List<categoryModel> list = parseCategory(response.body);
//           return list;
//         } else {
//           throw Exception("Error");
//         }
//     }
//     catch (e) {
//       throw Exception(e.toString());
//     }
//   }
//
//   // Parse the JSON response and return list of Album Objects //
//   static List<categoryModel> parseAllCategory(String responseBody) {
//     final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
//     return parsed.map<categoryModel>((json) => categoryModel.fromJson(json)).toList();
//   }
//
//
//   static Future<List<SubCategoryModel>> getSubCategory(String category_id) async {
//     try {
//       print("CAT_ID : "+category_id);
//       final response = await http.get(
//           Uri.parse("https://boowkly.com/bw_admin/Service/api/getSubcategory.php?category_id="+category_id));
//       if (response.statusCode == 200) {
//         List<SubCategoryModel> list = parseSubCategory(response.body);
//         return list;
//       } else {
//         throw Exception("Error");
//       }
//       //final response =await http.get("http://intentitsolutions.com/HomeServices/api/getCategory.php");
//       //final response =await http.get("http://192.168.43.21:8080/HomeServices/api/getSubcategory.php");
//       //final response =await http.get("http://192.168.43.21:8080/HomeServices/api/getSubcategory.php?category="+category);
//       // if (PreferenceUtils.getString("TYPE") == 'Service') {
//       //   final response = await http.get(
//       //       "https://boowkly.com/bw_admin/Service/api/getSubcategory.php?category_id="+category_id);
//       //   if (response.statusCode == 200) {
//       //     List<SubCategoryModel> list = parseSubCategory(response.body);
//       //     return list;
//       //   } else {
//       //     throw Exception("Error");
//       //   }
//       // }
//       // if (PreferenceUtils.getString("TYPE") == 'Rent') {
//       //   final response = await http.get(
//       //       "https://boowkly.com/bw_admin/Rent/api/getSubcategory.php?category_id="+category_id);
//       //   if (response.statusCode == 200) {
//       //     List<SubCategoryModel> list = parseSubCategory(response.body);
//       //     return list;
//       //   } else {
//       //     throw Exception("Error");
//       //   }
//       // }
//       // if (PreferenceUtils.getString("TYPE") == 'Shop') {
//       //   final response = await http.get(
//       //       "https://boowkly.com/bw_admin/Shop/api/getSubcategory.php?category_id="+category_id);
//       //   if (response.statusCode == 200) {
//       //     List<SubCategoryModel> list = parseSubCategory(response.body);
//       //     return list;
//       //   } else {
//       //     throw Exception("Error");
//       //   }
//       // }
//     }
//       catch (e) {
//       throw Exception(e.toString());
//     }
//   }
//
//   // Parse the JSON response and return list of Album Objects //
//   static List<SubCategoryModel> parseSubCategory(String responseBody) {
//     final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
//     return parsed.map<SubCategoryModel>((json) => SubCategoryModel.fromJson(json)).toList();
//   }
//
//   static Future<List<ProductModel>> getProducts(String id) async {
//     //print('PID :'+id);
//     try {
//       final response =await http.get(Uri.parse(ApiConstant.api1+"getAllProducts.php?id="+id));
//       if (response.statusCode == 200) {
//         List<ProductModel> list = parseProductsList(response.body);
//         print('P_LIST :'+list.length.toString());
//         return list;
//         //return list;
//       } else {
//         throw Exception("Error");
//       }
//     }
//     catch (e) {
//       throw Exception(e.toString());
//     }
//   }
//
//   // Parse the JSON response and return list of Album Objects //
//   static List<ProductModel> parseProductsList(String responseBody) {
//     final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
//     return parsed.map<ProductModel>((json) => ProductModel.fromJson(json)).toList();
//   }
//
//   static Future<List<ShoppingProductModel>> getShoppingProducts(String id) async {
//     //print('PID :'+id);
//     try {
//       final response =await http.get(Uri.parse(ApiConstant.api1+"getShoppingProducts.php?id="+id));
//       if (response.statusCode == 200) {
//         List<ShoppingProductModel> list = parseShoppingProductsList(response.body);
//         print('P_LIST :'+list.length.toString());
//         return list;
//         //return list;
//       } else {
//         throw Exception("Error");
//       }
//     }
//     catch (e) {
//       throw Exception(e.toString());
//     }
//   }
//
//   // Parse the JSON response and return list of Album Objects //
//   static List<ShoppingProductModel> parseShoppingProductsList(String responseBody) {
//     final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
//     return parsed.map<ShoppingProductModel>((json) => ShoppingProductModel.fromJson(json)).toList();
//   }
//   static Future<List<CartItems>> getShoppingCart(String uid) async {
//     //print('PID :'+id);
//     try {
//       final response =await http.get(Uri.parse(ApiConstant.api1+"getCart.php?uid="+uid));
//       if (response.statusCode == 200) {
//         List<CartItems> list = parseShoppingCart(response.body);
//         print('P_LIST :'+list.length.toString());
//         return list;
//         //return list;
//       } else {
//         throw Exception("Error");
//       }
//     }
//     catch (e) {
//       throw Exception(e.toString());
//     }
//   }
//
//   // Parse the JSON response and return list of Album Objects //
//   static List<CartItems> parseShoppingCart(String responseBody) {
//     final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
//     return parsed.map<CartItems>((json) => CartItems.fromJson(json)).toList();
//   }
//   static Future<List<SubCategoryModel>> getMyBooking(String category_id) async {
//     try {
//       print("CAT_ID : "+category_id);
//       final response = await http.get(
//           Uri.parse("https://boowkly.com/bw_admin/Service/api/getSubcategory.php?category_id="+category_id));
//       if (response.statusCode == 200) {
//         List<SubCategoryModel> list = parseSubCategory(response.body);
//         return list;
//       } else {
//         throw Exception("Error");
//       }
//     }
//     catch (e) {
//       throw Exception(e.toString());
//     }
//   }
//
//   // Parse the JSON response and return list of Album Objects //
//   static List<SubCategoryModel> parseMyBooking(String responseBody) {
//     final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
//     return parsed.map<SubCategoryModel>((json) => SubCategoryModel.fromJson(json)).toList();
//   }
//
//
//   // static Future<List<SubCategoryModel>> getAllSubCategories() async {
//   //   try {
//   //     if (PreferenceUtils.getString("TYPE") == 'Service') {
//   //       final response = await http.get(
//   //           Uri.parse("https://boowkly.com/bw_admin/Service/api/getAllSubcategories.php"));
//   //     if (response.statusCode == 200) {
//   //       List<SubCategoryModel> list = parseAllSubCategories(response.body);
//   //       return list;
//   //     } else {
//   //       throw Exception("Error");
//   //     }
//   //     }
//   //     if (PreferenceUtils.getString("TYPE") == 'Rent') {
//   //       final response = await http.get(
//   //           Uri.parse("https://boowkly.com/bw_admin/Rent/api/getAllSubcategories.php"));
//   //       if (response.statusCode == 200) {
//   //         List<SubCategoryModel> list = parseSubCategory(response.body);
//   //         return list;
//   //       } else {
//   //         throw Exception("Error");
//   //       }
//   //     }
//   //     if (PreferenceUtils.getString("TYPE") == 'Shop') {
//   //       final response = await http.get(
//   //           Uri.parse("https://boowkly.com/bw_admin/Shop/api/getAllSubcategories.php"));
//   //       if (response.statusCode == 200) {
//   //         List<SubCategoryModel> list = parseSubCategory(response.body);
//   //         return list;
//   //       } else {
//   //         throw Exception("Error");
//   //       }
//   //     }
//   //   } catch (e) {
//   //     throw Exception(e.toString());
//   //   }
//   // }
//   //
//   // // Parse the JSON response and return list of Album Objects //
//   // static List<SubCategoryModel> parseAllSubCategories(String responseBody) {
//   //   final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
//   //   return parsed.map<SubCategoryModel>((json) => SubCategoryModel.fromJson(json)).toList();
//   // }
//
//   static Future<List<SubCategoryModel>> getSplitSubCategories(String type) async {
//     try {
//       if (type == 'Service') {
//         final response = await http.get(
//             Uri.parse("https://boowkly.com/bw_admin/Service/api/getSplitSubcategories.php"));
//         if (response.statusCode == 200) {
//           List<SubCategoryModel> list = parseSplitSubCategories(response.body);
//           return list;
//         } else {
//           throw Exception("Error");
//         }
//       }
//       if (type == 'Rent') {
//         final response = await http.get(
//             Uri.parse("https://boowkly.com/bw_admin/Rent/api/getSplitSubcategories.php"));
//         if (response.statusCode == 200) {
//           List<SubCategoryModel> list = parseSplitSubCategories(response.body);
//           return list;
//         } else {
//           throw Exception("Error");
//         }
//       }
//       if (type == 'Shop') {
//         final response = await http.get(
//             Uri.parse("https://boowkly.com/bw_admin/Shop/api/getSplitSubcategories.php"));
//         if (response.statusCode == 200) {
//           List<SubCategoryModel> list = parseSplitSubCategories(response.body);
//           return list;
//         } else {
//           throw Exception("Error");
//         }
//       }
//     } catch (e) {
//       throw Exception(e.toString());
//     }
//   }
//
//   // Parse the JSON response and return list of Album Objects //
//   static List<SubCategoryModel> parseSplitSubCategories(String responseBody) {
//     final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
//     return parsed.map<SubCategoryModel>((json) => SubCategoryModel.fromJson(json)).toList();
//   }
//
//   // static Future<List<items>> getItems(String subcategory) async {
//   //   try {
//   //     if (PreferenceUtils.getString("TYPE") == 'Service') {
//   //       final response = await http.get(
//   //           Uri.parse("https://boowkly.com/bw_admin/Service/api/getItems.php?subcategory=" +
//   //               subcategory));
//   //       if (response.statusCode == 200) {
//   //         List<items> list = parseItems(response.body);
//   //         return list;
//   //       } else {
//   //         throw Exception("Error");
//   //       }
//   //     }
//   //     if (PreferenceUtils.getString("TYPE") == 'Rent') {
//   //       final response = await http.get(
//   //           Uri.parse("https://boowkly.com/bw_admin/Rent/api/getItems.php?subcategory=" +
//   //               subcategory));
//   //       if (response.statusCode == 200) {
//   //         List<items> list = parseItems(response.body);
//   //         return list;
//   //       } else {
//   //         throw Exception("Error");
//   //       }
//   //     }
//   //     if (PreferenceUtils.getString("TYPE") == 'Shop') {
//   //       final response = await http.get(
//   //           Uri.parse("https://boowkly.com/bw_admin/Shop/api/getItems.php?subcategory=" +
//   //               subcategory));
//   //       if (response.statusCode == 200) {
//   //         List<items> list = parseItems(response.body);
//   //         return list;
//   //       } else {
//   //         throw Exception("Error");
//   //       }
//   //     }
//   //   } catch (e) {
//   //     throw Exception(e.toString());
//   //   }
//   // }
//   //
//   // // Parse the JSON response and return list of Album Objects //
//   // static List<items> parseItems(String responseBody) {
//   //   final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
//   //   return parsed.map<items>((json) => items.fromJson(json)).toList();
//   // }
//
//   // static Future<List<items>> getItemList(String subcategory,String issueType) async {
//   //   try {
//   //     if (PreferenceUtils.getString("TYPE") == 'Service') {
//   //       final response = await http.get(
//   //           Uri.parse("https://boowkly.com/bw_admin/Service/api/getItemList.php?subcategory=" +
//   //               subcategory + "&issue_type=" + issueType));
//   //       if (response.statusCode == 200) {
//   //         print(issueType);
//   //         List<items> list = parseItemList(response.body);
//   //         return list;
//   //       } else {
//   //         throw Exception("Error");
//   //       }
//   //     }
//   //     if (PreferenceUtils.getString("TYPE") == 'Rent') {
//   //       final response = await http.get(
//   //           Uri.parse("https://boowkly.com/bw_admin/Rent/api/getItemList.php?subcategory=" +
//   //               subcategory + "&issue_type=" + issueType));
//   //       if (response.statusCode == 200) {
//   //         List<items> list = parseItemList(response.body);
//   //         return list;
//   //       } else {
//   //         throw Exception("Error");
//   //       }
//   //     }
//   //     if (PreferenceUtils.getString("TYPE") == 'Shop') {
//   //       final response = await http.get(
//   //           Uri.parse("https://boowkly.com/bw_admin/Shop/api/getItemList.php?subcategory=" +
//   //               subcategory + "&issue_type=" + issueType));
//   //       if (response.statusCode == 200) {
//   //         List<items> list = parseItemList(response.body);
//   //         return list;
//   //       } else {
//   //         throw Exception("Error");
//   //       }
//   //     }
//   //   } catch (e) {
//   //     throw Exception(e.toString());
//   //   }
//   // }
//   //
//   // // Parse the JSON response and return list of Album Objects //
//   // static List<items> parseItemList(String responseBody) {
//   //   final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
//   //   return parsed.map<items>((json) => items.fromJson(json)).toList();
//   // }
//   //
//   // static Future<List<UserDataModel>> user_login() async {
//   //   try {
//   //     final response =await http.get(Uri.parse("https://boowkly.com/HomeServices/api/login_user.php"));
//   //     if (response.statusCode == 200) {
//   //       List<UserDataModel> list = parseUserModel(response.body);
//   //       return list;
//   //     } else {
//   //       throw Exception("Error");
//   //     }
//   //   } catch (e) {
//   //     throw Exception(e.toString());
//   //   }
//   // }
//   //
//   // // Parse the JSON response and return list of Album Objects //
//   // static List<UserDataModel> parseUserModel(String responseBody) {
//   //   final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
//   //   return parsed.map<UserDataModel>((json) => categoryModel.fromJson(json)).toList();
//   // }
//
//   // static Future<List<items>> getOrderServices(String order_id) async {
//   //   try {
//   //     if (PreferenceUtils.getString("TYPE") == 'Service') {
//   //       final response = await http.get(
//   //           Uri.parse("https://boowkly.com/bw_admin/Service/api/getOrderServices.php?user_id=" +
//   //               order_id));
//   //       if (response.statusCode == 200) {
//   //         List<items> list = parseOrderServices(response.body);
//   //         return list;
//   //       } else {
//   //         throw Exception("Error");
//   //       }
//   //     }
//   //     if (PreferenceUtils.getString("TYPE") == 'Rent') {
//   //       final response = await http.get(
//   //           Uri.parse("https://boowkly.com/bw_admin/Rent/api/getOrderServices.php?user_id=" +
//   //               order_id));
//   //       if (response.statusCode == 200) {
//   //         List<items> list = parseOrderServices(response.body);
//   //         return list;
//   //       } else {
//   //         throw Exception("Error");
//   //       }
//   //     }
//   //     if (PreferenceUtils.getString("TYPE") == 'Shop') {
//   //       final response = await http.get(
//   //           Uri.parse("https://boowkly.com/bw_admin/Shop/api/getOrderServices.php?user_id=" +
//   //               order_id));
//   //       if (response.statusCode == 200) {
//   //         List<items> list = parseOrderServices(response.body);
//   //         return list;
//   //       } else {
//   //         throw Exception("Error");
//   //       }
//   //     }
//   //   } catch (e) {
//   //     throw Exception(e.toString());
//   //   }
//   // }
//   //
//   // // Parse the JSON response and return list of Album Objects //
//   // static List<items> parseOrderServices(String responseBody) {
//   //   final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
//   //   return parsed.map<items>((json) => items.fromJson(json)).toList();
//   // }
//
//   // static Future<List<items>> getCartAmount(String user_id) async {
//   //   try {
//   //     if (PreferenceUtils.getString("TYPE") == 'Service') {
//   //       final response = await http.get(
//   //           Uri.parse("https://boowkly.com/bw_admin/Service/api/getCartAmount.php?user_id="+user_id));
//   //       if (response.statusCode == 200) {
//   //         List<items> list = parseOrderServices(response.body);
//   //         return list;
//   //       } else {
//   //         throw Exception("Error");
//   //       }
//   //     }
//   //     if (PreferenceUtils.getString("TYPE") == 'Rent') {
//   //       final response = await http.get(
//   //           Uri.parse("https://boowkly.com/bw_admin/Rent/api/getCartAmount.php?user_id="+user_id));
//   //       if (response.statusCode == 200) {
//   //         List<items> list = parseOrderServices(response.body);
//   //         return list;
//   //       } else {
//   //         throw Exception("Error");
//   //       }
//   //     }
//   //     if (PreferenceUtils.getString("TYPE") == 'Shop') {
//   //       final response = await http.get(
//   //           Uri.parse("https://boowkly.com/bw_admin/Shop/api/getCartAmount.php?user_id="+user_id));
//   //       if (response.statusCode == 200) {
//   //         List<items> list = parseOrderServices(response.body);
//   //         return list;
//   //       } else {
//   //         throw Exception("Error");
//   //       }
//   //     }
//   //   }
//   //   catch (e) {
//   //     throw Exception(e.toString());
//   //   }
//   // }
//   //
//   // // Parse the JSON response and return list of Album Objects //
//   // static List<items> parseCartAmount(String responseBody) {
//   //   final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
//   //   return parsed.map<items>((json) => items.fromJson(json)).toList();
//   // }
//
//   // static Future<List<CartItems>> getCartItems(String user_id) async {
//   //   try {
//   //     if (PreferenceUtils.getString("TYPE") == 'Service') {
//   //       final response = await http.get(
//   //           "https://boowkly.com/bw_admin/Service/api/getCartItems.php?user_id=" +
//   //               user_id);
//   //       if (response.statusCode == 200) {
//   //         List<CartItems> list = parseCartItems(response.body);
//   //         return list;
//   //       } else {
//   //         throw Exception("Error");
//   //       }
//   //     }
//   //     if (PreferenceUtils.getString("TYPE") == 'Rent') {
//   //       final response = await http.get(
//   //           "https://boowkly.com/bw_admin/Rent/api/getCartItems.php?user_id=" +
//   //               user_id);
//   //       if (response.statusCode == 200) {
//   //         List<CartItems> list = parseCartItems(response.body);
//   //         return list;
//   //       } else {
//   //         throw Exception("Error");
//   //       }
//   //     }
//   //     if (PreferenceUtils.getString("TYPE") == 'Shop') {
//   //       final response = await http.get(
//   //           "https://boowkly.com/bw_admin/Shop/api/getCartItems.php?user_id=" +
//   //               user_id);
//   //       if (response.statusCode == 200) {
//   //         List<CartItems> list = parseCartItems(response.body);
//   //         return list;
//   //       } else {
//   //         throw Exception("Error");
//   //       }
//   //     }
//   //   } catch (e) {
//   //     throw Exception(e.toString());
//   //   }
//   // }
//
//   // Parse the JSON response and return list of Album Objects //
//   // static List<CartItems> parseCartItems(String responseBody) {
//   //   final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
//   //   return parsed.map<CartItems>((json) => CartItems.fromJson(json)).toList();
//   // }
//
//   // static Future<List<Address>> getSavedAddress() async {
//   //   try {
//   //     final response =await http.get(Uri.parse("https://boowkly.com/bw_admin/Service/api/getAddress.php"));
//   //     if (response.statusCode == 200) {
//   //       List<Address> list = parseSavedAddress(response.body);
//   //       return list;
//   //     } else {
//   //       throw Exception("Error");
//   //     }
//   //   }
//   //   catch (e) {
//   //     throw Exception(e.toString());
//   //   }
//   // }
//   //
//   // // Parse the JSON response and return list of Album Objects //
//   // static List<Address> parseSavedAddress(String responseBody) {
//   //   final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
//   //   return parsed.map<Address>((json) => Address.fromJson(json)).toList();
//   // }
//   //
//   // static Future<List<Address>> _getAddress() async {
//   //   List<Address> details = [];
//   //   var data = await http
//   //       .get(Uri.parse("https://boowkly.com/bw_admin/Service/api/getAddress.php"));
//   //
//   //   var jsonData = json.decode(data.body);
//   //   for (var p in jsonData) {
//   //     Address detail = Address(
//   //       address: p["address"],
//   //     );
//   //     details.add(detail);
//   //   }
//   //   return details;
//   // }
//   //  Future<List<CartItems>> getCart() async {
//   //   var dbClient = await dbHelper.database;
//   //   var res = await dbClient.query(DatabaseHelper11.cart_table);
//   //
//   //   List<CartItems> list =
//   //   res.isNotEmpty ? res.map((c) => CartItems.fromMap(c)).toList() : null;
//   //
//   //   return list;
//   // }
//   // static Future<List<ProfileData>> getProfile(String mobile) async {
//   //   List<ProfileData> pDataLists = [];
//   //   var data = await http
//   //       .get(Uri.parse("https://boowkly.com/bw_admin/api/login_user.php?mobile="+mobile));
//   //
//   //   var jsonData = json.decode(data.body);
//   //   for (var p in jsonData) {
//   //     ProfileData detail = ProfileData(
//   //       id: p["id"],
//   //         email: p['email'],
//   //         fname: p['fname'],
//   //         mobile: p['email'],
//   //         status: p['fname']);
//   //     pDataLists.add(detail);
//   //   }
//   //   return pDataLists;
//   // }
// }
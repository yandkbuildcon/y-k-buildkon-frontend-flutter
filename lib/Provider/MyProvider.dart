import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MyProvider extends ChangeNotifier {

  //-------------------------------------------------------------Theme Manager
  ThemeMode _currentThemeMode = ThemeMode.system;

  ThemeMode get currentThemeMode => _currentThemeMode;

  void toggleTheme() {
    _currentThemeMode = _currentThemeMode == ThemeMode.dark
        ? ThemeMode.light
        : ThemeMode.dark;

    notifyListeners();
  }

  //------------------------------------------------STATE MANAGER FOR NAVIGATION
  int _currentState = 1;
  int get currentState => _currentState;
  set currentState(int value) {
    _currentState = value;
    notifyListeners();
  }

  //--------------------------------------------------------------IMAGE VARIABLE
  File? _imageFile;
  File? get imageFile => _imageFile;
  set imageFile(File? value) {
    _imageFile = value;
    notifyListeners();
  }


  //-------------------------widget initializer for navigation------------------
  String _activeWidget = 'LoginWidget';
  String get activeWidget => _activeWidget;
  set activeWidget(String value) {
    _activeWidget = value;
    notifyListeners();
  }


  //----------------------SERVICE LIST VARIABLE---------------------------------
  List<dynamic> propertyList = [];
  List<String> imageUrl = [];
  List<dynamic> filteredPropertyList = [];
  List<dynamic> favoritePropertyList=[];
  Map<String,dynamic> selectedProperty={};

  List<dynamic> visitRequestedPropertyList=[];
  Map<String,dynamic> selectedVisitRequestedProperty={};
  Map<String,dynamic> requestedPropertyDetail={};
  var requestedPropertyId = "";

  //----------------------------------------------------------------------------USER RELATED DATA
  Map<String,dynamic> customerDetails={};
  bool addedToFavorite = false;

  //----------------------------------------------------------------------------ADMIN DATA CONTACT
  Map<String,dynamic> adminContact={};

  //----------------------------------------------------------------------------HANDLING USER TYPE
  String userType="";
  Future<void> fetchUserType() async{
    userType=await getUserType();
    //print('inside the fetchUserType $userType');
    notifyListeners();
  }

  void storeUserType(userType)async{
    const storage = FlutterSecureStorage();
    const Duration tokenDuration = Duration(days: 15);
    final DateTime now = DateTime.now();
    final DateTime expiration = now.add(tokenDuration);
    final String expirationString = expiration.toString();

    await storage.write(key: 'userType', value: userType);
    await storage.write(key: 'userTypeExpiration', value: expirationString);

    //print('inside the storeUserType $userType');
    notifyListeners();

  }

  Future<String> getUserType() async {
    const storage = FlutterSecureStorage();
    String? userType;
    userType = await storage.read(key: 'userType');
    return userType ?? "";

  }

  void deleteUserType() async {
    const storage = FlutterSecureStorage();
    await storage.delete(key: 'userType');
    await storage.delete(key: 'userTypeExpiration');
    this.userType = "";
    //print('inside the deleteUserType');
    notifyListeners();
  }



//------------------------------------------------------------------------------TOKEN MANAGER
  String token="";
  void fetchToken(String userType) async{
    token = await getToken(userType);
    //print('inside the fetchToken $token');
    notifyListeners();
  }

  void storeToken(String token, String userType) async {
    const storage =  FlutterSecureStorage();
    const Duration tokenDuration = Duration(days: 15);
    final DateTime now = DateTime.now();
    final DateTime expiration = now.add(tokenDuration);
    final String expirationString = expiration.toString();

    if (userType=='customer') {
      await storage.write(key: 'customerToken', value: token);
      await storage.write(key: 'customerTokenExpiration', value: expirationString);
      //print('guest token stored');
    } else {
      await storage.write(key: 'adminToken', value: token);
      await storage.write(key: 'adminTokenExpiration', value: expirationString);
      //print('owner token stored');
    }

    notifyListeners();
  }

  Future<String> getToken(String userType) async {
    const storage = FlutterSecureStorage();
    String? token;
    if (userType=='customer') {
      token = await storage.read(key: 'customerToken');
      //print('guest token called');
    } else if(userType=='admin'){
      token = await storage.read(key: 'adminToken');
      //print('owner token called');
    }
    return token ?? "";

  }

  void deleteToken(String userType) async {
    const storage = FlutterSecureStorage();
    if (userType=='customer') {
      await storage.delete(key: 'customerToken');
      await storage.delete(key: 'customerTokenExpiration');
      //print('guest token deleted');
    } else {
      await storage.delete(key: 'adminToken');
      await storage.delete(key: 'adminTokenExpiration');
      //print('owner token deleted');
    }

    this.token = "";
    notifyListeners();
  }

}
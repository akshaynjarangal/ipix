import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthenticationService{
  static const storage = FlutterSecureStorage();

   static Future<bool> login({required String username,required String password}) async {
    try {
      await Future.delayed(const Duration(seconds: 3),()async{
      await storage.write(key: 'username', value: username);
      await storage.write(key: 'password', value: password);
      });
      return true;
    } catch (e) {
      return false;
    }
  }
  static Future<bool> get logout async {
    try {
      await storage.delete(key: 'username');
      await storage.delete(key: 'password');
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> get checkAuth async {
    try {
      final username =  await storage.read(key: 'username');
      final password = await storage.read(key: 'password');
      if(username!=null&&password!=null){
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
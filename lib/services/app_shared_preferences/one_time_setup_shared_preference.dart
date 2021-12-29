import 'package:shared_preferences/shared_preferences.dart';

class OneTimeSetUp {
  firstsetup() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setInt("done", 1);
  }
  secondsetup()async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setInt("done", 2);
  }

  logout() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setInt("done", 0);
  }
}

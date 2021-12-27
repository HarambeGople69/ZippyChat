import 'package:shared_preferences/shared_preferences.dart';

class OnboardingPreference{
  done() async{
   
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setInt("done", 0);
  
  }
}
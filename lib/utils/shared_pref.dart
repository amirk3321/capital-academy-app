import 'package:shared_preferences/shared_preferences.dart';

const CHANNELID ='com.c4coding.CHANNELID';

class SharedPref{
  static Future<String> getChannelId()async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    return preferences.get(CHANNELID);
  }

  static Future<void> setChannelId(String channelId)async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    preferences.setString(CHANNELID,channelId);
  }
}
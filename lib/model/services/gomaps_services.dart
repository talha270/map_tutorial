import 'package:flutter_dotenv/flutter_dotenv.dart';
import'package:http/http.dart'as http;

getautocomplete({required place,required sessiontoken})async{
  String request="${dotenv.env["base_url"]}?input=$place&key=${dotenv.env["api_key"]}&sessiontoken=$sessiontoken";
  var response=await http.get(Uri.parse(request));
  if(response.statusCode==200){
      print(response.body.toString());
  }else{
    throw Exception("Faild to load the data");
  }
}
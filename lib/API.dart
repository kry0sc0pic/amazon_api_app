import 'package:http/http.dart' as http;

Future getData (query_url) async{
  http.Response response = await http.get(query_url);
  return response.body;
}
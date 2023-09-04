import 'package:covid19/packages.dart';
import 'package:http/http.dart' as http;

class Services {
  Future<WorldStatesModel> getStatesRecord() async {
    var response = await http.get(
      Uri.parse(AppUrls().worldStates),
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return WorldStatesModel.fromJson(data);
    } else {
      throw Exception('Error');
    }
  }

  Future<List<dynamic>> getCountriesRecord() async {
    var data;
    var response = await http.get(
      Uri.parse(AppUrls().countriesLis),
    );
    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Error');
    }
  }
}

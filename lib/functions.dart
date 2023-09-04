import 'package:covid19/packages.dart';

nextScreen(context, screenName) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => screenName),
  );
}

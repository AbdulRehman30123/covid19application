import 'package:covid19/packages.dart';

class DetailScreen extends StatefulWidget {
  String image, name;
  int totalCases,
      totalDeaths,
      totalRecovered,
      active,
      critical,
      todayRecovered,
      test;
  DetailScreen(
      {super.key,
      required this.name,
      required this.image,
      required this.totalCases,
      required this.totalDeaths,
      required this.totalRecovered,
      required this.active,
      required this.critical,
      required this.test,
      required this.todayRecovered});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(top: h * 0.15),
            child: Card(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(widget.image),
                  ),
                  ReuseAbleRow(
                    text: 'Cases',
                    value: widget.totalCases.toString(),
                  ),
                  ReuseAbleRow(
                    text: 'Recovered',
                    value: widget.totalRecovered.toString(),
                  ),
                  ReuseAbleRow(
                    text: 'Deaths',
                    value: widget.totalDeaths.toString(),
                  ),
                  ReuseAbleRow(
                    text: 'Active',
                    value: widget.active.toString(),
                  ),
                  ReuseAbleRow(
                    text: 'Critical',
                    value: widget.critical.toString(),
                  ),
                  ReuseAbleRow(
                    text: 'Today Recovered',
                    value: widget.todayRecovered.toString(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

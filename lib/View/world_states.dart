import 'package:covid19/packages.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStates extends StatefulWidget {
  const WorldStates({super.key});

  @override
  State<WorldStates> createState() => _WorldStatesState();
}

class _WorldStatesState extends State<WorldStates>
    with TickerProviderStateMixin {
  late final AnimationController _animationController =
      AnimationController(vsync: this);
  final colorList = <Color>[Colors.blue, Colors.green, Colors.redAccent];
  @override
  void dispose() {
    _animationController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Services services = Services();
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(height: h * 0.05),
              FutureBuilder(
                future: services.getStatesRecord(),
                builder: (context, AsyncSnapshot<WorldStatesModel> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: SpinKitFadingCircle(
                        color: Colors.white,
                      ),
                    );
                  } else {
                    return Column(
                      children: [
                        PieChart(
                          chartValuesOptions: ChartValuesOptions(
                              showChartValuesInPercentage: true),
                          colorList: colorList,
                          dataMap: {
                            'Total':
                                double.parse(snapshot.data!.cases.toString()),
                            'Recovered': double.parse(
                                snapshot.data!.recovered.toString()),
                            "deaths":
                                double.parse(snapshot.data!.deaths.toString())
                          },
                          chartRadius: w / 3.2,
                          chartType: ChartType.ring,
                          legendOptions: const LegendOptions(
                              legendPosition: LegendPosition.left),
                        ),
                        SizedBox(
                          height: h * 0.1,
                        ),
                        Card(
                          child: Column(
                            children: [
                              ReuseAbleRow(
                                  text: 'Total Cases',
                                  value: snapshot.data!.cases.toString()),
                              ReuseAbleRow(
                                  text: 'Today Cases',
                                  value: snapshot.data!.todayCases.toString()),
                              ReuseAbleRow(
                                text: "Recovered",
                                value: snapshot.data!.recovered.toString(),
                              ),
                              ReuseAbleRow(
                                text: "Today Recovered",
                                value: snapshot.data!.todayRecovered.toString(),
                              ),
                              ReuseAbleRow(
                                  text: "Deaths",
                                  value: snapshot.data!.deaths.toString()),
                              ReuseAbleRow(
                                  text: "Today Deaths",
                                  value: snapshot.data!.todayDeaths.toString()),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: h * 0.1,
                        ),
                        InkWell(
                          onTap: () {
                            nextScreen(context, const Countries());
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            height: 50,
                            child: const Text("Track Countries"),
                          ),
                        )
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReuseAbleRow extends StatelessWidget {
  const ReuseAbleRow({
    super.key,
    required this.text,
    required this.value,
  });
  final String text, value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0, bottom: 5.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(text),
              Text(value),
            ],
          ),
          const Divider(
            thickness: 2,
          ),
        ],
      ),
    );
  }
}

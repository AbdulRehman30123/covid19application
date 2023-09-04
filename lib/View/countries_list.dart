import 'package:covid19/packages.dart';
import 'package:shimmer/shimmer.dart';

class Countries extends StatefulWidget {
  const Countries({super.key});

  @override
  State<Countries> createState() => _CountriesState();
}

class _CountriesState extends State<Countries> {
  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    Services services = Services();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: services.getCountriesRecord(),
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                  if (!snapshot.hasData) {
                    return ListView.builder(
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return Shimmer.fromColors(
                            baseColor: Colors.grey.shade700,
                            highlightColor: Colors.grey.shade100,
                            child: Column(
                              children: [
                                ListTile(
                                  leading: Container(
                                    height: 50,
                                    width: 89,
                                    color: Colors.white,
                                  ),
                                  title: Container(
                                      height: 10,
                                      width: 89,
                                      color: Colors.white),
                                  subtitle: Container(
                                      height: 10,
                                      width: 59,
                                      color: Colors.white),
                                )
                              ],
                            ));
                      },
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        String name = snapshot.data![index]['country'];
                        if (searchController.text.isEmpty) {
                          return Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  nextScreen(
                                    context,
                                    DetailScreen(
                                      name: snapshot.data![index]['country'],
                                      image: snapshot.data![index]
                                          ['countryInfo']['flag'],
                                      totalCases: snapshot.data![index]
                                          ['cases'],
                                      totalDeaths: snapshot.data![index]
                                          ['deaths'],
                                      totalRecovered: snapshot.data![index]
                                          ['recovered'],
                                      active: snapshot.data![index]['active'],
                                      critical: snapshot.data![index]
                                          ['critical'],
                                      test: snapshot.data![index]['tests'],
                                      todayRecovered: snapshot.data![index]
                                          ['todayRecovered'],
                                    ),
                                  );
                                },
                                child: ListTile(
                                  leading: Image.network(
                                    snapshot.data![index]['countryInfo']
                                        ['flag'],
                                    height: 50,
                                    width: 50,
                                  ),
                                  title: Text(snapshot.data![index]['country']),
                                  subtitle: Text(snapshot.data![index]['cases']
                                      .toString()),
                                ),
                              )
                            ],
                          );
                        } else if (name.toLowerCase().contains(
                              searchController.text.toLowerCase(),
                            )) {
                          return Column(
                            children: [
                              ListTile(
                                leading: Image.network(
                                  snapshot.data![index]['countryInfo']['flag'],
                                  height: 50,
                                  width: 50,
                                ),
                                title: Text(snapshot.data![index]['country']),
                                subtitle: Text(
                                    snapshot.data![index]['cases'].toString()),
                              )
                            ],
                          );
                        } else {
                          return Container();
                        }
                      },
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

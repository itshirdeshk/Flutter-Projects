import 'package:covid_19_tracker/services/states_services.dart';
import 'package:covid_19_tracker/view/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({super.key});

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  StatesServices statesServices = StatesServices();
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: searchController,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                hintText: "Search any Country",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
              ),
            ),
          ),
          Expanded(
              child: FutureBuilder(
            future: statesServices.countriesListApi(),
            builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      String countryName = snapshot.data![index]["country"];

                      if (searchController.text.isEmpty) {
                        return Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailScreen(
                                              name: snapshot.data![index]
                                                  ["country"],
                                              image: snapshot.data![index]
                                                  ["countryInfo"]["flag"],
                                              totalCases: snapshot.data![index]
                                                  ["cases"],
                                              totalDeaths: snapshot.data![index]
                                                  ["deaths"],
                                              totalRecovered: snapshot
                                                  .data![index]["recovered"],
                                              todayRecovered:
                                                  snapshot.data![index]
                                                      ["todayRecovered"],
                                              active: snapshot.data![index]
                                                  ["active"],
                                              test: snapshot.data![index]
                                                  ["tests"],
                                              critical: snapshot.data![index]
                                                  ["critical"],
                                            )));
                              },
                              child: ListTile(
                                title: Text(snapshot.data![index]["country"]),
                                subtitle: Text(
                                    snapshot.data![index]["cases"].toString()),
                                leading: Image(
                                  height: 50,
                                  width: 50,
                                  image: NetworkImage(snapshot.data![index]
                                      ["countryInfo"]["flag"]),
                                ),
                              ),
                            ),
                          ],
                        );
                      } else if (countryName
                          .toLowerCase()
                          .contains(searchController.text.toLowerCase())) {
                        return Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailScreen(
                                              name: snapshot.data![index]
                                                  ["country"],
                                              image: snapshot.data![index]
                                                  ["countryInfo"]["flag"],
                                              totalCases: snapshot.data![index]
                                                  ["cases"],
                                              totalDeaths: snapshot.data![index]
                                                  ["deaths"],
                                              totalRecovered: snapshot
                                                  .data![index]["recovered"],
                                              todayRecovered:
                                                  snapshot.data![index]
                                                      ["todayRecovered"],
                                              active: snapshot.data![index]
                                                  ["active"],
                                              test: snapshot.data![index]
                                                  ["tests"],
                                              critical: snapshot.data![index]
                                                  ["critical"],
                                            )));
                              },
                              child: ListTile(
                                title: Text(snapshot.data![index]["country"]),
                                subtitle: Text(
                                    snapshot.data![index]["cases"].toString()),
                                leading: Image(
                                  height: 50,
                                  width: 50,
                                  image: NetworkImage(snapshot.data![index]
                                      ["countryInfo"]["flag"]),
                                ),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Container();
                      }
                    });
              } else {
                return ListView.builder(
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey.shade700,
                        highlightColor: Colors.grey.shade100,
                        child: Column(
                          children: [
                            ListTile(
                              title: Container(
                                height: 10,
                                width: 89,
                                color: Colors.white,
                              ),
                              subtitle: Container(
                                height: 10,
                                width: 89,
                                color: Colors.white,
                              ),
                              leading: Container(
                                height: 50,
                                width: 50,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      );
                    });
              }
            },
          ))
        ],
      )),
    );
  }
}

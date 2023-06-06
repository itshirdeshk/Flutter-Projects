import 'package:covid_19_tracker/view/world_states.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  final String name, image;
  final int totalCases,
      totalDeaths,
      totalRecovered,
      active,
      critical,
      todayRecovered,
      test;
  const DetailScreen(
      {super.key,
      required this.name,
      required this.image,
      required this.totalCases,
      required this.totalDeaths,
      required this.active,
      required this.critical,
      required this.todayRecovered,
      required this.test,
      required this.totalRecovered});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.067),
                  child: Card(
                    child: Column(children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.06,
                      ),
                      ReusuableRow(
                          title: "Name : ", value: widget.name.toString()),
                      ReusuableRow(
                          title: "Cases : ",
                          value: widget.totalCases.toString()),
                      ReusuableRow(
                          title: "Recovered : ",
                          value: widget.totalRecovered.toString()),
                      ReusuableRow(
                          title: "Active : ", value: widget.active.toString()),
                      ReusuableRow(
                          title: "Critical : ",
                          value: widget.critical.toString()),
                    ]),
                  ),
                ),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(widget.image),
                )
              ],
            )
          ]),
    );
  }
}

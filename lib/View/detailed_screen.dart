import 'package:coronavirusindicatorproject/View/world_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
class DetailedScreen extends StatefulWidget {
  String name;
  String image;
  int cases,todayCases,deaths,todayDeaths,recovered,todayRecovered,active,critical;
   DetailedScreen({Key? key,
    required this.name,
    required this.image,
    required this.cases,
    required this.todayCases,
    required this.deaths,
    required this.todayDeaths,
    required this.recovered,
    required this.todayRecovered,
    required this.active,
    required this.critical
  }) : super(key: key);

  @override
  State<DetailedScreen> createState() => _DetailedScreenState();
}

class _DetailedScreenState extends State<DetailedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.name}"),
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
                padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.067),
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height*0.06,),
                      ReuseableRow(title: "Total Cases", value: '${widget.cases}'),
                      ReuseableRow(title: "Today Cases", value: '${widget.todayCases}'),
                      ReuseableRow(title: "Deaths", value: '${widget.deaths}'),
                      ReuseableRow(title: "Today Deaths", value: '${widget.todayDeaths}'),
                      ReuseableRow(title: "Recovered", value: '${widget.recovered}'),
                      ReuseableRow(title: "Tody Recovered", value: '${widget.todayRecovered}'),
                      ReuseableRow(title: "Active", value: '${widget.active}'),
                      ReuseableRow(title: "Critical", value: '${widget.critical}'),
                    ],
                  ),
                ),
              ),
              
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(widget.image),
                      )
            ],
          )
        ],
      ),
    );
  }
}
import 'package:coronavirusindicatorproject/Model/world_states_model.dart';
import 'package:coronavirusindicatorproject/Services/states_services.dart';
import 'package:coronavirusindicatorproject/View/countries_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';
class WorldStatesScreem extends StatefulWidget {
  const WorldStatesScreem({Key? key}) : super(key: key);

  @override
  State<WorldStatesScreem> createState() => _WorldStatesScreemState();
}

class _WorldStatesScreemState extends State<WorldStatesScreem> with TickerProviderStateMixin{
  late final AnimationController _controller = AnimationController(
  vsync: this,
  duration: const Duration( seconds: 4)
  )..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  final colorlist = <Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246)
  ];
  @override
  Widget build(BuildContext context) {
    WorldsStatesFetch worldStatesFetch= WorldsStatesFetch();
    return Scaffold(
      body: SafeArea(
        child:Padding(
          padding: const EdgeInsets.all(15.0),
          child: FutureBuilder(
            future:worldStatesFetch.fetchWorldStates(),
            builder: (context,AsyncSnapshot<WorldStatesModel> snapshot) {
              if (!snapshot.hasData) {
                return SpinKitFadingCircle(
                  color: Colors.white,
                  size: 50,
                  controller: _controller,
                );
              }
              else{
             return  Column(
                  children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                  PieChart(
                    dataMap:  {
                      "Total" :double.parse(snapshot.data!.cases.toString()),
                      "Recovered":double.parse(snapshot.data!.recovered.toString()),
                      "Deaths":double.parse(snapshot.data!.deaths.toString())
                  },
                  chartValuesOptions: const ChartValuesOptions(
                    showChartValuesInPercentage: true
                  ),
                  animationDuration: Duration(seconds:1),
                  chartType: ChartType.ring,
                  colorList: colorlist,
                  chartRadius: MediaQuery.of(context).size.width/3.2,
                  legendOptions: const LegendOptions(
                    legendPosition: LegendPosition.left
                  ),
                  )
                  ,Padding(
                    padding:  EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height* 0.06),
                    child: Card(
                      child: Column(
                        children: [
                          ReuseableRow(title: "Total",value: snapshot.data!.cases!.toString(),),
                          ReuseableRow(title: "Deaths",value: snapshot.data!.deaths!.toString(),),
                          ReuseableRow(title: "Recovered",value: snapshot.data!.recovered!.toString(),),
                          ReuseableRow(title: "Active",value: snapshot.data!.active!.toString(),),
                          ReuseableRow(title: "Critical",value: snapshot.data!.critical!.toString(),),
                          ReuseableRow(title: "TodayCases",value: snapshot.data!.todayCases!.toString(),),
                          ReuseableRow(title: "TodayRecovered",value: snapshot.data!.todayRecovered!.toString(),),
                          ReuseableRow(title: "TodayDeaths",value: snapshot.data!.todayDeaths!.toString(),),
                        ],
                      ),
                    ),
                  ),
                   GestureDetector(
                    onTap: () => 
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const CountriesList())),
                     child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color:Color(0xff1aa260),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child:Center(
                        child: Text("Track Countries"))
                                     ),
                   )     
                  ],
                );
              }
              
            }
          ),
        ) 
        ),
    );
  }
}
class ReuseableRow extends StatelessWidget {
  String title,value;
  ReuseableRow({Key? key,required this.title,required this.value}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 5),
      child: Column(
        children: [
          Row(
              mainAxisAlignment:MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value)
            ],
          ),
          SizedBox(height: 5,),
          Divider()
        ],
      ),
    );
  }
}
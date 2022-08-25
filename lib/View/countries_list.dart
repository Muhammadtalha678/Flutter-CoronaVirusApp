import 'package:coronavirusindicatorproject/Services/states_services.dart';
import 'package:coronavirusindicatorproject/View/detailed_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesList extends StatefulWidget {
  const CountriesList({Key? key}) : super(key: key);

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    WorldsStatesFetch countriesstates = WorldsStatesFetch();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor:Theme.of(context).scaffoldBackgroundColor
      ),
      body: SafeArea(child: Column(
        
        children: [
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: TextFormField(
              controller: _searchController,
              onChanged: (value){
                setState(() {
                  
                });
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
                hintText: "Search With Country Name",
                border:OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50)
                )
              ),
            ),
          ),
          Expanded(
            // physics:,
            child:FutureBuilder(
              future: countriesstates.fetchCountriesStates(),
              builder:(context,AsyncSnapshot<List<dynamic>>snapshot){

                print(snapshot.data);
                if (!snapshot.hasData) {
                   return ListView.builder(
                    itemCount: 20,
                  itemBuilder:(context,index){
                    return Shimmer.fromColors(
                      highlightColor: Colors.grey.shade100,
                       baseColor: Colors.grey.shade700,
                       child: Column(
                      children: [
                        ListTile(
                          title: Container(height: 10,width: 89,color: Colors.white,),
                          subtitle: Container(height: 10,width: 89,color: Colors.white,),
                          leading: Container(height: 50,width: 50,color: Colors.white,)
                        )
                      ],
                    ),
                       );
                  } 
                  );
                }
                else{
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                  itemBuilder:(context,index){
                    String name = snapshot.data![index]['country'];

                    if (_searchController.text.isEmpty) {
                      return Column(
                      children: [
                        InkWell(
                          onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>
                          DetailedScreen(
                            name: snapshot.data![index]['country'],
                           image: snapshot.data![index]['countryInfo']['flag'],
                            cases: snapshot.data![index]['cases'],
                             todayCases: snapshot.data![index]['todayCases'],
                              deaths: snapshot.data![index]['deaths'],
                               todayDeaths: snapshot.data![index]['todayDeaths'],
                                recovered: snapshot.data![index]['recovered'],
                                 todayRecovered: snapshot.data![index]['todayRecovered'],
                                  active: snapshot.data![index]['active'],
                                   critical: snapshot.data![index]['critical'],
                                   )
                          )),
                          child: ListTile(
                            title: Text('${snapshot.data![index]['country']}'),
                            subtitle: Text('${snapshot.data![index]['cases']}'),
                            leading: Image(
                              width: 50,
                              height: 50,
                              image: NetworkImage(snapshot.data![index]['countryInfo']['flag'])
                              ),
                          ),
                        )
                      ],
                    );  
                    }
                    else if(name.toLowerCase().contains(_searchController.text.toLowerCase())){
                      return Column(
                      children: [
                        InkWell(
                          onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>
                          DetailedScreen(
                            name: snapshot.data![index]['country'],
                           image: snapshot.data![index]['countryInfo']['flag'],
                            cases: snapshot.data![index]['cases'],
                             todayCases: snapshot.data![index]['todayCases'],
                              deaths: snapshot.data![index]['deaths'],
                               todayDeaths: snapshot.data![index]['todayDeaths'],
                                recovered: snapshot.data![index]['recovered'],
                                 todayRecovered: snapshot.data![index]['todayRecovered'],
                                  active: snapshot.data![index]['active'],
                                   critical: snapshot.data![index]['critical'],
                                   )
                          )),
                          child: ListTile(
                            title: Text('${snapshot.data![index]['country']}'),
                            subtitle: Text('${snapshot.data![index]['cases']}'),
                            leading: Image(
                              width: 50,
                              height: 50,
                              image: NetworkImage(snapshot.data![index]['countryInfo']['flag'])
                              ),
                          ),
                        )
                      ],
                    );
                    }
                    else{
                      return Container();
                    }
                  } 
                  );
                }
                
              } 
              ) 
            )
        ],
      )),
    );
  }
}
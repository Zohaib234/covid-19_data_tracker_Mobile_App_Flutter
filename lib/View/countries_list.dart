import 'package:covid_tracker/Services/Utilities/states_services.dart';
import 'package:covid_tracker/View/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({Key? key}) : super(key: key);

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    StatesServices services = StatesServices();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                onChanged: (value){
                  setState(() {

                  });
                },
                controller: controller,
                decoration: InputDecoration(
                    hintText: "Search with country name",
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50))),
              ),
            ),
            Expanded(
                child: FutureBuilder(
                  future: services.getCountries(),
              builder: (context,AsyncSnapshot<List<dynamic>> snapshot) {
                if(!snapshot.hasData){
                  return ListView.builder(
                    itemCount: 100,
                    itemBuilder: (BuildContext context, int index) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey.shade700,
                        highlightColor: Colors.grey.shade100,
                        child: Column(
                            children: [
                        ListTile(
                        title: Container(height: 10,width: 89,color: Colors.white,),
                        subtitle: Container(height: 10,width: 89,color: Colors.white,),
                          leading: Container(height: 50,width: 50,color: Colors.white,),

                      )
                      ],
                      ));
                    },

                  );
                }
                else{
                  return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    String name = snapshot.data![index]['country'];

                    if(controller.text.isEmpty){
                      return Column(
                        children: [
                          InkWell(
                            onTap:(){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailScreen(
                                image: snapshot.data![index]['countryInfo']['flag'],
                                name: snapshot.data![index]['country'],
                                totalCases: snapshot.data![index]['cases'],
                                todayRecovered: snapshot.data![index]['recovered'],
                                totalDeaths: snapshot.data![index]['deaths'],
                                active: snapshot.data![index]['active'],
                                test: snapshot.data![index]['tests'],
                                totalRecovered: snapshot.data![index]['todayRecovered'],
                                critical: snapshot.data![index]['critical'],

                              )));
                            },
                            child: ListTile(
                              title: Text(snapshot.data![index]['country']),
                              subtitle: Text(snapshot.data![index]['cases'].toString()),
                              leading: Image(
                                  height:50,
                                  width:50,
                                  image: NetworkImage(snapshot.data![index]['countryInfo']['flag'])),
                            ),
                          )
                        ],
                      );
                    }
                    else if(name.toLowerCase().contains(controller.text.toLowerCase())){
                      return Column(
                        children: [
                          InkWell(
                            onTap:(){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailScreen(
                              image: snapshot.data![index]['countryInfo']['flag'],
                              name: snapshot.data![index]['country'],
                              totalCases: snapshot.data![index]['cases'],
                              todayRecovered: snapshot.data![index]['recovered'],
                              totalDeaths: snapshot.data![index]['deaths'],
                              active: snapshot.data![index]['active'],
                              test: snapshot.data![index]['tests'],
                              totalRecovered: snapshot.data![index]['todayRecovered'],
                              critical: snapshot.data![index]['critical'],
                            )));
                      },
                            child: ListTile(
                              title: Text(snapshot.data![index]['country']),
                              subtitle: Text(snapshot.data![index]['cases'].toString()),
                              leading: Image(
                                  height:50,
                                  width:50,
                                  image: NetworkImage(snapshot.data![index]['countryInfo']['flag'])),
                            ),
                          )
                        ],
                      );
                    }
                    else{
                       return Container();
                    }
                  });
                }

              },
            ))
          ],
        ),
      ),
    );
  }
}

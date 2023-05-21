import 'package:covid_tracker/Modal/WorldStateModal.dart';
import 'package:covid_tracker/Services/Utilities/states_services.dart';
import 'package:covid_tracker/View/countries_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';
class WorldStateScreen extends StatefulWidget {
  const WorldStateScreen({Key? key}) : super(key: key);

  @override
  State<WorldStateScreen> createState() => _WorldStateScreenState();
}

class _WorldStateScreenState extends State<WorldStateScreen> with TickerProviderStateMixin {

  late final AnimationController controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this)..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }
  final colorlist = <Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),

  ];


  @override
  Widget build(BuildContext context) {
    StatesServices services = StatesServices();
    return Scaffold(

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height*.01,),
              FutureBuilder(
                  future: services.getWorldStateRecord(),
                  builder: (context,AsyncSnapshot<WorldStateModal> snapshot){
                  if(!snapshot.hasData){
                    return Expanded(
                        flex: 1,
                        child: SpinKitFadingCircle(
                          color: Colors.white,
                          size: 50.0,
                          controller: controller,

                        )
                    );
                  }
                  else{
                    return Column(
                      children: [
                        PieChart(
                          dataMap:   {
                            "total":double.parse(snapshot.data!.cases.toString()),
                            "Recovered": double.parse(snapshot.data!.recovered.toString()),
                            "Deaths":double.parse(snapshot.data!.deaths.toString()),
                          },
                          animationDuration: const Duration(milliseconds: 1200),
                          chartRadius: MediaQuery.of(context).size.width/3.2,
                          legendOptions: const  LegendOptions(
                              legendPosition: LegendPosition.left
                          ),
                          chartValuesOptions: const ChartValuesOptions(
                            showChartValuesInPercentage: true
                          ),
                        ),
                        Padding(
                          padding:  EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*.02),
                          child: Card(
                            child: Column(
                              children: [
                                ReuseableRow(title: "Total", value: snapshot.data!.cases.toString()),
                                ReuseableRow(title: "Deaths", value: snapshot.data!.deaths.toString()),
                                ReuseableRow(title: "Recovered", value: snapshot.data!.recovered.toString()),
                                ReuseableRow(title: "Active", value: snapshot.data!.active.toString()),
                                ReuseableRow(title: "Critical", value: snapshot.data!.critical.toString()),
                                ReuseableRow(title: "Today Death", value: snapshot.data!.todayDeaths.toString()),
                                ReuseableRow(title: "Today recovered", value: snapshot.data!.todayRecovered.toString()),

                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),

                        GestureDetector(
                          onTap:(){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> const CountriesListScreen()));
                          },
                          child: Container(
                            height: 50,
                            width: 200,
                            decoration: BoxDecoration(
                              color: Colors.teal,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              child: Text("track Countries "),
                            ),
                          ),
                        ),
                      ],
                    );

                  }

              }),

            ],
          ),
        ),
      ),
    );
  }
}
class ReuseableRow extends StatelessWidget {
  String title, value;
   ReuseableRow({Key? key, required this.title , required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          const  SizedBox(height: 10,),
           const Divider(),

        ],
      ),
    );
  }
}


import 'package:covidapp/country_list_screen.dart';
import 'package:covidapp/services/state_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

import 'model/world_state.dart';

class WorldSatate extends StatefulWidget {
  const WorldSatate({Key? key}) : super(key: key);

  @override
  State<WorldSatate> createState() => _WorldSatateState();
}

class _WorldSatateState extends State<WorldSatate> with TickerProviderStateMixin{
   late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 3),
  vsync:this)..repeat();

  @override
  void dispose() {
  
    super.dispose();
    _controller.dispose();
  }
  
  final colorList = <Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),

  ];

  @override
  Widget build(BuildContext context) {

    StatesServices statesServices  = StatesServices();
    
    return Scaffold(
      body:SafeArea(
      child: Padding(padding: EdgeInsets.all(15.0),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height *.01),

            FutureBuilder(
              future:statesServices.fetchWorldSatesRecords() ,
              builder:  (context, AsyncSnapshot<WorldStatesModel> snapshot) {
              if(!snapshot.hasData){
                return  Expanded(child: SpinKitFadingCircle(color: Colors.white,size: 50.0,
                controller: _controller,
                ),
                );

              }
              else{
              return Column(
                children: [


                     PieChart(dataMap:  {
               'Total': double.parse(snapshot.data!.cases!.toString()),
               'Recover':double.parse(snapshot.data!.recovered!.toString()),
                'Deaths':double.parse(snapshot.data!.deaths!.toString()),
               


            },
            chartValuesOptions: ChartValuesOptions(showChartValuesInPercentage: true),
            chartRadius: MediaQuery.of(context).size.width/3.2,
            legendOptions: const LegendOptions(
              legendPosition: LegendPosition.left
            ),
            animationDuration: const Duration(microseconds: 1280),
            chartType: ChartType.ring,
          
            colorList: colorList,
            ),
            Padding(
              padding:  EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*.06),
              child: Card(
                child: Column(children: [
                  ReuseableRow(title: 'Total Cases', value: snapshot.data!.cases.toString()),
                   ReuseableRow(title:  'Deaths', value: snapshot.data!.deaths.toString()),
                    ReuseableRow(title: 'Recovered', value: snapshot.data!.recovered.toString()),
                    ReuseableRow(title: 'Active', value: snapshot.data!.active.toString()),
                    ReuseableRow(title: 'Critical', value: snapshot.data!.critical.toString()),
                    ReuseableRow(title: 'Today Deaths', value: snapshot.data!.todayDeaths.toString()),
                    ReuseableRow(title: 'Today Recovered', value: snapshot.data!.todayRecovered.toString()),


                ]
                ),
              ),
          
          
            ),

            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>CountryListScreen()));
              },
              child: Container(
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Center(child: Text('Track Country',style:TextStyle(color:Colors.white))
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
  String title,value;
   ReuseableRow({Key? key , required this.title, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    

    return Padding(
      padding: const EdgeInsets.only(left: 10, right:10, top:10, bottom:5),
      child: Column(
    
        children: [
          
          Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],

          ),
          SizedBox(height: 5),
        ],
      ),
    );
  }
}
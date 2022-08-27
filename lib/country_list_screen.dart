import 'package:covidapp/detaile_screen.dart';
import 'package:covidapp/services/state_services.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountryListScreen extends StatefulWidget {
  const CountryListScreen({Key? key}) : super(key: key);

  @override
  State<CountryListScreen> createState() => _CountryListScreenState();
}

class _CountryListScreenState extends State<CountryListScreen> {
  TextEditingController searchCountroller = TextEditingController();
  @override
  Widget build(BuildContext context) {

    StatesServices statesServices = StatesServices();
    
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.green,
      ),
      body: SafeArea(child:
       Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(


            controller: searchCountroller,
            onChanged: (value) {
              
             setState(() {
              
            });
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 20),
              hintText: 'Search with Country Name',
              border: OutlineInputBorder(
                borderRadius:BorderRadius.circular(50.0),
              ),
            ),
          ),
        ),
        Expanded(child: FutureBuilder(
        future: statesServices.CountrieslistApi(),
        builder: (context, AsyncSnapshot<List<dynamic>>snapshot){

          if(!snapshot.hasData){



            return ListView.builder(
              itemCount:4,
              itemBuilder: ( context , index) { 
                return Shimmer.fromColors(baseColor: Colors.grey, 
                highlightColor: Colors.grey, 
                child: Column(children: [

                  ListTile(

                    title: Container(height: 8.0, width: 100, color: Colors.white),
                    subtitle: Container(height: 8.0, width:double.infinity, color: Colors.white),
                    leading: Container(height: 50, width: 50, color: Colors.white),
                  ),
                ]),);
               },);

          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                String Name=snapshot.data![index]['country'];
                if(searchCountroller.text.isEmpty){
               return   Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>DetaileScreen(
                         image: snapshot.data![index]['countryInfo']['flag'],
                                    name: snapshot.data![index]['country'] ,
                                    totalCases:  snapshot.data![index]['cases'] ,
                                    totalRecovered: snapshot.data![index]['recovered'] ,
                                    totalDeaths: snapshot.data![index]['deaths'],
                                    active: snapshot.data![index]['active'],
                                    test: snapshot.data![index]['tests'],
                                    todayRecovered: snapshot.data![index]['todayRecovered'],
                                    critical: snapshot.data![index]['critical'] ,
                      ),
                      ));
                    },
                    child: ListTile(
                     
                      leading: Image(
                        height: 50,
                        width: 50,
                        image: AssetImage(snapshot.data![index]['countryInfo']['flag']),),
                         title: Text(snapshot.data![index]['country']),
                      subtitle: Text("Effected: "+snapshot.data![index]['cases'].toString()),
                  
                    ),
                  ),

                  Divider(),

                ],
              );

                }
               
                else if(Name.toLowerCase().contains(searchCountroller.text.toLowerCase()))
                {
                   return   Column(
                children: [
                  ListTile(
                    title: Text(snapshot.data![index]['country']),
                    subtitle: Text(snapshot.data![index]['cases'].toString()),

                    leading: Image(
                      height: 50,
                      width: 50,
                      image: AssetImage(snapshot.data![index]['countryInfo']['flag']),),
                  ),


                ],
              );

                }
                else{
                  return Column();

                }
              
            } 
            );



          }



        },))

      ],)),




    );
  }
}
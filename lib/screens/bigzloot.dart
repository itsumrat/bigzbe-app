import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../my_theme.dart';

class Bigzloot extends StatefulWidget {
  @override
  State<Bigzloot> createState() => _BigzlootState();
}

class _BigzlootState extends State<Bigzloot> {

  @override
  void initState(){
    super.initState();
    Slider = getSliderData();
  }

  List items = [];
   Future Slider;
   List SliderItems = [];







   @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: buildAppBar(context),
        body: Column(
          children: [
            //############### -- SLieder --#################
              buildSlider(),
            //############### -- SLieder --#################

          ],
        ),
      )
    );
  }


  getSliderData() async{
    final response = await http.get(Uri.parse("https://bigzbe.com/api/v2/bzslider"));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      for(Map i in data){
        items.add(i["image"]);
      }
      return items;
    }else{
      return items;
    }
  }

   FutureBuilder<dynamic> buildSlider() {
     return FutureBuilder(
          future: Slider,
            builder: (context, AsyncSnapshot<dynamic> snapshot){
            if(snapshot.hasData){
              return CarouselSlider.builder(
                itemCount: items.length,
                options: CarouselOptions(
                  height: 150,
                  aspectRatio: 16/9,
                  viewportFraction: 0.8,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  initialPage: 0,
                  enableInfiniteScroll:true,
                  reverse: false,
                  autoPlayInterval: Duration(seconds: 5),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  scrollDirection: Axis.horizontal,
                ),
                itemBuilder: (context, index, realIdx) {
                  return  Container(
                    height: 120,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                            image: NetworkImage("https://bigzbe.com/public/uploads/bzslider/${items[index]}"),
                            fit: BoxFit.cover
                        )
                    ),

                  );
                },
              );
            }else if(snapshot.connectionState == ConnectionState.waiting){
              return CarouselSlider.builder(
                itemCount: 3,
                options: CarouselOptions(
                  height: 150,
                  aspectRatio: 16/9,
                  viewportFraction: 0.8,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  initialPage: 0,
                  enableInfiniteScroll:true,
                  reverse: false,
                  autoPlayInterval: Duration(seconds: 5),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  scrollDirection: Axis.horizontal,
                ),
                itemBuilder: (context, index, realIdx) {
                  return  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                            image: NetworkImage("https://freedomplazaarizona.com/wp-content/uploads/2018/04/Loading.gif"),

                        )
                    ),

                  );
                },
              );

            }else{
              return Center(child: Text("Something went wearning"),);
            }

            }
        );
   }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      leading: Builder(
        builder: (context) => IconButton(
          icon: Icon(Icons.arrow_back, color: MyTheme.dark_grey),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      title: Text(
        "Bigzloot",
       // AppLocalizations.of(context).bkash_screen_pay_with_bkash,
        style: TextStyle(fontSize: 16, color: MyTheme.accent_color),
      ),
      elevation: 0.0,
      titleSpacing: 0,
    );
  }
}




import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                child: PageView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Image.network("https://images.pexels.com/photos/2899097/pexels-photo-2899097.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"
                      , fit: BoxFit.fitWidth,),
                  ],
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                children: List.generate(5, (index) {
                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text("Name"),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 210,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                            itemCount: 5, itemBuilder: (context, index){
                          return Container(
                            width: 193,
                            height: 247,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:[
/*                                Container(
                                  width: 193,
                                  height: 118,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: FlutterLogo(size: 118),
                                ),*/
                                SizedBox(
                                  width: 191,
                                  child: Text(
                                    "2021 Complete Python Bootcamp From Zero...",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontFamily: "Lato",
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 165,
                                  height: 22,
                                  child: Text(
                                    "Shivesh Krishna",
                                    style: TextStyle(
                                      color: Color(0xff6a6a6a),
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 63,
                                  height: 22,
                                  child: Text(
                                    "(324,675)",
                                    style: TextStyle(
                                      color: Color(0xff6a6a6a),
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 98,
                                  height: 22,
                                  child: Stack(
                                    children:[],
                                  ),
                                ),
                                SizedBox(
                                  width: 165,
                                  height: 22,
                                  child: Text(
                                    "4.5",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontFamily: "Lato",
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 45,
                                  height: 22,
                                  child: Text(
                                    "₹99",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 24,
                                      fontFamily: "Lato",
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 92,
                                  height: 22,
                                  child: Text(
                                    "₹2850",
                                    style: TextStyle(
                                      color: Color(0xff484848),
                                      fontSize: 18,
                                      fontFamily: "Lato",
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                      SizedBox(height: 50,),
                    ],
                  );
                }),
              )
            ],
          ),
        ),
      )
    );
  }
}

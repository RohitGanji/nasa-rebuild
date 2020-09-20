import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:model_viewer/model_viewer.dart';
import 'package:nasa_rebuild/services/networking.dart';
import 'package:shimmer/shimmer.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';


class HomePage extends StatefulWidget {
  HomePage({@required this.name});
  final name;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var homeWeight = FontWeight.bold;
  var liveWeight = FontWeight.normal;
  var threeDWeight = FontWeight.normal;
  Future launchSchedule;
  Network network = Network();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    launchSchedule = getLaunchScheduling();
  }

  getLaunchScheduling() async {
    return await network.launchSchedule();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var name = widget.name;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: RichText(
          text: TextSpan(
              style: TextStyle(color: Colors.white),
              children: <TextSpan>[
                TextSpan(text: 'NASA\n', style: TextStyle(fontFamily: 'Nasa', fontSize: 30)),
                TextSpan(text: 'REBUILD', style: TextStyle(letterSpacing: 6, fontSize: 10))
              ]
          ),
          textAlign: TextAlign.center,
        ),
        leading: Icon(
          Icons.menu,
          size: size.height/35,
        ),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.search,
                  size: size.height/35,
                ),
              )),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    child: Container(
                      width: size.width/7,
                      height: size.height/40,
                      child: Center(
                        child: Text(
                          'Home',
                          style: TextStyle(
                            fontSize: size.height/50,
                            fontWeight: homeWeight
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        homeWeight = FontWeight.bold;
                        liveWeight = FontWeight.normal;
                        threeDWeight = FontWeight.normal;
                      });
                    },
                  ),
                  GestureDetector(
                    child: Container(
                      width: size.width/7,
                      height: size.height/40,
                      child: Center(
                        child: Text(
                          'Live',
                          style: TextStyle(
                              fontSize: size.height/50,
                              fontWeight: liveWeight
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        homeWeight = FontWeight.normal;
                        liveWeight = FontWeight.bold;
                        threeDWeight = FontWeight.normal;
                      });
                    },
                  ),
                  GestureDetector(
                    child: Container(
                      width: size.width/7,
                      height: size.height/40,
                      child: Center(
                        child: Text(
                          '3D',
                          style: TextStyle(
                              fontSize: size.height/50,
                              fontWeight: threeDWeight
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        homeWeight = FontWeight.normal;
                        liveWeight = FontWeight.normal;
                        threeDWeight = FontWeight.bold;
                      });
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height / 30,
            ),
            (homeWeight == FontWeight.bold) ?
            Column(
              children: [
                Text(
                  'Launch Schedule',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: size.height / 50, color: Colors.white),
                ),
                SizedBox(
                  height: size.height / 60,
                ),
                FutureBuilder(
                  future: launchSchedule,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.data != null)
                      return CarouselSlider(
                        items: [
                          for (var i in snapshot.data)
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(size.height / 40))),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    size.height / 40),
                                child: Column(
                                  children: [
                                    Stack(
                                      children: [
                                        Image.network(i['image']),
                                        Container(
                                          color: Colors.black.withOpacity(0.65),
                                          height: size.width / 1.9,
                                          width: size.width,
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  height: size.height / 50,
                                                ),
                                                Text(
                                                  i['mission'],
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: size.height /
                                                          40),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Expanded(
                                      child: Container(
                                        color: Colors.grey[900],
                                        child: Center(
                                          child: Text(
                                            i['date'],
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: size.height / 55),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                        ],
                        options: CarouselOptions(
                            height: size.width / 1.5,
                            enableInfiniteScroll: false,
                            enlargeCenterPage: true,
                            viewportFraction: 0.7),
                      );
                    else
                      return Shimmer.fromColors(
                          child: Container(
                            height: 200,
                            width: 200,
                          ),
                          baseColor: Colors.green,
                          highlightColor: Colors.red);
                    }
                ),
              ],
            ) :
            (liveWeight == FontWeight.bold) ?
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    width: size.width,
                    height: size.height/3,
                    color: Colors.grey,
                  ),
                )
              ],
            ) :
            Expanded(
              child: Container(
                child: ModelViewer(
                  src: 'assets/3d/Earth.glb',
                  alt: "A 3D model of an astronaut",
                  ar: true,
                  autoRotate: true,
                  cameraControls: true,
                  backgroundColor: Colors.black,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

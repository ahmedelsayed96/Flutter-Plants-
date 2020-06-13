import 'package:flutter/material.dart';
import 'package:plant_video/mColors.dart';
import 'package:plant_video/plant_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;
  int currentIndex = 0;

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    animation = Tween<double>(begin: 205, end: 205).animate(controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: <Widget>[buildVerticalMenu(size), buildBody(size)],
        ),
      ),
    );
  }

  Widget buildVerticalMenu(Size size) {
    return Container(
      width: 80,
      height: size.height,
      color: greenLight,
      child: Stack(
        children: <Widget>[
          buildMenuBody(),
          AnimatedBuilder(
              animation: controller,
              builder: (context, snapshot) {
                return Positioned(
                  top: animation.value,
                  right: 0,
                  child: ClipPath(
                    clipper: RecClip(),
                    child: Container(
                      color: greenDark,
                      width: 10,
                      height: 30,
                    ),
                  ),
                );
              })
        ],
      ),
    );
  }

  Widget buildMenuBody() {
    return Column(
      children: <Widget>[
        Container(
          width: 80,
          height: 150,
          color: greenDark,
          child: Center(
              child: Text(
            'De_\nTan',
            style: TextStyle(
                color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
          )),
        ),
        buildMeuItemText('Tranding', 0),
        buildMeuItemText('Categories', 1),
        buildMeuItemText('Favorite', 2),
        SizedBox(
          height: 50,
        ),
        buildCardContainer(),
        Spacer(),
        buildIndicator(),
        SizedBox(
          height: 20,
        )
      ],
    );
  }

  Widget buildMeuItemText(String text, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          animation = Tween<double>(
                  begin: 205 + (currentIndex * 130.0),
                  end: 205 + (index * 130.0))
              .animate(controller);
          currentIndex = index;
          controller.forward(from: 0);
        });
      },
      child: RotatedBox(
        quarterTurns: -1,
        child: Container(
          width: 130,
          height: 80,
          child: Center(
            child: Text(
              text,
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCardContainer() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      height: 50,
      width: 50,
      child: Stack(
        children: <Widget>[
          Center(
            child: Icon(Icons.shopping_cart),
          ),
          Positioned(
            top: 5,
            right: 10,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15), color: greenDark),
              height: 15,
              width: 15,
              child: Center(
                child: Text(
                  '2',
                  style: TextStyle(fontSize: 10, color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildIndicator() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        decoration: BoxDecoration(
            color: greenDark,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20))),
        height: 40,
        width: 60,
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                '1',
                style: TextStyle(fontSize: 20),
              ),
              Text(
                '/8',
                style: TextStyle(fontSize: 17),
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildBody(Size size) {
    return Container(
      padding: EdgeInsets.only(left: 30),
      width: size.width - 80,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 40,
          ),
          buildProductsText(),
          SizedBox(
            height: 20,
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: getPlants().length,
                  itemBuilder: (_, index) => PlantWidget(
                        getPlants()[index],
                        isIconFirst: index.isOdd,
                      ))),
          buildBottomPager()
        ],
      ),
    );
  }

  Widget buildProductsText() {
    return Row(
      children: <Widget>[
        Text(
          'Products',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        Spacer(),
        MIcon(Icons.search),
        SizedBox(
          width: 30,
        )
      ],
    );
  }

  List<Plant> getPlants() {
    List<Plant> plants = [];
    plants.add(Plant('Potted Plants', 'images/plant1.png', 19.99));
    plants.add(Plant('Flower Vase', 'images/plant2.png', 35.99));
    return plants;
  }

  Widget buildBottomPager() {
    return Container(
      padding: EdgeInsets.only(right: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Image.asset(
            'images/left-arrow.png',
            height: 6,
            color: Colors.black54,
          ),
          SizedBox(width: 8,),
          Text('1',style: TextStyle(fontSize: 20,color: Colors.black),),
          SizedBox(width: 8,),
          Text('2',style: TextStyle(fontSize: 14,color: Colors.black45),),
          SizedBox(width: 8,),
          Text('3',style: TextStyle(fontSize: 14,color: Colors.black45),),
          SizedBox(width: 8,),
          Text('4',style: TextStyle(fontSize: 14,color: Colors.black45),),
          SizedBox(width: 8,),
          Text('...',style: TextStyle(fontSize: 14,color: Colors.black45),),
          SizedBox(width: 8,),
          RotatedBox(
              quarterTurns: 2,
              child: Image.asset(
                'images/left-arrow.png',
                height: 6,
                color: Colors.black54,
              )),
        ],
      ),
    );
  }
}

class Plant {
  String name;
  String image;
  double price;

  Plant(this.name, this.image, this.price);
}

class RecClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height / 2);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class MIcon extends StatelessWidget {
  IconData icon;
  Color color;

  MIcon(this.icon, {this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: greenLight,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        width: 50,
        height: 50,
        child: Center(
            child: Icon(
          icon,
          color: color,
        )),
      ),
    );
  }
}

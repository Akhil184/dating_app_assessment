import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motion_tab_bar/MotionBadgeWidget.dart';
import 'package:motion_tab_bar/MotionTabBar.dart';
import 'package:motion_tab_bar/MotionTabBarController.dart';
import 'package:heart_overlay/heart_overlay.dart';

final List<String> imgList = [
 'assets/images/korean_img.png',
  'assets/images/korean_img.png',
  'assets/images/korean_img.png',
  'assets/images/korean_img.png',
  'assets/images/korean_img.png'

];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late HeartOverlayController heartOverlayController;

  // @override
  // void initState() {
  //   super.initState();
  //   heartOverlayController = HeartOverlayController();
  // }

  int _current = 0;
  final CarouselController _controller = CarouselController();

  MotionTabBarController? _motionTabBarController;

  final items = [
    Image.asset('images/drumstick.png'),
    Image.asset('images/pizza.png')
  ];

  @override
  void initState() {
    super.initState();
    heartOverlayController = HeartOverlayController();
    _motionTabBarController = MotionTabBarController(
      initialIndex: 0,
      length: 4, vsync: this,

    );
  }

  @override
  void dispose() {
    super.dispose();
    _motionTabBarController!.dispose();
  }

  var responsive;
  late TabController _tabController;
  int currentIndex = 0;
  var tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    var responsive = MediaQuery
        .of(context)
        .size;
    bool isButtonPressed = false;
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.black,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.location_on,
                  color: Colors.grey,
                  size: 30.0,
                ),
                Text(
                  '목이길어슬픈기린님의 새로운 스팟',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10.sp,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(15.0),
                  padding: const EdgeInsets.all(3.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey,),
                    borderRadius: BorderRadius.all(
                        Radius.circular(
                            30.0) //                 <--- border radius here
                    ),
                  ),


                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.star_outlined,
                        color: Colors.pink,
                        size: 20.0.sp,
                      ),
                      Text('323,233', style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                      ),),
                    ],
                  ),
                ),
                Icon(
                  Icons.notifications_none,
                  color: Colors.white,
                  size: 20.0.sp,
                ),
              ],
            )),
        bottomNavigationBar: MotionTabBar(
          controller: _motionTabBarController,
          // Add this controller if you need to change your tab programmatically
          initialSelectedTab: "Home",
          useSafeArea: true,
          // default: true, apply safe area wrapper
          labels: const ["Dashboard", "Home", "Profile", "Settings"],
          icons: const [
            Icons.home,
            Icons.location_on,
            Icons.star,
            Icons.person,
          ],

          // optional badges, length must be same with labels
          badges: [
            // Default Motion Badge Widget
            const MotionBadgeWidget(
              textColor: Colors.white, // optional, default to Colors.white
              color: Colors.red, // optional, default to Colors.red
              size: 18, // optional, default to 18
            ),

            // custom badge Widget
            Container(
              color: Colors.black,
              padding: const EdgeInsets.all(2),

            ),

            // allow null
            null,

            // Default Motion Badge Widget with indicator only
            const MotionBadgeWidget(
              isIndicator: true,
              color: Colors.red, // optional, default to Colors.red
              size: 5, // optional, default to 5,
              show: true, // true / false
            ),
          ],
          tabSize: 50,
          tabBarHeight: 55,
          textStyle: const TextStyle(
            fontSize: 12,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
          tabIconColor: Colors.grey,
          tabIconSize: 28.0,
          tabIconSelectedSize: 26.0,
          tabSelectedColor:Colors.pink,
          tabIconSelectedColor: Colors.white,
          tabBarColor: Colors.deepPurpleAccent,
          onTabItemSelected: (int value) {
            setState(() {
              _motionTabBarController!.index = value;
            });
          },
        ),
        body:Stack(children: [

  Container(
    height:600,
    child: CarouselSlider(
    items: imageSliders,
    carouselController: _controller,
    options: CarouselOptions(
    autoPlay:false,
    height:800,

    enlargeCenterPage: true,
    onPageChanged: (index, reason) {
    setState(() {
    _current = index;
    });
    }),
    ),
    ),
          Padding(padding:EdgeInsets.only(top:30),
            child:Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: imgList.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => _controller.animateToPage(entry.key),
                  child: Container(
                    width: 50.0,
                    height: 5.0,
                    margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 4.0),
                    decoration: BoxDecoration(
                      // border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(15),
                        color: (Theme.of(context).brightness == Brightness.dark
                            ? Colors.grey
                            : Colors.pink)
                            .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                  ),
                );
              }).toList(),
            ),
          ),
      Padding(padding:EdgeInsets.only(top:460,left:50),
      child:Container(
        width:100,
          margin: const EdgeInsets.all(15.0),
          padding: const EdgeInsets.all(3.0),
          decoration: BoxDecoration(
            color:Colors.black,
            border: Border.all(color: Colors.grey,),
            borderRadius: BorderRadius.all(
                Radius.circular(
                    30.0) //                 <--- border radius here
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(
                Icons.star_outlined,
                color: Colors.grey,
                size: 20.0.sp,
              ),
              Text('29,930', style: TextStyle(
                color: Colors.white,
                fontSize: 12.sp,
              ),),
            ],
          ),
      ),
      ),
      Padding(padding:EdgeInsets.only(top:530,left:70),
          child:Text(
            '목이길어슬픈기린님의 새로운 스팟',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.sp,
            ),
          ),
      ),
          Padding(padding:EdgeInsets.only(top:550,left:70),
            child:Text(
              '2km 거리에 있음',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.sp,
              ),
            ),
          ),
      // HeartOverlay(
      //   controller: heartOverlayController,
      //   duration: const Duration(seconds: 5),
      //   backgroundColor: Colors.black,
      //   tapDownType: TapDownType.single,
      //   // verticalOffset: 20,
      //   // horizontalOffset: -100,
      //   enableGestures: true,
      //   cacheExtent: 30,
      //   splashAnimationDetails: const SplashAnimationDetails(
      //     enableSplash: true,
      //     animationDuration: Duration(seconds: 3),
      //   ),
      //   icon: const Icon(
      //     Icons.favorite,
      //     color: Colors.redAccent,
      //     size: 100,
      //   ),
      //   onPressed: (numberOfHearts) {
      //     // Do something with the number of hearts or do something whenever the icon appears
      //   },
      // ),
    Padding(
    padding: const EdgeInsets.all(50.0),
    child: ElevatedButton(
    onPressed: () {
    // Get the center offset
    // Offset centerOffset =
    //     heartOverlayController.getCenterScreenOffset(context);

    double iconSize = heartOverlayController.getSize() * 2;
    double height = heartOverlayController.getHeight() ??
    MediaQuery.of(context).size.height;
    double width = heartOverlayController.getWidth() ??
    MediaQuery.of(context).size.width;

    Offset offset = Offset(
    // DX
    (Random().nextDouble() * width).clamp(
    iconSize,
    width - iconSize,
    ),
    // DY
    (Random().nextDouble() * height).clamp(
    iconSize,
    height - iconSize - 100,
    ), // - 100 is for the button padding
    );

    // offset += centerOffset; // You can add offsets

    // Show the icon at the provided offset
    heartOverlayController.showIcon(
    offset: offset,
    );

    // Changes to the emoji on the second click
    heartOverlayController.changeIcon(
    icon: const Text('👀'), // Required
    size: 200, // Not required
    horizontalOffset: 10, // Not required
    verticalOffset: 30, // Not required
    );
    },
    child: const Text('Show Icon'),
    ),
    )
    ]),

    );
  }
}



final List<Widget> imageSliders = imgList
    .map((item) => Flexible(
  child: Container(
      height:3000,
    width:1000,
    decoration: BoxDecoration(
    border: Border.all(color: Colors.grey),
    borderRadius: BorderRadius.circular(15),
    image: DecorationImage(
    image:AssetImage(item),
    fit:BoxFit.fill
    // fit:BoxFit.cover,
    ),
    ),
    margin: EdgeInsets.all(5.0),
  ),
))
    .toList();


    class MainPageContentComponent extends StatelessWidget {
    const MainPageContentComponent({
    required this.title,
    required this.controller,
    Key? key,
    }) : super(key: key);

    final String title;
    final MotionTabBarController controller;

    @override
    Widget build(BuildContext context) {
    return Center(
    child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    const SizedBox(height: 50),
    const Text('Go to "X" page programmatically'),
    const SizedBox(height: 10),
    ElevatedButton(
    onPressed: () => controller.index = 0,
    child: const Text('Dashboard Page'),
    ),
    ElevatedButton(
    onPressed: () => controller.index = 1,
    child: const Text('Home Page'),
    ),
    ElevatedButton(
    onPressed: () => controller.index = 2,
    child: const Text('Profile Page'),
    ),
    ElevatedButton(
    onPressed: () => controller.index = 3,
    child: const Text('Settings Page'),
    ),
    ],
    ),
    );
    }
    }



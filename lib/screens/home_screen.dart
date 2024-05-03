import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motion_tab_bar/MotionBadgeWidget.dart';
import 'package:motion_tab_bar/MotionTabBar.dart';
import 'package:motion_tab_bar/MotionTabBarController.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  MotionTabBarController? _motionTabBarController;

  int _selectedIndex = -1;


  final items = [
    Image.asset('images/drumstick.png'),
    Image.asset('images/pizza.png')
  ];


  // CarouselController buttonCarouselController = CarouselController();
  @override
  void initState() {
    super.initState();
    //// Use normal tab controller
    // _tabController = TabController(
    //   initialIndex: 1,
    //   length: 4,
    //   vsync: this,
    // );

    //// use "MotionTabBarController" to replace with "TabController", if you need to programmatically change the tab
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
          tabBarColor: Colors.black12,
          onTabItemSelected: (int value) {
            setState(() {
              _motionTabBarController!.index = value;
            });
          },
        ),
        body: Container(
    height:responsive.height*0.76,
    decoration: BoxDecoration(
    border: Border.all(color: Colors.grey),
    borderRadius: BorderRadius.circular(15),
    image: DecorationImage(
    image:AssetImage("assets/images/img.png"),
    fit:BoxFit.fill,
    ),
    ),
    child:Card(
    color: Colors.transparent,
    elevation: 4.0,
    margin: EdgeInsets.all(10),
    child:ListView.builder(
      scrollDirection:Axis.horizontal,
    itemCount:5,
    itemBuilder: (context, index) {
    return Column(
      crossAxisAlignment:CrossAxisAlignment.start,
      children: [
        Container(
    height:10,
    child: InkWell(
      onTap: () {
        setState(() {
          _selectedIndex = index;


        });
      },
      highlightColor: Colors.blue.withOpacity(0.4),
      child: Container(
        width:responsive.width*0.18,
        height:2,
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color:_selectedIndex == index ? Colors.pink : Colors.black,
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    ),
    ),


      ],
    );

    }

          ),
        ),
        ),

          );


  }
}


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



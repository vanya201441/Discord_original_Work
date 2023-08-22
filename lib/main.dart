import 'package:exzample_trener_ori/overlapping_panels.dart';
import 'package:exzample_trener_ori/registration/sign_or_login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ButtonProvider(),
      child: MaterialApp(
        home: const MyHomePage(title: "Flutter Demo"),
      ),
    );

    // return MaterialApp(
    //   title: 'Flutter Demo',
    //   theme: ThemeData(
    //     primarySwatch: Colors.blue,
    //   ),
    //   debugShowCheckedModeBanner: false,
    //   home: const MyHomePage(title: 'Flutter Demo Home Page'),
    // );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  int currentIndex = 0;

  Offset footerOffset = const Offset(0, 1);

  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final buttonProvider = Provider.of<ButtonProvider>(context);

    return Scaffold(
      body: Stack(
        children: [
          OverlappingPanels(
            left: Builder(builder: (context) {
              return LeftPage(
                  currentIndex: currentIndex,
                  onButtonPressed: (index) {
                    setState(() {
                      currentIndex = index;
                    });
                  });
            }),
            // right: Builder(
            //   builder: (context) => const RightPage(),
            // ),
            main: Builder(
              builder: (context) {
                return MainPage(
                  currentIndex: currentIndex,
                );
              },
            ),

            onSideChange: (RevealSide side) {
              if (side == RevealSide.left) {
                buttonProvider.onButtonPressed(0);
              } else {
                buttonProvider.onButtonPressed(1);
              }
            },

            // onSideChange: (RevealSide side) {
            //   if (side == RevealSide.left) {
            //     _animationController.forward();
            //   } else {
            //     _animationController.reverse();
            //   }
            // },
          ),
        ],
      ),
    );
  }
}

class ButtonProvider extends ChangeNotifier {
  int _selectedIndex = 0;
  bool _isFullScreen = false;

  int get selectedIndex => _selectedIndex;

  bool get isFullScreen => _isFullScreen;

  void onButtonPressed(int index) {
    _selectedIndex = index;
    _isFullScreen = true;
    notifyListeners();
  }

  void exitFullScreen() {
    _isFullScreen = false;
    notifyListeners();
  }
}

class MainPage extends StatefulWidget {
  final int currentIndex;

  const MainPage({
    Key? key,
    required this.currentIndex,
  }) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<Widget> scaffoldList = [
    RegistrationPage(),
    RestaurantApp(),
    Scaffold(),
  ];

  @override
  Widget build(BuildContext context) {
    final buttonProvider = Provider.of<ButtonProvider>(context);

    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: buttonProvider._isFullScreen
            ? scaffoldList[widget.currentIndex]
            : IndexedStack(
                index: widget.currentIndex,
                children: scaffoldList,
              ),
      ),
    );
  }
}

class LeftPage extends StatefulWidget {
  final int currentIndex;
  final void Function(int) onButtonPressed;

  const LeftPage(
      {Key? key, required this.currentIndex, required this.onButtonPressed})
      : super(key: key);

  @override
  State<LeftPage> createState() => _LeftPageState();
}

class _LeftPageState extends State<LeftPage> {
  int selectedIndex = 0;
  bool isPressed = false;
  bool buttonPressed = false;

  @override
  Widget build(BuildContext context) {
    final buttonProvider = Provider.of<ButtonProvider>(context);
    int selectedIndex = buttonProvider.selectedIndex;

    return Scaffold(
      backgroundColor: Color(0xFF2B2D31),
      body: Container(
        color: Color(0xFF2B2D31),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Row(

            //children: [

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 40, left: 32),
                  child: CircleAvatar(
                    radius: 27,
                    backgroundColor: Colors.white24,
                    child: Icon(
                      Icons.person,
                      size: 37,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16, bottom: 40, left: 32),
                  child: Text(
                    "Ivan Spiridonov",
                    style: TextStyle(
                        color: Colors.white, fontSize: 27, fontFamily: "Lato"),
                  ),
                ),
                Divider(
                  color: Color(0xFFD1D1D1),
                  height: 8,
                ),
              ],
            ),

            //],
            //),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 16,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(padding: EdgeInsets.only(top: 48)),
                          drawerList(
                            Icons.app_registration,
                            "Registration",
                            0,
                            buttonProvider.selectedIndex,
                          ),
                          Padding(padding: EdgeInsets.only(top: 16)),
                          drawerList(Icons.search, "Search", 1,
                              buttonProvider.selectedIndex),
                          Padding(padding: EdgeInsets.only(top: 16)),
                          drawerList(Icons.favorite, "Favorite", 2,
                              buttonProvider.selectedIndex),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 56,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget drawerList(IconData icon, String text, int index, int selectedIndex) {
    final buttonProvider = Provider.of<ButtonProvider>(context);
    bool isSelected = (widget.currentIndex == index);

    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      height: 60,
      decoration: BoxDecoration(
        color: (widget.currentIndex == index)
            ? Color(0xFF404249)
            : Color(0xFF2B2D31),
        borderRadius: BorderRadius.circular(10),
      ),
      child: MaterialButton(
        onPressed: () {
          // setState(() {
          //
          //   Provider.of<ButtonProvider>(context, listen: false).onButtonPressed(index);
          //
          //   // selectedIndex = index;
          //
          // });

          if (isSelected && buttonProvider._isFullScreen) {
            buttonProvider.exitFullScreen();
          } else {
            widget.onButtonPressed(index);
          }
        },

        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : Colors.white54,
              size: 33,
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              text,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.white54,
                fontFamily: "Lato",
                fontSize: 20,
              ),
            ),
          ],
        ),
        //),
      ),
    );
  }
}

class RestaurantApp extends StatefulWidget {
  @override
  _RestaurantAppState createState() => _RestaurantAppState();
}

class _RestaurantAppState extends State<RestaurantApp> {
  final List<String> _items = [
    'Пицца'.toUpperCase(),
    'Бургер'.toUpperCase(),
    'Салат'.toUpperCase(),
    'Стейк'.toUpperCase(),
    'Паста'.toUpperCase(),
    'Роллы'.toUpperCase(),
    'Десерт'.toUpperCase(),
    'Напитки'.toUpperCase(),
    'Большой набор'.toUpperCase(),
    'Маленький набор'.toUpperCase(),
    'Завтраки'.toUpperCase(),
    'Скидки'.toUpperCase(),
    'New'.toUpperCase(),
  ];

  List<String> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _filteredItems = _items;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFF192236),
        appBar: AppBar(
          backgroundColor: Color(0xFF17203A),
          title: Text('Поиск блюда'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildSearchBox(),
              SizedBox(height: 16.0),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF22384B),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.2),
                      width: 2,
                    ),
                  ),
                  child: ListView.builder(
                    itemCount: _filteredItems.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(
                          _filteredItems[index],
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DishDetailPage(
                                dishName: _filteredItems[index],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBox() {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF22384B),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Введите название блюда',
          prefixIcon: Icon(Icons.search, color: Colors.white),
          border: InputBorder.none,
          filled: true,
        ),
        style: TextStyle(color: Colors.white),
        onChanged: (String value) {
          setState(() {
            _filteredItems = _items
                .where((item) =>
                    value.split(' ').every((word) =>
                        item.toLowerCase().contains(word.toLowerCase())) ||
                    item.toLowerCase().startsWith(
                          value.toLowerCase().replaceAll(' ', ''),
                        ))
                .toList();
          });
        },
      ),
    );
  }
}

class DishDetailPage extends StatelessWidget {
  final String dishName;

  const DishDetailPage({Key? key, required this.dishName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(dishName),
      ),
      body: Center(
        child: Text('Здесь будет информация о блюде $dishName'),
      ),
    );
  }
}

// body: Container(
//
//
//
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//
//
//                   Row(
//                     children:[
//
//
//                       Padding(
//                         padding: EdgeInsets.only(top: 30, bottom: 30, left: 15),
//                         child: CircleAvatar(
//                           radius: 18,
//                           backgroundColor: Colors.white24,
//                           child: Icon(Icons.person,
//                             size: 20,
//                             color: Colors.white,
//                           ),
//
//                         ),
//                       ),
//
//
//                       Padding(
//
//                         padding: EdgeInsets.only(top: 30, bottom: 30, left: 15),
//                         child: Text("Ivan Spiridonov",style:
//                         TextStyle(color: Colors.white, fontSize: 16,),),
//                       ),
//
//
//
//
//                     ],
//
//                   ),
//
//
//
//                     Expanded(
//                        child:
//                        Material(
//                            color: Color(0xFF17203A),
//                         child:
//                         ListView(
//                           children: [
//
//                              Padding(
//                               padding: EdgeInsets.only(
//                                   top: 3, left: 16, right: 16),
//                               child: Text(
//                                 'Main'.toUpperCase(),
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 20,
//                                     color: Colors.white70),
//                               ),
//
//
//                             ),
//
//                             Divider(
//                               color: Colors.white24,
//                               height: 8,
//                             ),
//
//
//
//
//                             // MaterialButton(
//                             //   onPressed: (){
//                             //     setState(() {
//                             //       _buttonPressed[0] = true;
//                             //           // selectedIndex = 0;
//                             //           // widget.onPageSelected(selectedIndex);
//                             //     });
//                             //   },
//                             //
//                             //   child: ListTile(
//                             //     leading: const Icon(Icons.home, color: Colors.white),
//                             //     horizontalTitleGap: 0,
//                             //     title: Text('page1', style: TextStyle(color: Colors.white),),
//                             //
//                             //
//                             //
//                             //   ),
//                             //   color: _buttonPressed[0] ? Colors.blue : Color(0xFF17203A),
//                             //
//                             // ),
//                             //
//                             // Divider(
//                             //   color: Colors.white24,
//                             //   height: 8,
//                             // ),
//                             //
//                             // MaterialButton(
//                             //
//                             //   onPressed: () {
//                             //     _buttonPressed[1] = true;
//                             //   },
//                             //
//                             //   child: ListTile(
//                             //       leading: const Icon(Icons.search, color: Colors.white),
//                             //       horizontalTitleGap: 0,
//                             //       title: Text('page2', style: TextStyle(color: Colors.white),),
//                             //
//                             //
//                             //   ),
//                             //   color: _buttonPressed[1] ? Colors.blue : Color(0xFF17203A),
//                             // ),
//                             //
//                             //
//                             // Divider(
//                             //   color: Colors.white24,
//                             //   height: 8,
//                             // ),
//                             //
//                             //
//                             //
//                             // MaterialButton(
//                             //   onPressed: () {
//                             //     _buttonPressed[2] = true;
//                             //   },
//                             //   child: ListTile(
//                             //       leading: const Icon(Icons.help, color: Colors.white),
//                             //       horizontalTitleGap: 0,
//                             //       title: Text('page3', style: TextStyle(color: Colors.white),),
//                             //
//                             //   ),
//                             //   color: _buttonPressed[2] ? Colors.blue : Color(0xFF17203A),
//                             // ),
//
//
//                             // Column(
//                             //   crossAxisAlignment: CrossAxisAlignment.start,
//                             //   children: [
//                             //     drawerList(Icons.home, "page1", 0,),
//                             //     drawerList(Icons.search, "page2", 1,),
//                             //     drawerList(Icons.help, "page3", 2,),
//                             //   ],
//                             // )
//
//
//
//





class Exzample extends StatefulWidget {
  const Exzample({super.key});

  @override
  State<Exzample> createState() => _ExzampleState();
}

class _ExzampleState extends State<Exzample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}


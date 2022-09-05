import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rare_royals_in_corporated/views/cart.dart';
import 'package:rare_royals_in_corporated/views/home_page.dart';
import 'package:rare_royals_in_corporated/views/profile.dart';
import 'package:rare_royals_in_corporated/views/wist_list.dart';

import '../helper.dart';


class TabScreen extends StatefulWidget {
  const TabScreen({Key key}) : super(key: key);

  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int _currentIndex = 0;

  Future<bool> _onBackPressed() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Are you sure?'),
            content: Text('You are going to exit the application!!'),
            actions: <Widget>[
              FlatButton(
                child: Text('NO'),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              FlatButton(
                child: Text('YES'),
                onPressed: () {
                  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                },
              ),
            ],
          );
        });
  }
  final List<Widget> _children = [
    HomePage(),
    Cart(),
    WishList(),
    Profile()
  ];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: _onBackPressed,
      child: Scaffold(

          body: _children[_currentIndex],


          bottomNavigationBar:  BottomNavigationBar(
              elevation: 10,
              currentIndex: _currentIndex,
              onTap: (int index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              type: BottomNavigationBarType.fixed,
              backgroundColor: color1,
              unselectedItemColor: Colors.white,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  // backgroundColor: white,
                  icon: new Icon(Icons.home_outlined,),
                  title: new Text('Home',style: TextStyle(fontSize: 13,color: Colors.white),),
                ),
                BottomNavigationBarItem(

                  icon: new Icon(Icons.shopping_cart_outlined),
                  title: new Text('Cart',style: TextStyle(fontSize: 13,color: Colors.white),),
                ),
                BottomNavigationBarItem(

                    icon: Icon(Icons.favorite_border),
                    title: Text('WishList',style: TextStyle(fontSize: 13,color: Colors.white),)),
                BottomNavigationBarItem(

                    icon: Icon(Icons.person_outline),
                    title: Text('Profile',style: TextStyle(fontSize: 13,color: Colors.white),)),
              ]
          )
      ),
    );
  }
}

import 'package:flutter/services.dart';
import 'package:test1_app/fragments/news_fragment.dart';
import 'package:test1_app/fragments/schedule_fragment.dart';
import 'package:test1_app/fragments/book_fragment.dart';
import 'package:test1_app/fragments/teacher_fragment.dart';
import 'package:test1_app/fragments/about_fragment.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}
//-------------------------icons----------------------------
class News {
  News._();
  static const _kFontFam = 'News';
  static const IconData doc = const IconData(0xe800, fontFamily: _kFontFam);
}

class Calendar {
  Calendar._();
  static const _kFontFam = 'Calendar';
  static const IconData calendar = const IconData(0xe801, fontFamily: _kFontFam);
}

class Book {
  Book._();
  static const _kFontFam = 'Book';
  static const IconData book = const IconData(0xe828, fontFamily: _kFontFam);
}

//------------------------icon-------------------------------


class HomePage extends StatefulWidget {
  final drawerItems = [
    new DrawerItem("Новости", News.doc),
    new DrawerItem("Расписание", Calendar.calendar),
    new DrawerItem("Зачётная книжка", Book.book),
    new DrawerItem("Преподаватели", Book.book),
    new DrawerItem("Об университете", Book.book),
    new DrawerItem("Выход", Book.book)
  ];

  @override
  State<StatefulWidget> createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  int _selectedDrawerIndex = 0;
  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return new NewsFragment();
      case 1:
        return new ScheduleFragment();
      case 2:
        return new BookFragment();
      case 3:
        return new TeacherFragment();
      case 4:
        return new AboutFragment();  
      case 5:
        return SystemNavigator.pop();  
      default:
        return new Text("Error");
    }
  }
  
  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    Navigator.of(context).pop(); // close the drawer
  }

  @override
  Widget build(BuildContext context) {
    var drawerOptions = <Widget>[];
    for (var i = 0; i < widget.drawerItems.length; i++) {
      var d = widget.drawerItems[i];
      drawerOptions.add(
        new ListTile(
          leading: new Icon(d.icon),
          title: new Text(d.title),
          selected: i == _selectedDrawerIndex,
          onTap: () => _onSelectItem(i),
        )
      );
    }

    return new Scaffold(
      appBar: new AppBar(
        // here we display the title corresponding to the fragment
        // you can instead choose to have a static title
        title: new Text(widget.drawerItems[_selectedDrawerIndex].title),
      ),
      drawer: new Drawer(
        child: new Column(
          children: <Widget>[
            new UserAccountsDrawerHeader(
                accountName: new Text("John Doe"), accountEmail: null),
            new Column(children: drawerOptions)
          ],
        ),
      ),
      body: _getDrawerItemWidget(_selectedDrawerIndex),
    );
  }
}
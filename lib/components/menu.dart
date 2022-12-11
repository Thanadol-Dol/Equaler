import 'package:flutter/material.dart';
import '../news_list_page.dart';
import '../select_category.dart';

class Menu extends StatelessWidget {
//Get parameter from menu_bar and go to Category/Thai/English page
//================== Initial Constructor =======================

  final String menuTitle;
  final List<String> parameter;
  final bool isCategoryPage;

  Menu(
      {required this.menuTitle,
      this.parameter = const ["country=th,gb,us", "language=en,th"],
      required this.isCategoryPage});
//==============================================================
  
  @override
  Widget build(BuildContext context) {
    return isCategoryPage
        ? ListTile( //If this part is navigate to select category page 
            title: Text(menuTitle.toUpperCase(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                )),
            onTap: () { //Go to SelectCategory
              Navigator.push( 
                context,
                MaterialPageRoute(
                  builder: (context) => SelectCategory(),
                ),
              );
            },
          )
        : ListTile(//If this part not navigate to select category page 
            title: Text(menuTitle.toUpperCase(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                )),
            onTap: () { //Go to NewsListPage
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewsListPage(
                      Header_Title: menuTitle, Parameter: parameter),
                ),
              );
            },
          );
  }
}

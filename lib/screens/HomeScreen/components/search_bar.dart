import 'package:flutter/material.dart';
import 'package:instant_dating/services/size_config.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.horizontal * 8),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        elevation: 8.0,
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(SizeConfig.horizontal * 2.8),
              child: Icon(
                Icons.search,
                size: 30.0,
                color: Colors.black,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(6.0),
                child: TextField(
                  decoration: InputDecoration.collapsed(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Search',
                    hintStyle: TextStyle(
                      fontSize: SizeConfig.horizontal * 4,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

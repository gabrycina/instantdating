import 'package:flutter/material.dart';
import 'package:instant_dating/screens/HomeScreen/components/custom_shape_clipper.dart';
import 'package:instant_dating/components/UsersList.dart';
import 'package:instant_dating/services/size_config.dart';
import 'package:instant_dating/screens/HomeScreen/components/choice_chip.dart';
import 'package:provider/provider.dart';
import 'package:instant_dating/services/user_repository.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({this.key});

  static final id = 'home_screen';
  final Key key;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double rating = 0.0;
  List<bool> radioButtons = [true, false, false, false];


  void _onChipTap(int value) {
    for (int i = 0; i < radioButtons.length; i++) {
      radioButtons[i] = false;
    }
    radioButtons[value] = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserRepository>(context).user;
    SizeConfig().init(context);

    return SafeArea(
      child: Scaffold(
        // backgroundColor: Color(0xFFececec),
        body: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Stack(
              children: <Widget>[
                ClipPath(
                  clipper: CustomShapeClipper(),
                  child: Container(
                    height: SizeConfig.horizontal * 60,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFFFF5864), Color(0xFFFD297B)],
                      ),
                    ),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding:
                              EdgeInsets.only(top: SizeConfig.vertical * 5),
                          child: Text(
                            'Dove vuoi fare colpo stasera?',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: SizeConfig.horizontal * 5,
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(top: SizeConfig.vertical * 4),
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  ChipChoice(
                                    icon: Icons.people,
                                    label: 'Vicino a te',
                                    isSelected: radioButtons[0],
                                    onTap: () => _onChipTap(0),
                                  ),
                                  ChipChoice(
                                    icon: Icons.streetview,
                                    label: 'Università',
                                    isSelected: radioButtons[1],
                                    onTap: () => _onChipTap(1),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: SizeConfig.vertical * 2,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: SizeConfig.horizontal * 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    ChipChoice(
                                      icon: Icons.local_pizza,
                                      label: 'Pub',
                                      isSelected: radioButtons[2],
                                      onTap: () => _onChipTap(2),
                                    ),
                                    ChipChoice(
                                      icon: Icons.school,
                                      label: 'Scuola',
                                      isSelected: radioButtons[3],
                                      onTap: () => _onChipTap(3),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            UsersList(
              loggedUserId: user.uid,
              user: user,
            ),
          ],
        ),
      ),
    );
  }
}

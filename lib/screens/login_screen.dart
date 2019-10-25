import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:instant_dating/services/size_config.dart';
import 'HomeScreen/components/login_social_button.dart';
import 'package:instant_dating/services/user_repository.dart';
import 'package:provider/provider.dart';


class LoginScreen extends StatefulWidget {
  static final String id = 'welcome_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  UserRepository userRepository = UserRepository();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SizedBox.expand(
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              CachedNetworkImage(
                imageUrl:
                    'https://images.pexels.com/photos/1787156/pexels-photo-1787156.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
                fit: BoxFit.cover,
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    colors: [Color(0xBB698FB4), Color(0xBA304D67)],
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    'Real Life\nInterest Dating',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: SizeConfig.horizontal * 15,
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(bottom: 15.0),
                        child: Text(
                          'Find, match and chat with new people',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: SizeConfig.horizontal * 5,
                          ),
                        ),
                      ),

                      //Google
                      LoginSocialButton(
                        color: Color(0xFFE15340),
                        label: 'Login With Google',
                        onTap: () => Provider.of<UserRepository>(context).signInWithGoogle()
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

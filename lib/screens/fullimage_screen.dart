import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:instant_dating/services/size_config.dart';

class FullImageScreen extends StatelessWidget {
  FullImageScreen({this.image, this.heroTag});

  final image;
  final heroTag;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: SizedBox.expand(
              child: Hero(
                tag: heroTag,
                child: CachedNetworkImage(
                  imageUrl: image,
                  imageBuilder: (context, imageProvider) {
                    return Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Positioned(
            top: SizeConfig.vertical * 2,
            left: 0,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: SizeConfig.horizontal * 10,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

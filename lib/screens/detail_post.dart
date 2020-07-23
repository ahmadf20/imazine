import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:imazine/widgets/load_image.dart';
import 'package:html/dom.dart' as dom;

class DetailScreen extends StatelessWidget {
  final String title;
  final String content;
  final String image;

  DetailScreen(
      {Key key, @required this.title, @required this.content, this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: Get.back,
        ),
      ),
      backgroundColor: Color(0xFF121212),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Hero(tag: image, child: loadImage(image)),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      title,
                      style: TextStyle(fontSize: 24.0, color: Colors.white),
                    ),
                  ),
                  Html(
                    data: """${content}""",
                    //Optional parameters:
                    padding: EdgeInsets.all(8.0),
                    linkStyle: const TextStyle(
                      color: Colors.redAccent,
                      decorationColor: Colors.redAccent,
                      decoration: TextDecoration.underline,
                    ),

                    //Must have useRichText set to false for this to work
                    customRender: (node, children) {
                      if (node is dom.Element) {
                        switch (node.localName) {
                          case "br":
                            return Column(children: children);
                        }
                      }
                      return null;
                    },

                    customTextAlign: (dom.Node node) {
                      if (node is dom.Element) {
                        switch (node.className) {
                          default:
                            return TextAlign.left;
                        }
                      }
                      return null;
                    },
                    customTextStyle: (dom.Node node, TextStyle baseStyle) {
                      if (node is dom.Element) {
                        switch (node.localName) {
                          default:
                            return baseStyle.merge(
                              TextStyle(
                                height: 1.5,
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            );
                        }
                      }
                      return baseStyle;
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

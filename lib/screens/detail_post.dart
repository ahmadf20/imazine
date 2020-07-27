import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:imazine/models/post.dart';
import 'package:imazine/widgets/load_image.dart';
import 'package:html/dom.dart' as dom;
import 'package:intl/intl.dart';

class DetailScreen extends StatelessWidget {
  final Post item;

  DetailScreen({Key key, @required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              leading: FlatButton(
                shape: CircleBorder(),
                child: Icon(Icons.arrow_back),
                onPressed: Get.back,
              ),
              expandedHeight: 300.0,
              floating: false,
              pinned: true,
              elevation: 0,
              backgroundColor: Get.theme.canvasColor,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: false,
                background: loadImage(item.jetpackFeaturedMediaUrl),
              ),
            ),
          ];
        },
        body: ListView(
          padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                HtmlUnescape().convert(item.title.rendered),
                style: Get.textTheme.headline5.copyWith(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                DateFormat('d MMMM yyyy', 'id_ID').format(item.modified),
                style: Get.textTheme.subtitle1.copyWith(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Html(
              data: """${item.content.rendered}""",
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
                          fontSize: 14,
                        ),
                      );
                  }
                }
                return baseStyle;
              },
            )
          ],
        ),
      ),
    );
  }
}

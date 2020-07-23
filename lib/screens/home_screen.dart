import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:imazine/models/post.dart';
import 'package:imazine/screens/detail_post.dart';
import 'package:imazine/utils/logger_utils.dart';
import 'package:imazine/utils/post_utils.dart';
import 'package:imazine/widgets/load_image.dart';
import 'package:imazine/widgets/loading_indicator.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final int topPost = 5;
  List<Post> listPost;

  Future fetchPost() async {
    try {
      await getPost(1, 15, hasEnvelope: false).then((res) {
        if (res is List<Post>) {
          listPost = res;
        } else if (res is Response) {
          listPost = postFromJson(res.data['body']);
        }
        if (mounted) setState(() {});
      });
    } catch (e) {
      logger.e(e);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchPost();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'IMAZINE',
          style: TextStyle(
            fontFamily: 'strasua',
            fontSize: 20,
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: listPost == null
          ? loadingIndicator()
          : SafeArea(
              child: ListView(
                padding: EdgeInsets.only(top: 0),
                children: <Widget>[
                  buildHeader('Latest Post'),
                  buildLatestPosts(),
                  buildHeader('All Posts'),
                  buildPosts(),
                ],
              ),
            ),
    );
  }

  ListView buildPosts() {
    return ListView.separated(
      separatorBuilder: (context, index) {
        return Divider(
          height: 50,
        );
      },
      padding: EdgeInsets.fromLTRB(20, 25, 25, 25),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: listPost.sublist(topPost, 15).length,
      itemBuilder: (context, index) {
        Post item = listPost[index + topPost];

        return GestureDetector(
          onTap: () {
            Get.to(DetailScreen(
              title: HtmlUnescape().convert(item.title.rendered),
              content: item.content.rendered,
              image: item.jetpackFeaturedMediaUrl,
            ));
          },
          child: Row(
            children: <Widget>[
              Container(
                width: 75,
                height: 75,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: Hero(
                      tag: item.jetpackFeaturedMediaUrl,
                      child: loadImage(
                        item.jetpackFeaturedMediaUrl,
                        isShowLoading: false,
                      ),
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              SizedBox(width: 25),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      item.embedded.wpTerm[0][0].name.toUpperCase(),
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 11,
                        letterSpacing: 2,
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: double.maxFinite,
                      child: Text(
                        HtmlUnescape().convert(item.title.rendered),
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          height: 1.5,
                        ),
                        maxLines: 3,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 25),
            ],
          ),
        );
      },
    );
  }

  AspectRatio buildLatestPosts() {
    return AspectRatio(
      aspectRatio: 1.15,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: topPost,
        itemBuilder: (context, index) {
          Post item = listPost[index];
          return GestureDetector(
            onTap: () {
              Get.to(DetailScreen(
                title: HtmlUnescape().convert(item.title.rendered),
                content: item.content.rendered,
                image: item.jetpackFeaturedMediaUrl,
              ));
            },
            child: Container(
              width: 250,
              margin: EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 5,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Hero(
                        tag: item.jetpackFeaturedMediaUrl,
                        child: loadImage(
                          item.jetpackFeaturedMediaUrl,
                          isShowLoading: false,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    item.embedded.wpTerm[0][0].name.toUpperCase(),
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 11,
                      letterSpacing: 2,
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    flex: 2,
                    child: Container(
                      width: double.maxFinite,
                      child: Text(
                        HtmlUnescape().convert(item.title.rendered),
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                        maxLines: 3,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Padding buildHeader(String text) {
    return Padding(
      padding: EdgeInsets.fromLTRB(30, 15, 30, 0),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 18,
          color: Colors.blueGrey[800],
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

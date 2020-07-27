import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:imazine/main.dart';
import 'package:imazine/models/category.dart';
import 'package:imazine/models/post.dart';
import 'package:imazine/screens/detail_post.dart';
import 'package:imazine/screens/post_by_category.dart';
import 'package:imazine/utils/category_utils.dart';
import 'package:imazine/utils/logger_utils.dart';
import 'package:imazine/utils/post_utils.dart';
import 'package:imazine/widgets/load_image.dart';
import 'package:imazine/widgets/loading_indicator.dart';
import 'package:imazine/widgets/post_card.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final int topPost = 5;

  int totalPage = 1;
  int currentPage = 1;

  bool isLoading = false;

  List<Post> listPost;
  List<Category> listCategory;

  ScrollController controller;

  Future fetchPost() async {
    try {
      isLoading = true;
      if (mounted) setState(() {});
      await getPost(currentPage, 15, hasEnvelope: true).then((res) {
        if (res is List<Post>) {
          listPost = res;
        } else if (res is Response) {
          if (listPost == null) {
            listPost = postFromJson(res.data['body']);
          } else {
            listPost.addAll(postFromJson(res.data['body']));
          }
          print(currentPage);
          totalPage = res.data['headers']['X-WP-TotalPages'];
          currentPage++;
        }

        if (mounted) setState(() {});
      });
    } catch (e) {
      logger.e(e);
    } finally {
      isLoading = false;
      if (mounted) setState(() {});
    }
  }

  Future fetchCategory() async {
    try {
      await getCategories(1, 30).then((res) {
        if (res is List<Category>) {
          listCategory = res;
        } else if (res is Response) {
          listCategory = categoriesFromJson(res.data['body']);
        }
        if (mounted) setState(() {});
      });
    } catch (e) {
      logger.e(e);
    }
  }

  void _scrollListener() {
    // print(controller.position.extentAfter);
    print(currentPage);
    if (controller.position.extentAfter < 250 &&
        currentPage <= totalPage &&
        !isLoading) {
      fetchPost();
    }
  }

  @override
  void initState() {
    super.initState();
    fetchPost();
    fetchCategory();

    controller = ScrollController()..addListener(_scrollListener);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: <Widget>[
          FlatButton(
            shape: CircleBorder(),
            child: FaIcon(
              isDarkMode
                  ? FontAwesomeIcons.toggleOn
                  : FontAwesomeIcons.toggleOff,
            ),
            onPressed: () {
              Get.changeThemeMode(
                  isDarkMode ? ThemeMode.light : ThemeMode.dark);
              isDarkMode = !isDarkMode;
              setState(() {});
            },
          ),
        ],
        title: Text(
          'IMAZINE',
          style: TextStyle(
            fontFamily: 'strasua',
            fontSize: 20,
            color: Colors.amber,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: listPost == null
          ? loadingIndicator()
          : SafeArea(
              child: ListView(
                controller: controller,
                padding: EdgeInsets.only(top: 0),
                children: <Widget>[
                  buildCategories(),
                  buildHeader('Latest Post'),
                  buildLatestPosts(),
                  buildHeader('All Posts'),
                  buildPosts(),
                  Container(
                    padding: EdgeInsets.only(bottom: 15),
                    child: isLoading ? loadingIndicator() : Container(),
                  ),
                ],
              ),
            ),
    );
  }

  Widget buildCategories() {
    return Container(
      height: 60,
      child: listCategory == null
          ? loadingIndicator()
          : ListView.separated(
              separatorBuilder: (context, index) {
                return SizedBox(width: 15);
              },
              padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
              itemCount: listCategory?.length ?? 0,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                Category item = listCategory[index];

                return FlatButton(
                  onPressed: () => Get.to(PostByCategoryScreen(category: item)),
                  child: Text(
                    '${item.name.toUpperCase()} (${item.count})',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.5,
                    ),
                  ),
                  color: Colors.black12,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                );
              },
            ),
    );
  }

  ListView buildPosts() {
    return ListView.separated(
      separatorBuilder: (context, index) {
        return Divider(height: 50);
      },
      padding: EdgeInsets.fromLTRB(20, 25, 25, 25),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: listPost.sublist(topPost).length,
      itemBuilder: (context, index) {
        Post item = listPost[index + topPost];

        return PostCard(item: item);
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
              Get.to(DetailScreen(item: item));
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
          color: Get.theme.accentColor,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

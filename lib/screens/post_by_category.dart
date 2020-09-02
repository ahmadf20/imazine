import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:imazine/models/category.dart';
import 'package:imazine/models/post.dart';
import 'package:imazine/utils/logger.dart';
import 'package:imazine/services/post.dart';
import 'package:imazine/widgets/loading_indicator.dart';
import 'package:imazine/widgets/post_card.dart';

class PostByCategoryScreen extends StatefulWidget {
  final Category category;
  PostByCategoryScreen({Key key, this.category}) : super(key: key);

  @override
  _PostByCategoryScreenState createState() => _PostByCategoryScreenState();
}

class _PostByCategoryScreenState extends State<PostByCategoryScreen> {
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
      await getPost(currentPage, 10,
              hasEnvelope: true, categoryId: widget.category.id)
          .then((res) {
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
        backgroundColor: Get.theme.canvasColor,
        elevation: 1,
        leading: BackButton(
          color: Get.theme.primaryColor,
        ),
        title: Text(
          '${widget.category.name}',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 20,
            color: Get.theme.textTheme.headline1.color,
            fontWeight: FontWeight.w600,
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

  Widget buildPosts() {
    return ListView.separated(
      separatorBuilder: (context, index) {
        return Divider(height: 50);
      },
      padding: EdgeInsets.fromLTRB(20, 25, 25, 25),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: listPost.length,
      itemBuilder: (context, index) {
        Post item = listPost[index];

        return PostCard(item: item);
      },
    );
  }
}

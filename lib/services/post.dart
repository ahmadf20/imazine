import 'package:dio/dio.dart';
import 'package:imazine/models/post.dart';
import 'package:imazine/utils/config.dart';

import '../utils/logger.dart';

Future getPost(
  int page,
  int perPage, {
  bool hasEnvelope = false,
  int categoryId,
}) async {
  Map<String, dynamic> params = {
    '_embed': null,
    'page': page,
    'per_page': perPage,
    'categories': categoryId,
  };

  if (hasEnvelope) params['_envelope'] = 1;

  try {
    Response response = await Dio().get(
      '$baseUrl/posts',
      queryParameters: params,
      options: Options(contentType: 'application/json'),
    );

    logger.v(response.data);

    if (response.statusCode == 200) {
      if (hasEnvelope) return response;
      return postFromJson(response.data);
    }
    logger.v(response);
  } catch (e) {
    logger.e(e);
  }
}

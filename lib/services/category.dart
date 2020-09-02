import 'package:dio/dio.dart';
import 'package:imazine/models/category.dart';
import 'package:imazine/utils/config.dart';

import '../utils/logger.dart';

Future getCategories(
  int page,
  int perPage, {
  bool hasEnvelope = false,
}) async {
  Map<String, dynamic> params = {
    'page': page,
    'per_page': perPage,
  };

  if (hasEnvelope) params['_envelope'] = 1;

  try {
    Response response = await Dio().get(
      '$baseUrl/categories',
      queryParameters: params,
      options: Options(contentType: 'application/json'),
    );

    logger.v(response.data);

    if (response.statusCode == 200) {
      if (hasEnvelope) return response;
      return categoriesFromJson(response.data);
    }
    logger.v(response);
  } catch (e) {
    logger.e(e);
  }
}

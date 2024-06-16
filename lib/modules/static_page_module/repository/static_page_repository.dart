import 'dart:convert';

import 'package:flutter_boilerplate/modules/static_page_module/model/static_page_response_model.dart';
import 'package:flutter_boilerplate/src/core/network/dio_base_service.dart';

import '../../../src/core/app_utils/export.dart';

class StaticPageRepository extends DioBaseService {
  static StaticPageRepository? _instance;

  static StaticPageRepository get instance =>
      _instance ??= StaticPageRepository._();

  StaticPageRepository._()
      : super(Environment().config.apiHost + Environment().config.path);
  final String getStaticPageDataEndPoint = 'static-page/get';

  Future<StaticPageResponseModel> getStaticPageDataApiCall(pageType) async {
    try {
      final response =
          await get(getStaticPageDataEndPoint, queryParams: {"type": pageType});
      return StaticPageResponseModel.fromJson(jsonDecode(response));
    } catch (e) {
      return Future.error(e);
    }
  }
}

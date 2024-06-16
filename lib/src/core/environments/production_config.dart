import 'package:flutter_boilerplate/src/core/environments/base_config.dart';
class ProductionConfig implements BaseConfig {
  @override
  String get apiHost => 'https://xxx.xxx.in';

  @override
  String get path => '/mobile-app-apis/';

  @override
  String get awsPath => 'aws-bucket/';

  @override
  String get serviceProvider => 'service-provider-apis/';


}
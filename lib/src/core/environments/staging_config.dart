import 'package:flutter_boilerplate/src/core/environments/base_config.dart';

class StagingConfig implements BaseConfig {
  @override
  String get apiHost => 'https://xxxx.xxxx.in';

  @override
  String get path => '/mobile-app-apis/';

  @override
  String get awsPath => 'aws-bucket/';

  @override
  String get serviceProvider => 'service-provider-apis';
}

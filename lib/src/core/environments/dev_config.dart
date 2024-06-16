
import 'package:flutter_boilerplate/src/core/environments/base_config.dart';

class DevConfig implements BaseConfig {

  //example
  @override
  String get apiHost => 'https://localhost/';

  //example
  @override
  String get path => 'frontend-apis/';
  @override
  String get awsPath => 'aws-bucket/';
  @override
  String get serviceProvider => 'service-provider-apis';


}

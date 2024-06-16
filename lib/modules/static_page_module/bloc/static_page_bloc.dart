import 'package:flutter_boilerplate/modules/static_page_module/bloc/state.dart';
import 'package:flutter_boilerplate/modules/static_page_module/repository/static_page_repository.dart';

import '../../../src/core/app_utils/export.dart';

class StaticPageBloc extends Cubit<CommonPageState> {
  StaticPageBloc() : super(InitPageState());

  getDataApiCall(type) {
    emit(InitPageState());
    EasyLoading.show();
    StaticPageRepository.instance.getStaticPageDataApiCall(type).then((value) {
      emit(StaticPageState(value.data?.message ?? ""));
      EasyLoading.dismiss();
    }).onError((error, stackTrace) {
      emit(StaticPageState(AppStrings.noDataFoundString));
      EasyLoading.showToast(error.toString());
      EasyLoading.dismiss();
    });
  }
}

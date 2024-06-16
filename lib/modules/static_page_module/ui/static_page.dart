import 'package:flutter/services.dart';
import 'package:flutter_boilerplate/modules/static_page_module/bloc/state.dart';
import 'package:flutter_boilerplate/modules/static_page_module/bloc/static_page_bloc.dart';
import 'package:flutter_boilerplate/src/core/connectivity/api_constants.dart';
import 'package:flutter_html/flutter_html.dart';
import '../../../src/core/app_utils/export.dart';
import 'dart:io';

class StaticPageScreen extends StatefulWidget {
  var arguments;

  StaticPageScreen(this.arguments);

  @override
  State<StaticPageScreen> createState() => _StaticPageScreenState();
}

class _StaticPageScreenState extends State<StaticPageScreen> {
  String pageName = '';

  @override
  void initState() {
    _getArguments();
    super.initState();
  }

  _getArguments() {
    if (widget.arguments != null) {
      pageName = widget.arguments[AppConstant.pageTypeKey];
      if (pageName == AppStrings.tcString) {
        BlocProvider.of<StaticPageBloc>(context)
            .getDataApiCall(ApiConstants.termsAndConditonsType);
      } else if (pageName == AppStrings.cancellationPolicyString) {
        BlocProvider.of<StaticPageBloc>(context)
            .getDataApiCall(ApiConstants.cancellationPolicyType);
      } else if (pageName == AppStrings.privacyPolicyString) {
        BlocProvider.of<StaticPageBloc>(context)
            .getDataApiCall(ApiConstants.privacyPolicyType);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
        value: SystemUiOverlayStyle(statusBarColor: AppColors.primaryColor),
        child: SafeArea(
          bottom: Platform.isIOS ? false : true,
          child: Scaffold(
            body: Container(
              child: Column(
                children: [
                  _appBar(),
                  Expanded(
                      child: Padding(
                    padding: EdgeInsets.all(AppSizes.largePadding),
                    child: BlocBuilder<StaticPageBloc, CommonPageState>(
                      builder: (context, state) {
                        if (state is StaticPageState) {
                          return SingleChildScrollView(
                            child: Html(
                              data: state.data ?? "",
                             onLinkTap: (data,e,element) async {
                               if (await canLaunch(data??"")) {
                               await launch(data??"");
                               } else {
                               throw 'Could not launch $data';
                               }
                             },
                             /* style: {
                                '#': Style(
                                    // display: Display.inline,
                                    width: Width(300.0),
                                    color: AppTheme
                                        .lightTheme.textTheme.bodyMedium!.color,
                                    fontSize: FontSize(AppTheme.lightTheme
                                            .textTheme.bodyMedium!.fontSize ??
                                        20),
                                    fontWeight: AppTheme.lightTheme.textTheme
                                        .bodyMedium!.fontWeight,
                                    fontFamily: AppTheme.lightTheme.textTheme
                                        .bodyMedium!.fontFamily)
                              },*/
                            ),
                          );
                        }
                        return Center(child: CircularProgressIndicator());
                      },
                    ),
                  ))
                ],
              ),
            ),
          ),
        ));
  }

  _appBar() {
    return CommonBackgroundScreen(AppSizes.getHeight(context, percent: 11),
        child: Padding(
          padding: EdgeInsets.only(top: 20.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: CustomAppBar(
              backgroundColor: AppColors.primaryColor,
              centerTitle: true,
              leadingWidth: 30.0,
              titleText: pageName,
            ),
          ),
        ));
  }
}

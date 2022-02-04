import 'package:flutter/material.dart';
import 'package:itex_soft_qualityapp/SystemImports.dart';
import 'package:itex_soft_qualityapp/Utility/ResourceKeys.dart';
import 'package:itex_soft_qualityapp/Widgets/ErrorPage.dart';
import 'package:itex_soft_qualityapp/assets/Themes/SystemTheme.dart';
import 'package:provider/provider.dart';
class LoadingContainer extends StatelessWidget {
  int IntiteStatus = 0;

  LoadingContainer({required this.IntiteStatus});

  Widget Loadding() => Container(
    height: getScreenHeight() / 1.5,
    child: Center(
      child: CircularProgressIndicator(),
    ),
  );

  Widget ErrorLoading(PersonalCase) => ErrorPage(
      ActionName: PersonalCase.GetLable(ResourceKey.Loading),
      MessageError: PersonalCase.GetLable(ResourceKey.ErrorWhileLoadingData),
      DetailError: PersonalCase.GetLable(ResourceKey.InvalidNetWorkConnection));

  Widget GetMessage(String Header,String Message) => ErrorPage(
      ActionName: Header,
      MessageError: Message,);

  @override
  Widget build(BuildContext context) {
    final PersonalCase = Provider.of<PersonalProvider>(context);
    switch (IntiteStatus) {
      case -1:
        return ErrorLoading(PersonalCase);
      case 0:
        return Loadding();
      case -2:
        return GetMessage(
            PersonalCase.GetLable(ResourceKey.WarrningMessage),
            PersonalCase.GetLable(ResourceKey.PleaseCompleteQualityTestBeforeStart)
        );
      default:
        return Container();
    }
  }
}
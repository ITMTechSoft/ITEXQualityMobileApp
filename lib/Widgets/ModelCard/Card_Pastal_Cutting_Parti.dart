import 'package:flutter/material.dart';
import 'package:itex_soft_qualityapp/Models/Pastal_Cutting_Parti.dart';
import 'package:itex_soft_qualityapp/ProviderCase/SubCaseProvider.dart';
import 'package:itex_soft_qualityapp/SystemImports.dart';
import 'package:itex_soft_qualityapp/Widgets/AlertMessage.dart';
import 'package:itex_soft_qualityapp/assets/Component/DateTimeComponent.dart';
import 'package:itex_soft_qualityapp/assets/Component/List_Items.dart';
import 'package:itex_soft_qualityapp/assets/Themes/SystemTheme.dart';

class Card_Pastal_Cutting_Parti extends StatefulWidget {
  Pastal_Cutting_PartiBLL Card_Item;
  Function(Pastal_Cutting_PartiBLL Item) OnTap;

  Card_Pastal_Cutting_Parti({this.Card_Item, this.OnTap});

  @override
  _Card_Pastal_Cutting_PartiState createState() =>
      _Card_Pastal_Cutting_PartiState();
}

class _Card_Pastal_Cutting_PartiState extends State<Card_Pastal_Cutting_Parti> {
  TextEditingController Fabric_Type = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final PersonalCase = Provider.of<PersonalProvider>(context);
    final CaseProvider = Provider.of<SubCaseProvider>(context);

    bool IsSelectedItem = CaseProvider.SelectedPastal != null
        ? (CaseProvider.SelectedPastal.Id == widget.Card_Item.Id)
        : false;
    return Card(
      shadowColor: ArgonColors.black,
      elevation: 10,
      color:
          IsSelectedItem ? ArgonColors.SelectedColor : ArgonColors.NormalColor,
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
        child: InkWell(
          onTap: () {
            widget.OnTap(widget.Card_Item);
          },
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                        child: LableTitle(
                            '${PersonalCase.GetLable(ResourceKey.Fabric_Type)}')),
                    Expanded(
                        child: LableTitle(widget.Card_Item.Fabric_Type,
                            color: ArgonColors.text, IsCenter: true)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                        child: LableTitle(
                            '${PersonalCase.GetLable(ResourceKey.Pastel_Laying)}')),
                    Expanded(
                        child: LableDateTime(widget.Card_Item.Pastel_Laying,
                            color: ArgonColors.text, IsCenter: true)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                        child: LableTitle(
                            '${PersonalCase.GetLable(ResourceKey.CuttingDate)}')),
                    Expanded(
                        child: LableDateTime(widget.Card_Item.CuttingDate,
                            color: ArgonColors.text, IsCenter: true)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                        child: LableTitle(
                            '${PersonalCase.GetLable(ResourceKey.FabricRestingTime)}')),
                    Expanded(
                        child: LableTitle(widget.Card_Item.FabricRestingTime,
                            color: ArgonColors.text, IsCenter: true)),
                  ],
                ),
              ]),
        ),
      ),
    );
  }
}

class Pastal_NewSample extends StatefulWidget {
  @override
  _Pastal_NewSampleState createState() => _Pastal_NewSampleState();
}

class _Pastal_NewSampleState extends State<Pastal_NewSample> {
  int IntiteStatus = 0;

  Pastal_Cutting_PartiBLL Card_Item = new Pastal_Cutting_PartiBLL();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController Fabric_Type = new TextEditingController();
  final TextEditingController FabricRestingTime = new TextEditingController();

  String ErrorMesage;
  bool _isLoading;

  @override
  Widget build(BuildContext context) {
    final PersonalCase = Provider.of<PersonalProvider>(context);
    final CaseProvider = Provider.of<SubCaseProvider>(context);

    return Scaffold(
        appBar: DetailBar(
            Title: PersonalCase.SelectedTest.Test_Name,
            PersonalCase: PersonalCase,
            OnTap: () {
              Navigator.pop(context);
            },
            context: context),
        body: ListView(
          children: [
            Column(children: [
              ListTile(
                title: HeaderTitle(
                    PersonalCase.GetLable(ResourceKey.CreateTasnifSample),
                    color: ArgonColors.header,
                    FontSize: ArgonSize.Header2),
                dense: true,
                selected: true,
              ),
              SizedBox(height: ArgonSize.Padding3),
              Center(
                child: GestureDetector(
                  onTap: () async {
                    if (_formKey.currentState.validate()) {
                      Card_Item.Fabric_Type = Fabric_Type.text;
                      Card_Item.FabricRestingTime = FabricRestingTime.text;
                      Card_Item.Order_id = PersonalCase.SelectedOrder.Order_Id;
                      Card_Item.Create_Employee_Id =
                          PersonalCase.GetCurrentUser().Id;
                      bool CheckItem = await Card_Item.SaveEntity();
                      if (CheckItem) {
                        CaseProvider.ReloadAction();
                        Navigator.pop(context, "Okay");
                      } else
                        AlertPopupDialog(
                            context,
                            PersonalCase.GetLable(ResourceKey.SaveMessage),
                            PersonalCase.GetLable(ResourceKey.SaveErrorMessage),
                            ActionLable:
                                PersonalCase.GetLable(ResourceKey.Okay));
                      print('working ');
                      setState(() {
                        _isLoading = true;
                      });
                      //   Navigator.pop(context);
                    } else
                      print("Not Working");
                    setState(() {
                      _isLoading = false;
                    });
                  },
                  child: ButtonWithNumber(
                      buttonHegiht: ArgonSize.HeightMedium,
                      buttonWidth: getScreenWidth() / 2.5,
                      textSize: ArgonSize.Header4,
                      text: PersonalCase.GetLable(ResourceKey.AddNew),
                      btnBgColor: ArgonColors.primary,
                      textColor: Colors.white),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                  child: LableTitle(PersonalCase.GetLable(
                                      ResourceKey.Fabric_Type))),
                              Expanded(
                                flex: 2,
                                child: Standard_Input(
                                  controller: Fabric_Type,
                                  placeholder: PersonalCase.GetLable(
                                      ResourceKey.Fabric_Type),
                                  errorMessage: PersonalCase.GetLable(
                                      ResourceKey.MandatoryFields),
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                  child: LableTitle(PersonalCase.GetLable(
                                      ResourceKey.FabricRestingTime))),
                              Expanded(
                                flex: 2,
                                child: Standard_Input(
                                  controller: FabricRestingTime,
                                  placeholder: PersonalCase.GetLable(
                                      ResourceKey.FabricRestingTime),
                                  errorMessage: PersonalCase.GetLable(
                                      ResourceKey.MandatoryFields),
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                  child: LableTitle(PersonalCase.GetLable(
                                      ResourceKey.CuttingDate))),
                              Expanded(
                                flex: 2,
                                child:
                                //
                                // DateTimePicker(
                                //     SelectedDate: (DateTime SelectedTime) {
                                //   setState(() {
                                //     Card_Item.CuttingDate = SelectedTime;
                                //   });
                                // }),

                                DateTimePicker(

                                  dateMode: DateMode.normal,
                                  dateChoices :DateChoices.dateAndTime
                                    ),
                              )
                            ],
                          ),
                          SizedBox(height: ArgonSize.Padding3),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                  child: LableTitle(PersonalCase.GetLable(
                                      ResourceKey.Pastel_Laying))),
                              Expanded(
                                flex: 2,
                                child: DateTimePicker(

                                    dateMode: DateMode.normal,
                                    dateChoices :DateChoices.dateAndTime
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: ArgonSize.Padding3),
                          _isLoading == true
                              ? CircularProgressIndicator()
                              : Container(),
                          ErrorMesage == null
                              ? Container()
                              : Text(
                                  "${ErrorMesage}",
                                  style: TextStyle(
                                      color: Colors.redAccent,
                                      fontWeight: FontWeight.bold,
                                      fontSize: ArgonSize.Header4),
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ]),
          ],
        ));
  }
}

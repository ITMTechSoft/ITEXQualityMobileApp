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

                SizedBox(height:ArgonSize.Padding1),
                Row(
                  children:[
                    Expanded(
                      flex:2,
                      child:
                      CustomButton(
                          textSize:ArgonSize.Header4,
                          width: getScreenWidth()*0.5,
                          height:ArgonSize.HeightSmall1,
                          value: PersonalCase.GetLable(ResourceKey.Edit),
                          backGroundColor: ArgonColors.myGreen,
                          function: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Pastal_NewSample()));
                          }),
                    ),
                    SizedBox(width:ArgonSize.Padding3),
                    Expanded(
                      flex:2,
                      child:
                      CustomButton(
                          textSize:ArgonSize.Header4,
                          width: getScreenWidth()*0.5,
                          height:ArgonSize.HeightSmall1,
                          value: PersonalCase.GetLable(ResourceKey.Delete),
                          backGroundColor: ArgonColors.myRed,
                          function: () {
                            AlertPopupDialogWithAction(context,
                                textButton1Color: Colors.red,
                                title: PersonalCase.GetLable(
                                    ResourceKey.WarrningMessage),
                                Children: <Widget>[
                                  LableTitle(PersonalCase.GetLable(
                                      ResourceKey.DeleteItemConfirmation),FontSize: ArgonSize.Header4)
                                ],
                                FirstActionLable:
                                PersonalCase.GetLable(ResourceKey.Delete),
                                SecondActionLable:
                                PersonalCase.GetLable(ResourceKey.Cancel),
                                OnFirstAction: () async {

                                });
                          }),
                    )
                  ]
                )
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
                child:

                    CustomButton(
                  textSize: ArgonSize.Header4,
                  width: getScreenWidth() * 0.5,
                  height: ArgonSize.HeightSmall1,
                  value: PersonalCase.GetLable(ResourceKey.AddNew),
                  backGroundColor: ArgonColors.primary,
                  function: () async {
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
                                      ResourceKey.Fabric_Type),
                                      FontSize :ArgonSize.Header5)),
                              Expanded(
                                flex: 2,
                                child: Standard_Input(
                                  activeValidation : true,
                                  controller: Fabric_Type,
                                  placeholder: PersonalCase.GetLable(
                                      ResourceKey.Fabric_Type),
                                  errorMessage: PersonalCase.GetLable(
                                      ResourceKey.MandatoryFields),
                                    lengthErrorMessage:PersonalCase.GetLable(
                                        ResourceKey.lengthErrorMessage),
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
                                      ResourceKey.FabricRestingTime),
                                      FontSize :ArgonSize.Header5)),
                              Expanded(
                                flex: 2,
                                child: Standard_Input(
                                  activeValidation : true,

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
                                      ResourceKey.CuttingDate),
                                      FontSize :ArgonSize.Header5)),
                              Expanded(
                                flex: 2,
                                child: DateTimePicker(
                                    SelectedDateFunction:
                                        (DateTime SelectedTime) {
                                      Card_Item.CuttingDate = SelectedTime;
                                    },
                                    dateMode: DateMode.cupertino,
                                    dateChoices: DateChoices.dateAndTime),
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
                                      ResourceKey.Pastel_Laying),
                                      FontSize :ArgonSize.Header5)),
                              Expanded(
                                flex: 2,
                                child: DateTimePicker(
                                    SelectedDateFunction:
                                        (DateTime SelectedTime) {
                                      Card_Item.Pastel_Laying = SelectedTime;
                                    },
                                    dateMode: DateMode.normal,
                                    dateChoices: DateChoices.dateAndTime),
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

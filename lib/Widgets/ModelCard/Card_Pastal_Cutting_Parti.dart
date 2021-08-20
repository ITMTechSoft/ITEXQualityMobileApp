import 'package:flutter/material.dart';
import 'package:itex_soft_qualityapp/Models/Pastal_Cutting_Parti.dart';
import 'package:itex_soft_qualityapp/ProviderCase/SubCaseProvider.dart';
import 'package:itex_soft_qualityapp/SystemImports.dart';
import 'package:itex_soft_qualityapp/Widgets/AlertMessage.dart';
import 'package:itex_soft_qualityapp/assets/Component/DateTimeComponent.dart';
import 'package:itex_soft_qualityapp/assets/Themes/SystemTheme.dart';

class Card_Pastal_Cutting_Parti extends StatefulWidget {
  Pastal_Cutting_PartiBLL Card_Item;
  Function(Pastal_Cutting_PartiBLL Item) OnTap;

  Card_Pastal_Cutting_Parti({required this.Card_Item, required this.OnTap});

  @override
  _Card_Pastal_Cutting_PartiState createState() =>
      _Card_Pastal_Cutting_PartiState();
}

class _Card_Pastal_Cutting_PartiState extends State<Card_Pastal_Cutting_Parti> {
  TextEditingController Fabric_Type = new TextEditingController();

  /// DELETE ITEM FUNCTION
  Future<bool?> DeleteItem() async {
    bool Criteria = await widget.Card_Item.DeleteEntity();

    print(widget.Card_Item.Id);
    if (Criteria != null) {
      // IntiteStatus = 1;
      return Criteria;
    } else {
      // IntiteStatus = -1;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final PersonalCase = Provider.of<PersonalProvider>(context);
    final CaseProvider = Provider.of<SubCaseProvider>(context);

    bool IsSelectedItem = CaseProvider.SelectedPastal != null
        ? (CaseProvider.SelectedPastal!.Id == widget.Card_Item.Id)
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
                            '${PersonalCase.GetLable(ResourceKey.Fabric_Type)}',
                            FontSize: ArgonSize.Header4)),
                    Expanded(
                        child: LableTitle(widget.Card_Item.Fabric_Type??'',
                            color: ArgonColors.text,
                            IsCenter: true,
                            FontSize: ArgonSize.Header4)),
                  ],
                ),
                SizedBox(height: ArgonSize.Padding6),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                        child: LableTitle(
                            '${PersonalCase.GetLable(ResourceKey.FabricRestingTime)}',
                            FontSize: ArgonSize.Header4)),
                    Expanded(
                        child: LableTitle(widget.Card_Item.FabricRestingTime??'',
                            color: ArgonColors.text,
                            IsCenter: true,
                            FontSize: ArgonSize.Header4)),
                  ],
                ),
                SizedBox(height: ArgonSize.Padding6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: LableTitle(
                          '${PersonalCase.GetLable(ResourceKey.Pastel_Laying)}',
                          FontSize: ArgonSize.Header4),
                    ),
                    Expanded(
                        child: LableDateTime(widget.Card_Item.Pastel_Laying!,
                            color: ArgonColors.text,
                            IsCenter: true,
                            FontSize: ArgonSize.Header4)),
                  ],
                ),
                SizedBox(height: ArgonSize.Padding6),


                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                        child: LableTitle(
                            '${PersonalCase.GetLable(ResourceKey.CuttingDate)}',
                            FontSize: ArgonSize.Header4)),
                    Expanded(
                        child: LableDateTime(widget.Card_Item.CuttingDate!,
                            color: ArgonColors.text,
                            IsCenter: true,
                            FontSize: ArgonSize.Header4)),
                  ],
                ),

                SizedBox(height: ArgonSize.Padding1),
                Row(children: [
                  Expanded(flex: 1, child: Container()),
                  Expanded(
                    flex: 2,
                    child: CustomButton(
                        textSize: ArgonSize.Header4,
                        width: getScreenWidth() * 0.5,
                        height: ArgonSize.HeightSmall1,
                        value: PersonalCase.GetLable(ResourceKey.Edit),
                        backGroundColor: ArgonColors.myGreen,
                        function: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Pastal_NewSample(
                                      Card_Item: widget.Card_Item)));
                        }),
                  ),
                  SizedBox(width: ArgonSize.Padding3),
                  Expanded(
                    flex: 2,
                    child: CustomButton(
                        textSize: ArgonSize.Header4,
                        width: getScreenWidth() * 0.5,
                        height: ArgonSize.HeightSmall1,
                        value: PersonalCase.GetLable(ResourceKey.Delete),
                        backGroundColor: ArgonColors.myRed,
                        function: () {
                          AlertPopupDialogWithAction(context :context,
                              textButton1Color: Colors.red,
                              title: PersonalCase.GetLable(
                                  ResourceKey.WarrningMessage),
                              Children: <Widget>[
                                LableTitle(
                                    PersonalCase.GetLable(
                                        ResourceKey.DeleteItemConfirmation),
                                    FontSize: ArgonSize.Header4)
                              ],
                              FirstActionLable:
                              PersonalCase.GetLable(ResourceKey.Delete),
                              SecondActionLable:
                              PersonalCase.GetLable(ResourceKey.Cancel),
                              OnFirstAction: () async {
                                bool? result = await DeleteItem();
                                if (result != null) Navigator.of(context).pop();
                                if (result == true) {
                                  final snackBar = SnackBar(
                                      content: Text("Deleted Successfuly"));

                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                } else {
                                  final snackBar =
                                  SnackBar(content: Text("SomeThing wrong"));

                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                              });
                        }),
                  ),
                  Expanded(flex: 1, child: Container()),
                ])
              ]),
        ),
      ),
    );
  }
}

class Pastal_NewSample extends StatefulWidget {
  Pastal_Cutting_PartiBLL? Card_Item ;

  Pastal_NewSample({Key? key,  this.Card_Item}) : super(key: key);

  @override
  _Pastal_NewSampleState createState() => _Pastal_NewSampleState();
}

class _Pastal_NewSampleState extends State<Pastal_NewSample> {
  int IntiteStatus = 0;

  // Pastal_Cutting_PartiBLL Card_Item = new Pastal_Cutting_PartiBLL();
  final _formKey = GlobalKey<FormState>();

  String? ErrorMesage;
  bool? _isLoading;

  @override
  Widget build(BuildContext context) {
    final PersonalCase = Provider.of<PersonalProvider>(context);
    final CaseProvider = Provider.of<SubCaseProvider>(context);
    widget.Card_Item =widget.Card_Item ==null? new   Pastal_Cutting_PartiBLL() :widget.Card_Item ;

    final TextEditingController Fabric_Type = new TextEditingController(
        text: widget.Card_Item != null ? widget.Card_Item!.Fabric_Type : '');
    final TextEditingController FabricRestingTime = new TextEditingController(
        text:
        widget.Card_Item != null ? widget.Card_Item!.FabricRestingTime : '');
    return Scaffold(
        appBar: DetailBar(
            Title: PersonalCase.SelectedTest!.Test_Name??'',
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
                child: CustomButton(
                  textSize: ArgonSize.Header4,
                  width: getScreenWidth() * 0.5,
                  height: ArgonSize.HeightSmall1,
                  value: PersonalCase.GetLable(widget.Card_Item!.CuttingDate!= null
                      ? ResourceKey.Edit
                      : ResourceKey.AddNew),
                  backGroundColor: ArgonColors.primary,
                  function: () async {
                    if (_formKey.currentState!.validate()) {
                      widget.Card_Item!.Fabric_Type = Fabric_Type.text;
                      widget.Card_Item!.FabricRestingTime = FabricRestingTime.text;
                      widget. Card_Item!.Order_id = PersonalCase.SelectedOrder!.Order_Id;
                      widget.Card_Item!.Create_Employee_Id =
                          PersonalCase.GetCurrentUser().Id;
                      widget. Card_Item!.CuttingDate=   widget. Card_Item!.CuttingDate!=null? widget.Card_Item!.CuttingDate:DateTime.now();

                      widget.  Card_Item!.Pastel_Laying= widget.Card_Item!.Pastel_Laying!=null? widget.Card_Item!.Pastel_Laying:DateTime.now();
                      bool CheckItem = await widget.Card_Item!.SaveEntity();
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
                                  child: LableTitle(
                                      PersonalCase.GetLable(
                                          ResourceKey.Fabric_Type),
                                      FontSize: ArgonSize.Header5)),
                              Expanded(
                                flex: 2,
                                child: Standard_Input(
                                  activeValidation: true,
                                  controller: Fabric_Type,
                                  placeholder: PersonalCase.GetLable(
                                      ResourceKey.Fabric_Type),
                                  errorMessage: PersonalCase.GetLable(
                                      ResourceKey.MandatoryFields),
                                  lengthErrorMessage: PersonalCase.GetLable(
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
                                  child: LableTitle(
                                      PersonalCase.GetLable(
                                          ResourceKey.FabricRestingTime),
                                      FontSize: ArgonSize.Header5)),
                              Expanded(
                                flex: 2,
                                child: Standard_Input(
                                  activeValidation: true,
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
                                  child: LableTitle(
                                      PersonalCase.GetLable(
                                          ResourceKey.Pastel_Laying),
                                      FontSize: ArgonSize.Header5)),
                              Expanded(
                                flex: 2,
                                child: DateTimePicker(
                                    SelectedDate: widget.Card_Item!.Pastel_Laying != null
                                        ? widget.Card_Item!.Pastel_Laying
                                        : DateTime.now(),

                                //  SelectedDate:  DateTime.now(),
                                    SelectedDateFunction:
                                        (DateTime SelectedTime) {
                                    widget.Card_Item!.Pastel_Laying = SelectedTime;
                                    },
                                    dateMode: DateMode.normal,
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
                                  child: LableTitle(
                                      PersonalCase.GetLable(
                                          ResourceKey.CuttingDate),
                                      FontSize: ArgonSize.Header5)),
                              Expanded(
                                flex: 2,
                                child: DateTimePicker(
                                    SelectedDate: widget.Card_Item!.CuttingDate!= null
                                        ? widget.Card_Item!.CuttingDate
                                        : DateTime.now(),
                                  // SelectedDate:  DateTime.now(),

                                    SelectedDateFunction:
                                        (DateTime SelectedTime) {
                                   widget.Card_Item!.CuttingDate = SelectedTime ;

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

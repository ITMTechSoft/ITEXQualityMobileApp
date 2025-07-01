import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:itex_soft_qualityapp/SystemImports.dart';
import 'package:itex_soft_qualityapp/Utility/DatePickerField.dart';

final TextEditingController _sampleTicketController = TextEditingController();
final TextEditingController _controlResultController = TextEditingController();
final TextEditingController _descriptionController = TextEditingController();
final TextEditingController _fabric_TopNoController = TextEditingController();
final TextEditingController _SampleNoController = TextEditingController();

Future<void> showSampleDialog({
  required BuildContext context,
  String? initialSampleTicket,
  String? initialControlResult,
  String? initialDescription,
  DateTime? initialApprovalDate,
  String? initialFabric_TopNo,
  int? initialSampleNo,
  int? initialStatus,
  PersonalProvider? PersonalCase,
  required void Function(
    String sampleTicket,
    String controlResult,
    String description,
    DateTime? approvalDate,
    String? fabric_TopNo,
    int? SampleNo,
    int? Status,
  )
  onSave,
}) async {
  _sampleTicketController.text = initialSampleTicket ?? '';
  _controlResultController.text = initialControlResult ?? '';
  _descriptionController.text = initialDescription ?? '';
  _fabric_TopNoController.text = initialFabric_TopNo ?? '';
  _SampleNoController.text =
      initialSampleNo != null ? initialSampleNo.toString() : '1';
  DateTime? approvalDate = initialApprovalDate;

  String? rafNo = PersonalCase?.GetLable(ResourceKey.RafNo);
  String? controlResult = PersonalCase?.GetLable(ResourceKey.ControlResult);
  String? description = PersonalCase?.GetLable(ResourceKey.Description);
  String? save = PersonalCase?.GetLable(ResourceKey.Save);
  String? cancel = PersonalCase?.GetLable(ResourceKey.Cancel);
  String? checkSample = PersonalCase?.GetLable(ResourceKey.Check_Sample);
  String? GelisDate = PersonalCase?.GetLable(ResourceKey.GelisDate);
  String? FabricTipi = PersonalCase?.GetLable(ResourceKey.FabricTipi);
  String? WachingCount = PersonalCase?.GetLable(ResourceKey.WachingCount);
  String? CloseSample = PersonalCase?.GetLable(ResourceKey.CloseSample);

  await showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text(checkSample ?? 'Sample Control'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: _sampleTicketController,
                    decoration: InputDecoration(labelText: rafNo),
                  ),
                  TextField(
                    controller: _SampleNoController,
                    decoration: InputDecoration(labelText: WachingCount),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ], // ← only digits allowed
                  ),
                  DatePickerField(
                    selectedDate: approvalDate,
                    label: GelisDate ?? "",
                    onDateSelected: (picked) {
                      setState(() {
                        approvalDate = picked;
                      });
                    },
                  ),
                  TextField(
                    controller: _fabric_TopNoController,
                    decoration: InputDecoration(labelText: FabricTipi),
                    maxLines: 2,
                  ),
                  TextField(
                    controller: _controlResultController,
                    decoration: InputDecoration(labelText: controlResult),
                    maxLines: 2,
                  ),
                  TextField(
                    controller: _descriptionController,
                    decoration: InputDecoration(labelText: description),
                    maxLines: 4,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(CloseSample!),
                      Switch(
                        value: initialStatus == 1,
                        onChanged: (val) {
                          setState(() {
                            initialStatus = val ? 1 : 0;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(cancel ?? 'Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  onSave(
                    _sampleTicketController.text,
                    _controlResultController.text,
                    _descriptionController.text,
                    approvalDate,
                    _fabric_TopNoController.text,
                    int.tryParse(_SampleNoController.text),
                    initialStatus,
                  );
                  Navigator.of(context).pop();
                },
                child: Text(save ?? 'Save'),
              ),
            ],
          );
        },
      );
    },
  );
}

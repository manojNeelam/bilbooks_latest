import 'package:auto_route/auto_route.dart';
import 'package:billbooks_app/core/app_constants.dart';
import 'package:billbooks_app/core/theme/app_fonts.dart';
import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:billbooks_app/core/widgets/input_switch_widget.dart';
import 'package:billbooks_app/core/widgets/new_inputview_widget.dart';
import 'package:billbooks_app/features/clients/presentation/widgets/new_client_section_widget.dart';
import 'package:billbooks_app/features/more/settings/domain/usecase/update_preference_column_usecase.dart';
import 'package:flutter/material.dart';

@RoutePage()
class UserColumnSettingsPage extends StatefulWidget {
  final UpdatePreferenceColumnReqParams? updatePreferenceColumnReqParams;
  final Function(UpdatePreferenceColumnReqParams) onupdateColumnSettings;
  const UserColumnSettingsPage({
    super.key,
    required this.onupdateColumnSettings,
    required this.updatePreferenceColumnReqParams,
  });

  @override
  State<UserColumnSettingsPage> createState() => _UserColumnSettingsPageState();
}

class _UserColumnSettingsPageState extends State<UserColumnSettingsPage> {
  TextEditingController itemsController = TextEditingController();
  TextEditingController unitsController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  bool dateBool = false,
      timeBool = false,
      customBool = false,
      hideUnits = false,
      hideRates = false,
      hideAmount = false;

  void updateUI() {
    setState(() {});
  }

  @override
  void initState() {
    _populateData();
    super.initState();
  }

  void _populateData() {
    final preference = widget.updatePreferenceColumnReqParams;
    if (preference != null) {
      dateBool = preference.columnDate;
      timeBool = preference.columnTime;
      customBool = preference.columnCustom;
      hideUnits = preference.hideColumnQty;
      hideAmount = preference.hideColumnAmount;
      hideRates = preference.hideColumnRate;
      itemsController.text = preference.columnItemsTitle;
      unitsController.text = preference.columnUnitsTitle;
      rateController.text = preference.columnRateTitle;
      amountController.text = preference.columnAmountTitle;
      updateUI();
    }
  }

  void updateColumnSettings() {
    widget.onupdateColumnSettings(UpdatePreferenceColumnReqParams(
        columnAmountOther: "",
        columnAmountTitle: amountController.text,
        columnCustom: customBool,
        columnCustomTitle: "",
        columnDate: dateBool,
        columnItemsOther: "",
        columnItemsTitle: itemsController.text,
        columnRateOther: "",
        columnRateTitle: rateController.text,
        columnTime: timeBool,
        columnUnitsOther: "",
        columnUnitsTitle: unitsController.text,
        hideColumnAmount: hideAmount,
        hideColumnQty: hideUnits,
        hideColumnRate: hideRates));

    /*context.read<OrganizationBloc>().add(UpdatePreferenceColumnDetailsEvent(
          preferenceUpdateReqParams: UpdatePreferenceColumnReqParams(
              columnAmountOther: "",
              columnAmountTitle: amountController.text,
              columnCustom: customBool,
              columnCustomTitle: "",
              columnDate: dateBool,
              columnItemsOther: "",
              columnItemsTitle: itemsController.text,
              columnRateOther: "",
              columnRateTitle: rateController.text,
              columnTime: timeBool,
              columnUnitsOther: "",
              columnUnitsTitle: unitsController.text,
              hideColumnAmount: hideAmount,
              hideColumnQty: hideUnits,
              hideColumnRate: hideRates),
        ));*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: AppConstants.getAppBarDivider,
        title: const Text("Column Settings"),
        actions: [
          TextButton(
              onPressed: () {
                updateColumnSettings();
                Navigator.of(context).maybePop();
              },
              child: Text(
                "Done",
                style: AppFonts.regularStyle(color: AppPallete.blueColor),
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          color: AppPallete.kF2F2F2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionTitle(title: "Column Tiles"),
              NewInputViewWidget(
                  isRequired: false,
                  title: "Items",
                  hintText: "Items",
                  controller: itemsController),
              NewInputViewWidget(
                  isRequired: false,
                  title: "Units",
                  hintText: "Units",
                  controller: unitsController),
              NewInputViewWidget(
                  isRequired: false,
                  title: "Rate",
                  hintText: "Rate",
                  controller: rateController),
              NewInputViewWidget(
                  isRequired: false,
                  title: "Amount",
                  hintText: "Amount",
                  inputAction: TextInputAction.done,
                  controller: amountController),
              const SectionTitle(title: "Choose Custom Fields"),
              InPutSwitchWidget(
                  title: "Date",
                  context: context,
                  isRecurringOn: dateBool,
                  onChanged: (val) {
                    dateBool = val;
                    updateUI();
                  },
                  showDivider: true),
              InPutSwitchWidget(
                  title: "Time",
                  context: context,
                  isRecurringOn: timeBool,
                  onChanged: (val) {
                    timeBool = val;
                    updateUI();
                  },
                  showDivider: true),
              InPutSwitchWidget(
                  title: "Custom",
                  context: context,
                  isRecurringOn: customBool,
                  onChanged: (val) {
                    customBool = val;
                    updateUI();
                  },
                  showDivider: false),
              const SectionTitle(title: "Choose Column To Hide"),
              InPutSwitchWidget(
                  title: "Hide units",
                  context: context,
                  isRecurringOn: hideUnits,
                  onChanged: (val) {
                    hideUnits = val;
                    updateUI();
                  },
                  showDivider: true),
              InPutSwitchWidget(
                  title: "Hide rates",
                  context: context,
                  isRecurringOn: hideRates,
                  onChanged: (val) {
                    hideRates = val;
                    updateUI();
                  },
                  showDivider: true),
              InPutSwitchWidget(
                  title: "Hide amount",
                  context: context,
                  isRecurringOn: hideAmount,
                  onChanged: (val) {
                    hideAmount = val;
                    updateUI();
                  },
                  showDivider: false),
            ],
          ),
        ),
      ),
    );
  }
}

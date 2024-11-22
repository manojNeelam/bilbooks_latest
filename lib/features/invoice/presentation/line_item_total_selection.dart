import 'package:auto_route/auto_route.dart';
import 'package:billbooks_app/core/app_constants.dart';
import 'package:billbooks_app/core/theme/app_fonts.dart';
import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:billbooks_app/core/widgets/input_discount_view.dart';
import 'package:billbooks_app/core/widgets/new_inputview_widget.dart';
import 'package:flutter/material.dart';

@RoutePage()
class LineItemTotalSelectionPage extends StatefulWidget {
  final Function(ShippingDiscountModel) callBack;
  final ShippingDiscountModel shippingDiscountModel;
  const LineItemTotalSelectionPage({
    super.key,
    required this.shippingDiscountModel,
    required this.callBack,
  });

  @override
  State<LineItemTotalSelectionPage> createState() =>
      _LineItemTotalSelectionPageState();
}

class _LineItemTotalSelectionPageState
    extends State<LineItemTotalSelectionPage> {
  TextEditingController discountController = TextEditingController();
  TextEditingController shippingController = TextEditingController();

  bool isPercentage = true;

  @override
  void initState() {
    _populateData();
    super.initState();
  }

  void _populateData() {
    discountController.text = widget.shippingDiscountModel.discount;
    shippingController.text = widget.shippingDiscountModel.shipping;
    isPercentage = widget.shippingDiscountModel.isPercentage;
  }

  void _reRenderUI() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.kF2F2F2,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              AutoRouter.of(context).maybePop();
            },
            icon: const Icon(Icons.close)),
        title: const Text(
          "Total Selection",
        ),
        actions: [
          TextButton(
              onPressed: () {
                widget.callBack(ShippingDiscountModel(
                  discount: discountController.text,
                  shipping: shippingController.text,
                  isPercentage: isPercentage,
                ));
                AutoRouter.of(context).maybePop();
              },
              child: Text(
                "Save",
                style: AppFonts.regularStyle(color: AppPallete.blueColor),
              ))
        ],
      ),
      body: Column(
        children: [
          AppConstants.sizeBoxHeight10,
          InputDiscountWidget(
              controller: discountController,
              isPercentage: isPercentage,
              callback: () {
                isPercentage = !isPercentage;
                _reRenderUI();
              }),
          AppConstants.sizeBoxHeight10,
          NewInputViewWidget(
              title: "Shipping",
              hintText: "Shipping",
              isRequired: false,
              showDivider: false,
              controller: shippingController),
        ],
      ),
    );
  }
}

class ShippingDiscountModel {
  final String discount;
  final String shipping;
  final bool isPercentage;
  ShippingDiscountModel({
    required this.discount,
    required this.shipping,
    required this.isPercentage,
  });
}

import 'package:billbooks_app/core/theme/app_fonts.dart';
import 'package:billbooks_app/core/theme/app_pallete.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchBarWidget extends StatefulWidget {
  final String hintText;
  final Function(String)? onSubmitted;
  final Function()? dismissKeyboard;
  const SearchBarWidget(
      {super.key,
      required this.searchController,
      required this.hintText,
      required this.onSubmitted,
      required this.dismissKeyboard});

  final TextEditingController searchController;

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  bool isShowCancel = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      curve: Curves.easeIn,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      duration: const Duration(milliseconds: 2000),
      child: Row(
        children: [
          Expanded(
            child: CupertinoSearchTextField(
              // onChanged: (val) async {
              //   Future.delayed(const Duration(milliseconds: 250), () {
              //     if (widget.onSubmitted != null) {
              //       widget.onSubmitted!(val);
              //     }
              //   });
              // },
              style: AppFonts.regularStyle(),
              onSuffixTap: () {
                if (isShowCancel == true) {
                  isShowCancel = false;
                }
                widget.searchController.text = "";
                setState(() {});
                if (widget.onSubmitted != null) {
                  widget.onSubmitted!(widget.searchController.text);
                }
              },
              onTap: () {
                debugPrint("Tpaped");
                if (isShowCancel == false) {
                  isShowCancel = true;
                  setState(() {});
                }
              },
              placeholder: widget.hintText,
              controller: widget.searchController,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              prefixInsets: const EdgeInsets.only(left: 15),
              onSubmitted: (value) {
                if (widget.onSubmitted != null) {
                  widget.onSubmitted!(value);
                }
              },
            ),
          ),
          Offstage(
            offstage: !isShowCancel,
            child: TextButton(
                onPressed: () {
                  if (isShowCancel == true) {
                    isShowCancel = false;
                  }
                  if (widget.searchController.text.isNotEmpty) {
                    widget.searchController.text = "";
                    setState(() {});
                    if (widget.onSubmitted != null) {
                      widget.onSubmitted!(widget.searchController.text);
                    }
                  } else {
                    setState(() {});
                    if (widget.dismissKeyboard != null) {
                      widget.dismissKeyboard!();
                    }
                  }
                },
                child: Text(
                  "Cancel",
                  style: AppFonts.regularStyle(color: AppPallete.blueColor),
                )),
          )
        ],
      ),
    );
  }
}

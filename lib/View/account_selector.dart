import 'package:flutter_application_1/model/baby_account.dart';
import 'package:flutter_application_1/widget/account_selector_widget.dart';
import 'package:flutter/material.dart';

showAccountSelectorSheet({
  required BuildContext context,
  required var accountList,
  int initiallySelectedIndex = -1,
  required Function(int index) tapCallback,
  bool hideSheetOnItemTap = false,
  Color selectedRadioColor = Colors.green,
  bool showAddAccountOption = false,
  required Function addAccountTapCallback,
  String addAccountTitle = "",
  Color arrowColor = Colors.grey,
  Color backgroundColor = Colors.white,
  Color selectedTextColor = Colors.green,
  Color unselectedTextColor = const Color(0xFF424242),
  Color unselectedRadioColor = Colors.grey,
  bool isSheetDismissible = true,
}) {
  List<AccountWithSelectionBoolean> accountwithselectionList =
      setupAccountWithSelectionList(
    accountList,
    initiallySelectedIndex,
    addAccountTitle,
  );
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isDismissible: isSheetDismissible,
    isScrollControlled: true,
    builder: (context) {
      return SingleAccountSelectionWidget(
        accountwithselectionList: accountwithselectionList,
        initiallySelectedIndex: initiallySelectedIndex,
        tapCallback: tapCallback,
        hideSheetOnItemTap: hideSheetOnItemTap,
        selectedRadioColor: selectedRadioColor,
        showAddAccountOption: showAddAccountOption,
        addAccountTapCallback: addAccountTapCallback,
        arrowColor: arrowColor,
        backgroundColor: backgroundColor,
        selectedTextColor: selectedTextColor,
        unselectedTextColor: unselectedTextColor,
        unselectedRadioColor: unselectedRadioColor,
      );
    },
  );
}

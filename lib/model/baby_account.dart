import 'package:flutter_application_1/model/baby.dart';

class AccountWithSelectionBoolean {
  String title;
  Baby baby;
  bool selected;
  AccountWithSelectionBoolean({
    required this.title,
    required this.baby,
    required this.selected,
  });
}

List<AccountWithSelectionBoolean> setupAccountWithSelectionList(
  List<Baby> accountList,
  int initialySelectedElementIndex,
  String addAccountTitle,
) {
  List<AccountWithSelectionBoolean> actualList =
      <AccountWithSelectionBoolean>[];
  for (int i = 0; i < accountList.length; i++) {
    actualList.add(
      AccountWithSelectionBoolean(
        title: accountList[i].name,
        baby: accountList[i],
        selected: i == initialySelectedElementIndex ? true : false,
      ),
    );
  }
  actualList.add(
    AccountWithSelectionBoolean(
      title: "Add baby",
      baby: accountList[0],
      selected: false,
    ),
  );
  return actualList;
}

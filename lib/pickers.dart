import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';



class AndroidCurrencyDropdown extends StatelessWidget {
  final String selectedItem;
  final List<String> itemList;
  final ValueChanged<String> onChange;

  AndroidCurrencyDropdown({
    @required this.selectedItem, 
    @required this.itemList,
    @required this.onChange,
  });
  
  

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String item in itemList) {
      var newItem = DropdownMenuItem(
        child: Text(item),
        value: item,
      );
      dropdownItems.add(newItem);
    }

    return DropdownButton<String>(
      value: selectedItem,
      items: dropdownItems,
      onChanged: onChange,
    );
  }

}



class IosPicker extends StatelessWidget {
  final List<String> itemList;
  final ValueChanged<String> onChange;

  IosPicker({
    @required this.itemList, 
    @required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    List<Text> pickerItems = [];
    for (String item in itemList) {
      pickerItems.add(Text(item));
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      useMagnifier:true,
      magnification: 1.5,
      onSelectedItemChanged: (selectedIndex) {
        print(selectedIndex);
        String selectedValue = itemList[selectedIndex];
        print(selectedValue);

        // call onChange with extracted value
        onChange(selectedValue);
      },
      children: pickerItems,
    );
  }
}


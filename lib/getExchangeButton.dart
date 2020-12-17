import 'package:flutter/material.dart';


class GetExchangeWidget extends StatelessWidget {
  final String title;
  final Function onPressed;
  final double horizontalInset;

  const GetExchangeWidget({
    Key key,
    this.title,
    this.onPressed,
    this.horizontalInset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPressed,
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: ListTile(
          title: Text(title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),),
        ),
      ),
    );
  }
}

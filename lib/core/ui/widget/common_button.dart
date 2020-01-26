import 'package:flutter/material.dart';

const double DEFAULT_RADIUS = 2;
const double DEFAULT_PADDING = 15;

class CommonButton extends StatefulWidget {
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final double radiusValue;
  final double width;
  final Widget icon;
  final Text text;
  final double buttonPadding;

  CommonButton({
    Key key,
    @required this.onPressed,
    @required this.text,
    @required this.width,
    this.backgroundColor,
    this.textColor,
    this.buttonPadding,
    this.radiusValue,
    this.icon,
  }) : super(key: key);

  @override
  _CommonButtonState createState() => _CommonButtonState();
}

class _CommonButtonState extends State<CommonButton> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Container(
        margin: EdgeInsets.only(bottom: 5),
        width: widget.width ?? 270,
        child: FlatButton(
          padding: EdgeInsets.all(widget.buttonPadding ?? DEFAULT_PADDING),
          textColor: widget.textColor ?? Colors.white,
          color: widget.backgroundColor ?? Color(0xFF3360ff),
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(
                  widget.radiusValue ?? DEFAULT_RADIUS)),
          onPressed: widget.onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              widget.icon ?? SizedBox.shrink(),
              widget.icon != null
                  ? SizedBox(
                      width: 15,
                    )
                  : SizedBox.shrink(),
              widget.text ??
                  Text(
                    'Đăng nhập với facebook',
                    style: TextStyle(fontSize: 16),
                  )
            ],
          ),
        ),
      ),
    );
  }
}

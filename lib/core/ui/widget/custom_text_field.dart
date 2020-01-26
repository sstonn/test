import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:login_test/core/ui/styles/styles.dart';

// ignore: must_be_immutable
class CustomTextField extends StatefulWidget {
  final String hintText;
  final Function(String textValue) onTextChanged;
  final bool isPassword;
  final IconData icon;
  final double cornerRadius;
  final double width;
  TextEditingController textEditingController;

  CustomTextField(
      {Key key,
        @required this.hintText,
        @required this.icon,
        @required this.onTextChanged,
        @required this.isPassword,
        this.width,
        this.textEditingController,
        this.cornerRadius})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CustomTextFieldState();
  }
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;
  TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    widget.textEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      width: widget.width??MediaQuery.of(context).size.width*0.7,
      decoration: BoxDecoration(
        color: KColors.white,
        borderRadius: BorderRadius.circular(widget.cornerRadius ?? 10),
      ),
      child: Column(
        children: <Widget>[
          TextField(
            keyboardType: TextInputType.text,
            controller: widget.textEditingController ?? _textEditingController,
            obscureText: widget.isPassword ? _obscureText : false,
            style: TextStyle(
                fontFamily: Kfonts.PrimaryFontBold,
                fontSize: 17.0,
                color: KColors.black),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(
                  left: 14.0, bottom: 15, top: 15, right: 14),
              fillColor: Colors.transparent,
              hintText: widget.hintText,
              hintStyle: TextStyle(
                  fontFamily: Kfonts.TitleFont,
                  fontSize: 17.0,
                  color: KColors.hintTextColor),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: KColors.ColorPrimary,
                    style: BorderStyle.solid,
                    width: 2),
                borderRadius: BorderRadius.circular(widget.cornerRadius ?? 10),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: KColors.ColorBg,
                    style: BorderStyle.solid,
                    width: 2),
                borderRadius: BorderRadius.circular(widget.cornerRadius ?? 10),
              ),
              filled: true,
              prefixIcon: Icon(
                widget.icon,
                color: KColors.ColorPrimary,
                size: 22.0,
              ),
              suffixIcon: widget.isPassword == true
                  ? GestureDetector(
                onTap: _toggle,
                child: _obscureText == true
                    ? Icon(
                  FontAwesomeIcons.eyeSlash,
                  size: 22,
                  color: KColors.ColorPrimary.withOpacity(0.5),
                )
                    : Icon(
                  FontAwesomeIcons.eye,
                  size: 22,
                  color: KColors.ColorPrimary,
                ),
              )
                  : null,
            ),
            onChanged: (value) {
              print(_obscureText);
              widget.onTextChanged(value);
            },
          )
        ],
      ),
    );
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}

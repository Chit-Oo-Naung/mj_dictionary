import 'package:mjdictionary/components/checkbox_type.dart';
import 'package:flutter/material.dart';

// import 'package:getwidget/getwidget.dart';

class CustomCheckbox extends StatefulWidget {
  /// [CustomCheckbox] is a small box (as in a checklist) in which to place a check mark to make a selection with various customization options.
  const CustomCheckbox({
    Key? key,
    this.size = 35,
    this.type = GFCheckboxType.basic,
    this.activeColor = Colors.blue,
    this.inactiveColor = Colors.white,
    this.activeBorderColor = Colors.white,
    this.inactiveBorderColor = const Color(0xff222428),
    required this.onChanged,
    required this.value,
    required this.textActiveColor,
    required this.textInactiveColor,
    required this.textValue,
    this.activeIcon = const Icon(
      Icons.check,
      size: 20,
      color: Colors.white,
    ),
    this.inactiveIcon,
    this.customColor = Colors.green,
    this.autofocus = false,
    this.focusNode,
    this.validator,
  }) : super(key: key);

  /// type of [GFCheckboxType] which is of four type is basic, square, circular and custom
  final GFCheckboxType type;

  /// type of [double] which is GFSize ie, small, medium and large and can use any double value
  final double size;

  /// type of [Color] used to change the backgroundColor of the active checkbox
  final Color activeColor;

  /// type of [Color] used to change the backgroundColor of the inactive checkbox
  final Color inactiveColor;

  /// type of [Color] used to change the border color of the active checkbox
  final Color activeBorderColor;

  /// type of [Color] used to change the border color of the inactive checkbox
  final Color inactiveBorderColor;

  /// Called when the user checks or unchecks the checkbox.
  final ValueChanged<bool>? onChanged;

  /// Used to set the current state of the checkbox
  final bool value;

  final Color textActiveColor;

  final Color textInactiveColor;

  final String textValue;

  /// type of [Widget] used to change the  checkbox's active icon
  final Widget activeIcon;

  /// type of [Widget] used to change the  checkbox's inactive icon
  final Widget? inactiveIcon;

  /// type of [Color] used to change the background color of the custom active checkbox only
  final Color customColor;

  /// on true state this widget will be selected as the initial focus
  /// when no other node in its scope is currently focused
  final bool autofocus;

  /// an optional focus node to use as the focus node for this widget.
  final FocusNode? focusNode;

  /// An optional method that validates an input. Returns an error string to
  /// display if the input is invalid, or null otherwise.
  final FormFieldValidator<bool>? validator;
  @override
  _CustomCheckboxState createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  bool get enabled => widget.onChanged != null;
  @override
  void initState() {
    super.initState();
  }

  bool _isChecked = false;
  @override
  Widget build(BuildContext context) => FormField<bool>(
        initialValue: _isChecked,
        validator: widget.validator,
        builder: (state) => Column(children: [
          FocusableActionDetector(
            focusNode: widget.focusNode,
            autofocus: widget.autofocus,
            enabled: enabled,
            child: InkResponse(
              highlightShape: widget.type == GFCheckboxType.circle
                  ? BoxShape.circle
                  : BoxShape.rectangle,
              containedInkWell: widget.type != GFCheckboxType.circle,
              canRequestFocus: enabled,
              onTap: widget.onChanged != null
                  ? () {
                      _isChecked = !widget.value;
                      state.didChange(!widget.value);
                      widget.onChanged!(!widget.value);
                    }
                  : null,
              child: Row(
                children: [
                  Container(
                    height: widget.size,
                    width: widget.size,
                    margin: widget.type == GFCheckboxType.custom
                        ? const EdgeInsets.all(5)
                        : widget.type != GFCheckboxType.circle
                            ? const EdgeInsets.all(10)
                            : EdgeInsets.zero,
                    decoration: BoxDecoration(
                        color: enabled
                            ? widget.value
                                ? widget.type == GFCheckboxType.custom
                                    ? Colors.transparent
                                    : widget.activeColor
                                : widget.inactiveColor
                            : Colors.grey,
                        borderRadius: widget.type == GFCheckboxType.custom
                            ? BorderRadius.circular(50)
                            : widget.type == GFCheckboxType.basic
                                ? BorderRadius.circular(3)
                                : widget.type == GFCheckboxType.circle
                                    ? BorderRadius.circular(50)
                                    : BorderRadius.zero,
                        border: Border.all(
                            color: widget.value
                                ? widget.type == GFCheckboxType.custom
                                    ? widget.activeBorderColor
                                    : widget.activeBorderColor
                                : widget.inactiveBorderColor)),
                    child: widget.value
                        ? widget.type == GFCheckboxType.custom
                            ? Stack(
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.center,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.all(5),
                                    alignment: Alignment.center,
                                    width: widget.size * 0.9,
                                    height: widget.size * 0.9,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.circular(50),
                                        color: widget.customColor),
                                  )
                                ],
                              )
                            : widget.activeIcon
                        : widget.inactiveIcon,
                  ),
                  Container(
                      padding: widget.type == GFCheckboxType.custom
                          ? const EdgeInsets.only(left: 0)
                          : const EdgeInsets.only(left: 5),
                      child: Text(
                        widget.textValue,
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            // color: _isChecked ? widget.textColor:Colors.white,
                            color: widget.value
                                ? widget.textActiveColor
                                : widget.textInactiveColor
                            // color: widget.textColor,
                            ),
                      )),
                ],
              ),
            ),
          ),
          state.hasError
              ? Text(
                  state.errorText!,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                )
              : Container(),
        ]),
      );
}

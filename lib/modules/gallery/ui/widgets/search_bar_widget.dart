import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:revolution1401/common/styles/appTheme/app_theme_helper.dart';
import 'package:revolution1401/common/uikit/form/cin_textfield.dart';

class SearchBarAnimation extends StatefulWidget {
  final double? searchBoxWidth;
  final double buttonElevation;
  final TextEditingController textEditingController;
  final Widget trailingWidget;
  final Widget buttonWidget;
  final Widget secondaryButtonWidget;
  final Color? hintTextColour;
  final Color? searchBoxColour;
  final Color? buttonColour;
  final Color? cursorColour;
  final Color? searchBoxBorderColour;
  final Color? buttonShadowColour;
  final Color? buttonBorderColour;
  final String? hintText;
  final int durationInMilliSeconds;
  final bool isSearchBoxOnRightSide;
  final bool enableKeyboardFocus;
  final bool enableButtonShadow;
  final bool enableBoxShadow;
  final bool textAlignToRight;
  final bool enableBoxBorder;
  final bool enableButtonBorder;
  final bool isOriginalAnimation;
  final TextStyle? enteredTextStyle;
  final Function? onSaved;
  final Function? onChanged;
  final Function? onFieldSubmitted;
  final Function? onEditingComplete;
  final Function? onExpansionComplete;
  final Function? onCollapseComplete;
  final Function(bool isOpen)? onPressButton;

  final TextInputType textInputType;
  final List<TextInputFormatter>? inputFormatters;

  const SearchBarAnimation({
    required this.textEditingController,
    required this.isOriginalAnimation,
    required this.trailingWidget,
    required this.secondaryButtonWidget,
    required this.buttonWidget,
    this.searchBoxWidth,
    this.hintText,
    this.searchBoxColour = Colors.white,
    this.buttonColour = Colors.white,
    this.cursorColour = Colors.black,
    this.hintTextColour = Colors.grey,
    this.searchBoxBorderColour = Colors.black12,
    this.buttonShadowColour = Colors.black45,
    this.buttonBorderColour = Colors.black26,
    this.durationInMilliSeconds = 1000,
    this.textInputType = TextInputType.text,
    this.isSearchBoxOnRightSide = false,
    this.enableKeyboardFocus = false,
    this.enableBoxBorder = false,
    this.enableButtonBorder = false,
    this.enableButtonShadow = true,
    this.enableBoxShadow = true,
    this.textAlignToRight = false,
    this.onSaved,
    this.onChanged,
    this.onFieldSubmitted,
    this.onExpansionComplete,
    this.onCollapseComplete,
    this.onPressButton,
    this.onEditingComplete,
    this.enteredTextStyle,
    this.buttonElevation = 0,
    this.inputFormatters,
    Key? key,
  }) : super(key: key);

  @override
  _SearchBarAnimationState createState() => _SearchBarAnimationState();
}

class _SearchBarAnimationState extends State<SearchBarAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  FocusNode focusNode = FocusNode();
  bool _isAnimationOn = false;
  bool switcher = false;

  final DecorationTween decorationTween = DecorationTween(
    begin: BoxDecoration(
      color: Colors.red,
      borderRadius: BorderRadius.circular(60),
    ),
    end: BoxDecoration(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(60),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          blurRadius: 5,
          spreadRadius: 0,
          color: Colors.black45,
        )
      ],
    ),
  );

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.durationInMilliSeconds),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    widget.textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildAnimatedSearchbarBody();
  }

  Widget _buildAnimatedSearchbarBody() {
    return Container(
      height: 60,
      alignment: widget.isSearchBoxOnRightSide
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        decoration: BoxDecoration(
          color: _isAnimationOn ? widget.searchBoxColour : Colors.transparent,
          border: Border.all(
              color: !widget.enableBoxBorder
                  ? Colors.transparent
                  : _isAnimationOn
                      ? widget.searchBoxBorderColour!
                      : Colors.transparent),
          borderRadius: BorderRadius.circular(30),
          boxShadow: (!_isAnimationOn)
              ? null
              : ((widget.enableBoxShadow)
                  ? [
                      const BoxShadow(
                        color: Colors.black26,
                        spreadRadius: -10,
                        blurRadius: 10,
                        offset: Offset(0, 7),
                      ),
                    ]
                  : null),
        ),
        child: AnimatedContainer(
          duration: Duration(milliseconds: widget.durationInMilliSeconds),
          height: 48,
          width: (!switcher)
              ? 48
              : (widget.searchBoxWidth ?? MediaQuery.of(context).size.width),
          curve: Curves.easeOut,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
          ),
          child: Stack(
            children: [
              AnimatedPositioned(
                duration: Duration(milliseconds: widget.durationInMilliSeconds),
                top: 6,
                left: widget.isSearchBoxOnRightSide ? 7 : null,
                right: !widget.isSearchBoxOnRightSide ? 7 : null,
                curve: Curves.easeOut,
                child: AnimatedOpacity(
                  opacity: (!switcher) ? 0 : 1,
                  duration: const Duration(milliseconds: 700),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: widget.trailingWidget,
                  ),
                ),
              ),
              AnimatedPositioned(
                duration: Duration(milliseconds: widget.durationInMilliSeconds),
                left: (!switcher)
                    ? 20
                    : (!widget.textAlignToRight)
                        ? 45
                        : 80,
                curve: Curves.easeOut,
                top: 11,
                child: AnimatedOpacity(
                  opacity: (!switcher) ? 0 : 1,
                  duration: const Duration(milliseconds: 200),
                  child: Container(
                    padding: const EdgeInsets.only(left: 10),
                    alignment: Alignment.topCenter,
                    width: (widget.searchBoxWidth ??
                            MediaQuery.of(context).size.width) /
                        1.7,
                    child: _textFormField(),
                  ),
                ),
              ),
              Align(
                alignment: widget.isSearchBoxOnRightSide
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: (widget.isOriginalAnimation)
                    ? Padding(
                        padding: const EdgeInsets.all(5),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: _isAnimationOn
                                ? null
                                : Border.all(color: widget.buttonBorderColour!),
                          ),
                          child: DecoratedBoxTransition(
                            decoration:
                                decorationTween.animate(_animationController),
                            child: GestureDetector(
                              child: CircleAvatar(
                                backgroundColor: widget.buttonColour,
                                child: switcher
                                    ? widget.secondaryButtonWidget
                                    : widget.buttonWidget,
                              ),
                              onTap: () {
                                _onTapFunctionOriginalAnim();
                              },
                            ),
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(5),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: widget.enableButtonBorder
                                ? Border.all(color: widget.buttonBorderColour!)
                                : null,
                            boxShadow: widget.enableButtonShadow
                                ? [
                                    BoxShadow(
                                      blurRadius: 5,
                                      color: widget.buttonShadowColour!,
                                      spreadRadius: widget.buttonElevation,
                                    )
                                  ]
                                : null,
                          ),
                          child: GestureDetector(
                            child: CircleAvatar(
                              backgroundColor: widget.buttonColour,
                              child: switcher
                                  ? widget.secondaryButtonWidget
                                  : widget.buttonWidget,
                            ),
                            onTap: () {
                              _onTapFunction();
                            },
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onTapFunction() {
    _isAnimationOn = true;
    widget.onPressButton?.call(!switcher);
    setState(
      () {
        if (!switcher) {
          switcher = true;
          setState(() {
            if (widget.enableKeyboardFocus) {
              FocusScope.of(context).requestFocus(focusNode);
            }
          });
          _animationController.forward().then((value) {
            setState(() {
              _isAnimationOn = true;
            });
            widget.onExpansionComplete?.call();
          });
        } else {
          switcher = false;
          setState(() {
            if (widget.enableKeyboardFocus) {
              unFocusKeyboard();
            }
          });
          _animationController.reverse().then((value) {
            setState(() {
              _isAnimationOn = false;
            });
            widget.onCollapseComplete?.call();
          });
        }
      },
    );
  }

  void _onTapFunctionOriginalAnim() {
    _isAnimationOn = true;
    widget.onPressButton?.call(!switcher);
    setState(
      () {
        if (!switcher) {
          switcher = true;
          setState(() {
            if (widget.enableKeyboardFocus) {
              FocusScope.of(context).requestFocus(focusNode);
            }
          });
          _animationController.forward().then((value) {
            widget.onExpansionComplete?.call();
          });
        } else {
          switcher = false;
          setState(() {
            if (widget.enableKeyboardFocus) {
              unFocusKeyboard();
            }
          });
          _animationController.reverse().then((value) {
            setState(() {
              _isAnimationOn = false;
            });
            widget.onCollapseComplete?.call();
          });
        }
      },
    );
    unFocusKeyboard();
  }

  CinTextField _textFormField() {
    return CinTextField(
      name: '',
      controller: widget.textEditingController,
      inputFormatters: widget.inputFormatters,
      focusNode: focusNode,
      cursorWidth: 2,
      textInputAction: TextInputAction.search,
      onEditingComplete: () {
        unFocusKeyboard();
        setState(() {
          switcher = false;
        });
        (widget.onEditingComplete != null)
            ? widget.onEditingComplete?.call()
            : debugPrint('onEditingComplete Not Used');
      },
      keyboardType: widget.textInputType,
      onChanged: (var value) {
        (widget.onChanged != null)
            ? widget.onChanged?.call(value)
            : debugPrint('onChanged Not Used');
      },
      onSaved: (var value) {
        (widget.onSaved != null)
            ? widget.onSaved?.call(value)
            : debugPrint('onSaved Not Used');
      },
      style: widget.enteredTextStyle ?? context.textTheme.bodyText1,
      cursorColor: widget.cursorColour,
      // textAlign: widget.textAlignToRight ? TextAlign.right : TextAlign.left,
      decoration: InputDecoration(
        fillColor: Colors.transparent,
        contentPadding: const EdgeInsets.only(left: 4, top: 12, right: 45),
        hoverColor: Colors.transparent,
        isDense: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: widget.hintTextColour,
          fontSize: 17,
          fontWeight: FontWeight.w400,
          height: kIsWeb ? 1.5 : 1.2,
        ),
        alignLabelWithHint: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  void unFocusKeyboard() {
    final FocusScopeNode currentFocusScope = FocusScope.of(context);
    if (!currentFocusScope.hasPrimaryFocus && currentFocusScope.hasFocus) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }
}

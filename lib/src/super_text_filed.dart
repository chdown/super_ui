import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum KeyboardType { number, text, decimal, decimalNegative }

enum TextFiledStyle { none, fill, outline, underline }

/// @author : ch
/// @date 2024-01-19 21:59:11
/// @description 输入框组件
///
/// 如果需要定制输入框的高度，可以使用以下属性
/// isDense 使可编辑区域的高度边距减少，达到紧凑的效果。从而会影响输入框的高度。
/// isCollapsed 完全去除默认的边距，使默认情况下 TextField 的高度和可编辑区域的高度一致
/// *** 单行输入 ***
/// 1、如果整个输入组件的额高度低于默认高度，可以通过上方的【isDense】和【isCollapsed】进行设置
/// 2、通过contentPadding进行设置，默认为30
/// *** 多行输入 ***
/// 1、通过minLines进行设置
/// *** 内容不居中适配 ***
/// 1、若设置isDense和isCollapsed，同时添加了prefixIcon或prefixIcon时，需要设置 contentPaddings
///
class SuperTextFiled extends StatefulWidget {
  /// 输入框类型
  final TextFiledStyle style;

  /// 控制器
  final TextEditingController? controller;

  /// 原始文本
  final String? originalText;

  /// 文本颜色
  final Color? textColor;

  /// 文本大小
  final double? textSize;

  /// 文本对齐方式
  final TextAlign textAlign;

  /// 边框圆角大小
  final double borderRadius;

  /// 边框圆角大小
  final double borderUnderLineRadius;

  /// 边框宽度
  final double borderWidth;

  /// 边框颜色
  final Color borderColor;

  /// 焦点
  final FocusNode? focusNode;

  /// 最大输入长度
  final int? maxLength;

  /// 键盘回车事件
  final TextInputAction? textInputAction;

  /// 键盘输入限制
  final List<TextInputFormatter>? inputFormatters;

  /// 键盘输入类型
  final KeyboardType? keyboardType;

  /// 小数点长度[keyboardType]类型为[KeyboardType.decimal]或[KeyboardType.decimalNegative]生效
  final int decimalLength;

  /// 整数位长度
  final int? integerLength;

  /// 装饰是否与输入字段大小相同、该属性用于修改高度
  final bool isCollapsed;

  /// 是否为紧凑模式
  final bool isDense;

  /// [isCollapsed]或[isDense] 为 [true] 时的高度，相当于设置了[contentPadding]，因此[contentPadding]为[null]时生效
  final double? heightH;

  /// 填充色
  final Color? fillColor;

  /// 内部内容边距
  final EdgeInsetsGeometry? contentPadding;

  /// 点击事件
  final VoidCallback? onTap;

  /// 内容改变监听
  final ValueChanged<String>? onChanged;

  /// 提交监听
  final ValueChanged<String>? onSubmitted;

  /// 是否扩展
  final bool expands;

  /// 是否只读
  final bool readOnly;

  /// 自动获取焦点
  final bool autofocus;

  /// 最小行数
  final int? minLines;

  /// 最大行数
  final int? maxLines;

  /// 是否清除
  final bool isClear;

  /// 是否禁用
  final bool enabled;

  /// 是否显示密文
  final bool obscureText;

  /// 是否不允许输入sql相关
  final bool noSql;

  final String? hintText;
  final Color? hintTextColor;
  final double? hintTextSize;

  final String? counterText;
  final Widget? counter;
  final TextStyle? counterStyle;

  final String? errorText;
  final Color errorColor;
  final TextStyle? errorStyle;

  final String? helperText;
  final TextStyle? helperStyle;
  final int? helperMaxLines;

  final Widget? label;
  final String? labelText;
  final TextStyle? labelStyle;

  final Widget? prefixIcon;
  final String? prefixText;
  final TextStyle? prefixStyle;
  final BoxConstraints? prefixIconConstraints;

  final Widget? suffixIcon;
  final String? suffixText;
  final TextStyle? suffixStyle;
  final double? suffixPaddingEnd;
  final BoxConstraints? suffixIconConstraints;

  const SuperTextFiled({
    super.key,
    this.isCollapsed = false,
    this.isDense = false,
    this.heightH,
    this.controller,
    this.originalText,
    this.textColor,
    this.textSize = 14,
    this.onTap,
    this.onChanged,
    this.onSubmitted,
    this.keyboardType,
    this.style = TextFiledStyle.none,
    this.borderRadius = 8,
    this.borderUnderLineRadius = 0,
    this.borderColor = const Color(0xFF999999),
    this.errorColor = const Color(0xFFFF0000),
    this.borderWidth = 1.0,
    this.decimalLength = 2,
    this.integerLength,
    this.textInputAction,
    this.inputFormatters,
    this.maxLength,
    this.expands = false,
    this.readOnly = false,
    this.autofocus = false,
    this.minLines = 1,
    this.maxLines = 1,
    this.textAlign = TextAlign.start,
    this.obscureText = false,
    this.noSql = true,
    this.isClear = true,
    this.enabled = true,
    this.focusNode,
    this.label,
    this.hintText,
    this.hintTextColor = const Color(0xFF999999),
    this.hintTextSize,
    this.fillColor,
    this.contentPadding,
    this.counter,
    this.counterText,
    this.counterStyle,
    this.errorText,
    this.errorStyle,
    this.helperText,
    this.helperStyle,
    this.helperMaxLines,
    this.labelText,
    this.labelStyle,
    this.prefixIcon,
    this.prefixIconConstraints,
    this.prefixText,
    this.prefixStyle,
    this.suffixIcon,
    this.suffixIconConstraints,
    this.suffixText,
    this.suffixStyle,
    this.suffixPaddingEnd = 4,
  });

  @override
  State<SuperTextFiled> createState() => _SuperTextFiledState();
}

class _SuperTextFiledState extends State<SuperTextFiled> {
  List<TextInputFormatter> formatter = [];
  TextEditingController? _textController;
  FocusNode? _focusNode;
  TextInputType textInputType = TextInputType.text;
  InputBorder inputBorder = InputBorder.none;
  InputBorder errorBorder = InputBorder.none;
  bool _isClear = false;
  EdgeInsetsGeometry? contentPadding;

  @override
  void initState() {
    super.initState();
    if (widget.noSql) formatter.add(FilteringTextInputFormatter.deny(RegExp(r'[=$]')));
    if (widget.maxLength != null) formatter.add(LengthLimitingTextInputFormatter(widget.maxLength!));
    if (widget.inputFormatters != null) formatter.addAll(widget.inputFormatters!);

    _textController = widget.controller ?? TextEditingController();
    if (widget.originalText != null) _textController?.text = widget.originalText ?? "";
    _focusNode = widget.focusNode ?? FocusNode();

    _isClear = widget.isClear && _focusNode!.hasFocus && _textController!.text.isNotEmpty;
    _focusNode!.addListener(() {
      if (!mounted) return;
      setState(() {
        _isClear = widget.isClear && _focusNode!.hasFocus && _textController!.text.isNotEmpty;
      });
    });
  }

  void _keyboard() {
    switch (widget.keyboardType) {
      case KeyboardType.number:
        textInputType = TextInputType.number;
        formatter.add(FilteringTextInputFormatter.digitsOnly);
        break;
      case KeyboardType.decimal:
        textInputType = const TextInputType.numberWithOptions(decimal: true);
        formatter.add(XNumberTextInputFormatter(maxDecimalLength: widget.decimalLength, maxIntegerLength: widget.integerLength, isAllowNegative: false));
        break;
      case KeyboardType.decimalNegative:
        textInputType = const TextInputType.numberWithOptions(decimal: true, signed: true);
        formatter.add(XNumberTextInputFormatter(maxDecimalLength: widget.decimalLength, maxIntegerLength: widget.integerLength, isAllowNegative: true));
        break;
      default:
        textInputType = TextInputType.text;
        break;
    }
  }

  _border() {
    switch (widget.style) {
      case TextFiledStyle.outline:
        inputBorder = OutlineInputBorder(
          borderSide: BorderSide(color: widget.borderColor),
          borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius)),
        );
        errorBorder = OutlineInputBorder(
          borderSide: BorderSide(color: widget.errorColor),
          borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius)),
        );
        break;
      case TextFiledStyle.underline:
        inputBorder = UnderlineInputBorder(
          borderSide: BorderSide(color: widget.borderColor, width: widget.borderWidth),
          borderRadius: BorderRadius.all(Radius.circular(widget.borderUnderLineRadius)),
        );
        errorBorder = UnderlineInputBorder(
          borderSide: BorderSide(color: widget.errorColor, width: widget.borderWidth),
          borderRadius: BorderRadius.all(Radius.circular(widget.borderUnderLineRadius)),
        );
        break;
      case TextFiledStyle.fill:
        inputBorder = OutlineInputBorder(
          borderSide: const BorderSide(style: BorderStyle.none),
          borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius)),
        );
        break;
      case TextFiledStyle.none:
        inputBorder = InputBorder.none;
        break;
    }
    return inputBorder;
  }

  void _getContentPadding() {
    contentPadding = widget.contentPadding;
    if (widget.isCollapsed || widget.isDense) {
      if (widget.heightH != null) {
        double vertical = ((widget.heightH! - (widget.textSize ?? 14).toDouble()) / 2) + 1;
        if (vertical >= 7) {
          contentPadding = EdgeInsets.symmetric(horizontal: 7, vertical: vertical);
        }
      } else {
        contentPadding ??= const EdgeInsets.symmetric(horizontal: 7, vertical: 7);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _keyboard();
    _border();
    _getContentPadding();
    return TextField(
      controller: _textController,
      cursorWidth: 1,
      style: TextStyle(color: widget.textColor, fontSize: widget.textSize),
      keyboardType: textInputType,
      textInputAction: widget.textInputAction,
      inputFormatters: formatter,
      onTap: widget.onTap,
      onChanged: (text) {
        setState(() {
          _isClear = widget.isClear && _focusNode!.hasFocus && _textController!.text.isNotEmpty;
        });
        widget.onChanged?.call(text);
      },
      expands: widget.expands,
      onSubmitted: widget.onSubmitted,
      readOnly: widget.readOnly,
      autofocus: widget.autofocus,
      minLines: widget.minLines,
      maxLines: (widget.minLines != null && widget.minLines! > (widget.maxLines ?? 1)) ? widget.minLines : (widget.maxLines ?? 1),
      obscureText: widget.obscureText,
      textAlign: widget.textAlign,
      enabled: widget.enabled,
      focusNode: _focusNode,
      decoration: InputDecoration(
        isCollapsed: widget.isCollapsed,
        isDense: widget.isDense,
        border: inputBorder,
        enabledBorder: inputBorder,
        focusedBorder: inputBorder,
        focusedErrorBorder: inputBorder,
        errorBorder: errorBorder,
        label: widget.label,
        hintText: widget.hintText,
        hintStyle: TextStyle(color: widget.hintTextColor, fontSize: widget.hintTextSize ?? widget.textSize),
        fillColor: widget.fillColor,
        filled: widget.fillColor != null,
        contentPadding: contentPadding,
        counter: widget.counter,
        counterText: widget.counterText,
        counterStyle: widget.counterStyle,
        errorText: widget.errorText,
        errorStyle: widget.errorStyle,
        helperText: widget.helperText,
        helperStyle: widget.helperStyle,
        helperMaxLines: widget.helperMaxLines,
        labelText: widget.labelText,
        labelStyle: widget.labelStyle,
        prefixIcon: widget.prefixIcon,
        prefixIconConstraints: widget.prefixIconConstraints ?? const BoxConstraints(minWidth: 32),
        prefixText: widget.prefixText,
        prefixStyle: widget.prefixStyle,
        suffixIcon: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Visibility(
              visible: _isClear && !widget.readOnly,
              child: GestureDetector(
                onTap: () {
                  if (mounted) {
                    _textController?.clear();
                    setState(() {});
                  }
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  child: Icon(
                    Icons.cancel_outlined,
                    size: 18,
                    color: Color(0xff909399),
                  ),
                ),
              ),
            ),
            widget.suffixIcon ?? const SizedBox.shrink(),
            if (widget.suffixIcon != null || (_isClear && !widget.readOnly)) SizedBox(width: widget.suffixPaddingEnd),
          ],
        ),
        suffixIconConstraints: widget.suffixIconConstraints ?? const BoxConstraints(minWidth: 32),
        suffixText: widget.suffixText,
        suffixStyle: widget.suffixStyle,
      ),
    );
  }
}

class XNumberTextInputFormatter extends TextInputFormatter {
  final int? _maxIntegerLength;
  final int? _maxDecimalLength;
  final bool _isAllowDecimal;
  final bool _isAllowNegative;

  /// [maxIntegerLength]限定整数的最大位数，为null时不限
  /// [maxDecimalLength]限定小数点的最大位数，为null时不限
  /// [isAllowDecimal]是否可以为小数，默认是可以为小数，也就是可以输入小数点
  /// [isAllowNegative]是否可以为负数
  XNumberTextInputFormatter({
    int? maxIntegerLength,
    int? maxDecimalLength,
    bool isAllowDecimal = true,
    bool isAllowNegative = true,
  })  : _maxIntegerLength = maxIntegerLength,
        _maxDecimalLength = maxDecimalLength,
        _isAllowDecimal = isAllowDecimal,
        _isAllowNegative = isAllowNegative;

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String value = newValue.text.trim(); //去掉前后空格
    int selectionIndex = newValue.selection.end;
    if (_isAllowDecimal) {
      if (value == '.') {
        value = '0.';
        selectionIndex++;
      } else if (value != '' && _isToDoubleError(value)) {
        //不是double输入数据
        return _oldTextEditingValue(oldValue);
      }
      //包含小数点
      if (value.contains('.')) {
        int pointIndex = value.indexOf('.');
        String beforePoint = value.substring(0, pointIndex);

        String afterPoint = value.substring(pointIndex + 1, value.length);
        //小数点前面没内容补0
        if (beforePoint.isEmpty) {
          value = '0.$afterPoint';
          selectionIndex++;
        } else {
          //限定整数位数
          if (_maxIntegerLength != null) {
            if (beforePoint.length > _maxIntegerLength!) {
              return _oldTextEditingValue(oldValue);
            }
          }
        }
        //限定小数点位数
        if (_maxDecimalLength != null) {
          if (afterPoint.length > _maxDecimalLength!) {
            return _oldTextEditingValue(oldValue);
          }
        }
      } else {
        //限定整数位数
        if (_maxIntegerLength != null) {
          if (value.length > _maxIntegerLength!) {
            return _oldTextEditingValue(oldValue);
          }
        }
      }
    } else {
      if (value.contains('.') || (value != '' && _isToDoubleError(value)) || (_maxIntegerLength != null && value.length > _maxIntegerLength!)) {
        return _oldTextEditingValue(oldValue);
      }
    }

    return TextEditingValue(
      text: value,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }

  ///返回旧的输入内容
  TextEditingValue _oldTextEditingValue(TextEditingValue oldValue) {
    return TextEditingValue(
      text: oldValue.text,
      selection: TextSelection.collapsed(offset: oldValue.selection.end),
    );
  }

  ///输入内容不能解析成double
  bool _isToDoubleError(String value) {
    if (!_isAllowNegative) {
      if (value.contains('-')) {
        return true;
      }
    }
    try {
      double.parse(value);
    } catch (e) {
      return true;
    }
    return false;
  }
}

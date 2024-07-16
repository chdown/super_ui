import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// @author : ch
/// @date 2024-01-19 21:59:11
/// @description 输入框组件
///
enum KeyboardType { number, text, decimal, decimalNegative }

enum TextFiledStyle { none, fill, outline, underline }

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

  /// 最大输入值
  final double? maxDecimal;

  /// 装饰是否与输入字段大小相同、该属性用于修改高度
  final bool isCollapsed;

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

  /// 大小适配器
  final BoxConstraints? constraints;

  /// 是否制度
  final bool readOnly;

  /// 自动获取焦点
  final bool autofocus;

  /// 最小行数
  final int? minLines;

  /// 最大行数
  final int maxLines;

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
    this.constraints,
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
    this.maxDecimal,
    this.textInputAction,
    this.inputFormatters,
    this.maxLength,
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
        formatter.add(NumberInputFormatter(decimal: widget.decimalLength, max: widget.maxDecimal));
        break;
      case KeyboardType.decimalNegative:
        textInputType = const TextInputType.numberWithOptions(decimal: true, signed: true);
        formatter.add(NumberInputFormatter(decimal: widget.decimalLength, max: widget.maxDecimal, decimalNegative: true));
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

  @override
  Widget build(BuildContext context) {
    _keyboard();
    _border();
    return TextField(
      controller: _textController,
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
      onSubmitted: widget.onSubmitted,
      readOnly: widget.readOnly,
      autofocus: widget.autofocus,
      minLines: widget.minLines,
      maxLines: (widget.minLines != null && widget.minLines! > widget.maxLines) ? widget.minLines : widget.maxLines,
      obscureText: widget.obscureText,
      textAlign: widget.textAlign,
      enabled: widget.enabled,
      focusNode: _focusNode,
      decoration: InputDecoration(
        constraints: widget.constraints,
        isCollapsed: widget.isCollapsed,
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
        contentPadding: widget.contentPadding ?? (widget.isCollapsed ? const EdgeInsets.all(6) : widget.contentPadding),
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
        prefixIconConstraints: widget.prefixIconConstraints,
        prefixText: widget.prefixText,
        prefixStyle: widget.prefixStyle,
        suffixIcon: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Visibility(
              visible: _isClear && !widget.readOnly,
              child: InkWell(
                onTap: () {
                  if (mounted) {
                    _textController?.clear();
                    setState(() {});
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: const Icon(
                    Icons.cancel,
                    size: 18,
                    color: Color(0xFF999999),
                  ),
                ),
              ),
            ),
            widget.suffixIcon ?? const SizedBox.shrink(),
            if (widget.suffixIcon != null || (_isClear && !widget.readOnly)) SizedBox(width: widget.suffixPaddingEnd),
          ],
        ),
        suffixIconConstraints: widget.suffixIconConstraints ?? const BoxConstraints(),
        suffixText: widget.suffixText,
        suffixStyle: widget.suffixStyle,
      ),
    );
  }
}

class NumberInputFormatter extends TextInputFormatter {
  final double? max;
  final int decimal;
  final bool decimalNegative;
  late final RegExp _exp;

  NumberInputFormatter({
    this.max,
    this.decimal = 2,
    this.decimalNegative = false,
  }) {
    if (decimal == 0) {
      _exp = decimalNegative ? RegExp(r'(^[-1-9](\d+)?$)|(^(0)$)') : RegExp(r'(^[1-9](\d+)?$)|(^(0)$)');
    } else {
      _exp = RegExp(
        decimalNegative
            ? r'(^[-1-9](\d+)?$)|(^(0)$)|(^(0\.)(\d+)?(\d+)?$)|(^[-1-9](\d+)?(\.)?(\d+)?$)'
            : r'(^[1-9](\d+)?$)|(^(0)$)|(^(0\.)(\d+)?(\d+)?$)|(^[1-9](\d+)?(\.)?(\d+)?$)',
      );
    }
  }

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final input = newValue.text;
    if (input.isEmpty) return newValue;
    if (!_exp.hasMatch(input)) return oldValue;
    if (max != null) {
      final num = double.tryParse(input) ?? 0;
      if (num > max!) {
        return TextEditingValue(
          text: max.toString(),
          selection: TextSelection.collapsed(offset: max.toString().length),
        );
      }
    }
    if (decimal > 0) {
      final index = input.indexOf('.');
      if (index < 0) return newValue;
      final afterDot = input.substring(index, input.length).length - 1;
      if (afterDot > decimal) return oldValue;
    }
    return newValue;
  }
}

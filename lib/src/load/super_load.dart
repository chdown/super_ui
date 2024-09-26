import 'dart:async';

import 'package:flutter/material.dart';

import 'super_load_page.dart';
import 'super_load_status.dart';

/// 缺省页
class SuperLoad extends StatefulWidget {
  /// 控制器
  final SuperLoadController controller;

  /// 点击事件
  final FutureOr Function(Map<String, String>? params)? onTap;

  /// content页面，用于展示给客户
  final Widget child;

  /// state缺省页构造器，默认情况下会返回定义的缺省布局，在滑片中根据实际情况进行包装
  final Widget Function(Widget widget)? stateBuilder;

  /// 自定义参数，会传递到 [SuperLoadPage] 中
  final Map<String, String>? params;

  /// 自定义页面。自定义页面中的key会覆盖全局配置的key
  /// key可使用[SuperLoadStatus]枚举的[name]属性
  final Map<String, SuperLoadPage>? otherPages;

  /// 全局配置的默认页面
  static Map<String, SuperLoadPage>? Function() defaultPages = () => null;

  /// 获取默认的公共页面
  static Map<String, SuperLoadPage>? get _defaultPages => defaultPages.call();

  /// 全局默认状态
  static SuperLoadStatus defaultLoadStatus = SuperLoadStatus.content;

  const SuperLoad({
    super.key,
    required this.controller,
    required this.child,
    this.onTap,
    this.stateBuilder,
    this.params,
    this.otherPages,
  });

  @override
  State<SuperLoad> createState() => _LoadPageState();
}

class _LoadPageState extends State<SuperLoad> {
  /// 当前展示的页面,默认为content
  String _pageTag = SuperLoad.defaultLoadStatus.name;

  @override
  void initState() {
    super.initState();
    widget.controller._bind(this);
  }

  @override
  Widget build(BuildContext context) {
    var pages = parsePages();
    if (_pageTag == SuperLoadStatus.content.name) return widget.child;
    return widget.stateBuilder == null ? pages[_pageTag] : widget.stateBuilder!.call(pages[_pageTag]);
  }

  /// 解析获取pages
  parsePages() {
    var pageMap = SuperLoad._defaultPages ?? <String, SuperLoadPage>{};
    pageMap.addAll(widget.otherPages ?? {});
    pageMap.forEach((tag, loadWidget) {
      loadWidget.onTap = widget.onTap;
      loadWidget.params = widget.params;
    });
    return pageMap;
  }

  /// 切换页面的方法
  void showPage(String tag) {
    if (!mounted) return;
    if (_pageTag != tag && mounted) {
      setState(() {
        _pageTag = tag;
      });
    }
  }
}

class SuperLoadController {
  /// [LoadPage] sate.
  _LoadPageState? _state;

  /// 绑定LoadPage
  void _bind(_LoadPageState state) {
    _state = state;
  }

  void showError() => _state?.showPage(SuperLoadStatus.error.name);

  void showEmpty() => _state?.showPage(SuperLoadStatus.empty.name);

  void showNetError() => _state?.showPage(SuperLoadStatus.netError.name);

  void showLoading() => _state?.showPage(SuperLoadStatus.loading.name);

  void showContent() => _state?.showPage(SuperLoadStatus.content.name);

  void showOther() => _state?.showPage(SuperLoadStatus.other.name);

  void showCustom(String customTag) => _state?.showPage(customTag);

  void dispose() {
    _state = null;
  }
}

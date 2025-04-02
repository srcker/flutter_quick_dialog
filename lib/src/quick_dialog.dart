import 'dart:async';
import 'package:flutter/material.dart';
import '../quick_dialog.dart';
import './widgets/container.dart';
import './widgets/overlay_entry.dart';
import 'widgets/modal.dart';

/// 对话框样式枚举
/// - light: 浅色主题
/// - dark: 深色主题
enum QuickDialogStyle { light, dark }

/// 对话框类型枚举
/// - modal: 模态对话框
/// - half: 半屏对话框
/// - widget: 自定义组件对话框
enum QuickDialogType { modal, half, widget }

/// 按钮排列方式枚举
/// - h: 水平排列
enum QuickDialogButtonAlignment { horizontal, vertical }

/// 动画样式枚举
/// - opacity: 透明度动画
/// - offset: 位移动画
/// - scale: 缩放动画
/// - custom: 自定义动画
enum QuickDialogAnimationStyle { opacity, offset, scale, custom }

enum QuickDialogAnimationDirectional { center, leftRight, rightLeft, bottomTop, topBottom }
/// 遮罩类型枚举
/// - none: 无遮罩
/// - clear: 透明遮罩
/// - black: 黑色半透明遮罩
/// - custom: 自定义遮罩
enum QuickDialogMaskType { none, clear, black, custom }

enum QuickDialogPosition { top, center, bottom }

/// 对话框状态枚举
/// - show: 显示状态
/// - dismiss: 关闭状态
enum QuickDialogStatus { show, dismiss }

/// 对话框状态变更回调函数类型
typedef QuickDialogStatusCallback = void Function(QuickDialogStatus status);

/// 确认按钮回调函数类型
typedef QuickDialogConfirmCallback = void Function();

/// 取消按钮回调函数类型
typedef QuickDialogCancelCallback = void Function();

/// 取消按钮回调函数类型
typedef QuickDialogDismissCallback = void Function();

/// 全局对话框状态回调列表
final List<QuickDialogStatusCallback> _statusCallbacks = <QuickDialogStatusCallback>[];




/// QuickDialog 主类
class QuickDialog {

/// 对话框视觉样式（浅色/深色主题），默认值 light
    late QuickDialogStyle style;

    /// 对话框展示类型（模态/半屏/自定义组件），默认值 none
    late QuickDialogType type;

    /// 对话框入场动画类型（透明度/位移/缩放/自定义），默认值 opacity
    late QuickDialogAnimationStyle animationStyle;

    /// 遮罩层类型（无/透明/黑色/自定义），默认值 none
    late QuickDialogMaskType maskType;

    /// 对话框在屏幕中的位置（顶部/居中/底部），默认值 center
    late QuickDialogPosition position;

    /// 操作按钮排列方向（水平/垂直），默认值 horizontal
    late QuickDialogButtonAlignment buttonAlignment;

    /// 对话框内容内边距，默认零边距
    late EdgeInsets padding;

    /// 对话框外边距，默认水平35像素
    late EdgeInsets margin;

    /// 确认按钮点击回调（当用户点击确认按钮时触发）
    QuickDialogConfirmCallback? confirmCallback;

    /// 取消按钮点击回调（当用户点击取消按钮时触发）
    QuickDialogCancelCallback? cancelCallback;

    /// 对话框关闭回调（当对话框完全关闭后触发）
    QuickDialogDismissCallback? dismissCallback;

    /// 自定义动画控制器（当使用custom动画样式时必须提供）
    QuickDialogAnimation? customAnimation;

    /// 动画持续时间，默认200毫秒
    late Duration animationDuration;

    /// 对话框边框线宽，默认0.5像素
    late double lineWidth;

    /// 对话框圆角半径，默认12像素
    late BorderRadius radius;

    /// 自定义遮罩颜色（当maskType为custom时生效）
    Color? maskColor;

    /// 点击遮罩是否关闭对话框，默认true允许点击关闭
    bool? dismissOnTap;

    /// 对话框标题文本内容
    String? titleText;

    /// 对话框正文文本内容
    String? contentText;

    /// 标题文本样式（可覆盖默认样式）
    TextStyle? titleTextStyle;

    /// 正文文本样式（可覆盖默认样式）
    TextStyle? contentTextStyle;

    // 内部维护的对话框组件实例
    Widget? _w; 

    // Overlay入口组件引用
    QuickDialogOverlayEntry? overlayEntry; 

    // 对话框容器状态Key（用于控制动画状态）
    GlobalKey<QuickDialogContainerState>? _key;

    /// 获取当前对话框组件实例（用于状态判断）
    Widget? get w => _w;

    /// 获取对话框容器的全局Key（用于执行动画操作）
    GlobalKey<QuickDialogContainerState>? get key => _key;

    /// 单例工厂构造函数（确保全局唯一实例）
    factory QuickDialog() => _instance;

    // 单例内部构造方法
    static final QuickDialog _instance = QuickDialog._internal();


	QuickDialog._internal() {
		style = QuickDialogStyle.light;
		maskType = QuickDialogMaskType.none;
		animationStyle = QuickDialogAnimationStyle.offset;
        position = QuickDialogPosition.center;
        buttonAlignment = QuickDialogButtonAlignment.horizontal;
        lineWidth = 0.5;
        radius = BorderRadius.circular(12);
        dismissOnTap = true;
        margin = const EdgeInsets.symmetric(horizontal: 35);
        padding = EdgeInsets.zero;
        animationDuration = const Duration(milliseconds: 200);
	}

	static QuickDialog get instance => _instance;

	static bool get isShow => _instance.w != null;


	/// 初始化 QuickDialog
	static TransitionBuilder init({TransitionBuilder? builder}) {
		return (BuildContext context, Widget? child) {
			if (builder != null) {
				return builder(context, QuickDialogLoading(child: child));
			} else {
				return QuickDialogLoading(child: child);
			}
		};
	}




    static showModal({
        String? title,
        String? content,
        TextStyle? titleTextStyle,
        TextStyle? contentTextStyle,
        String? cancelText,
        String? confimText,
        TextStyle? cancelTextStyle,
        TextStyle? confimTextStyle,
        bool? dismissOnTap, // 是否点击遮罩关闭
		EdgeInsets? contentPadding, // 内容内边距
		EdgeInsets? contentMargin, // 内容内边距
        BorderRadius? radius,
        QuickDialogAnimationStyle? animation,
        QuickDialogPosition? position,
        QuickDialogMaskType? maskType,
        QuickDialogButtonAlignment? buttonAlignment,
        QuickDialogConfirmCallback? confirmCallback,
        QuickDialogCancelCallback? cancelCallback,
        QuickDialogDismissCallback? dismissCallback
    }) => _instance._show(
        indicator: QuickDialogModal(
            title: title,
            content: content,
            position: position,
            radius: radius,
            contentMargin: contentMargin,
            contentPadding: contentPadding,
            cancelText: cancelText,
            confimText: confimText,
            cancelTextStyle: cancelTextStyle,
            confimTextStyle: confimTextStyle,
            confirmCallback: confirmCallback,
            cancelCallback: cancelCallback,
            dismissOnTap: dismissOnTap,
            buttonAlignment: buttonAlignment ?? QuickDialogButtonAlignment.horizontal,
        ),
        customAnimationStyle: animation,
        maskType: maskType,
        position: position,
        dismissOnTap: dismissOnTap,
        dismissCallback: dismissCallback
    );


    static showDialog({
        required Widget child,
        bool? dismissOnTap, // 是否点击遮罩关闭
        QuickDialogAnimationStyle? animation,
        QuickDialogPosition? position,
        QuickDialogMaskType? maskType,
        QuickDialogDismissCallback? dismissCallback
    }) => _instance._show(
        indicator: child,
        customAnimationStyle: animation,
        maskType: maskType,
        position: position,
        dismissOnTap: dismissOnTap,
        dismissCallback: dismissCallback
    );



    Future<void> _show({
        required Widget indicator,
        bool? dismissOnTap,
        QuickDialogPosition? position,
        QuickDialogType? type,
        QuickDialogMaskType? maskType,
        QuickDialogDismissCallback? dismissCallback, 
        QuickDialogAnimationStyle? customAnimationStyle,
    }){

        // 确保已初始化 overlayEntry
		assert(overlayEntry != null, '您需要在 MaterialApp 中调用 QuickDialog.init()');

        animationStyle = customAnimationStyle ?? animationStyle;

        // 如果动画样式为自定义，确保动画参数不为空
		if (animationStyle == QuickDialogAnimationStyle.custom) {
			assert(customAnimation != null, '当动画样式为自定义时，customAnimation 不能为空');
		}

		// 设置默认提示框位置
		bool animation = _w == null; // 是否需要动画

        // 创建完成回调
		Completer<void> completer = Completer<void>();
		_key = GlobalKey<QuickDialogContainerState>();

        // 当提示框显示完成后触发回调
		completer.future.whenComplete(() {
			_callback(QuickDialogStatus.show); // 调用状态回调
		});

        _w = QuickDialogContainer(
            key: _key,
            indicator: indicator,
            animation: animation,
            position: position,
            maskType: maskType,
            type: type,
            dismissOnTap: dismissOnTap,
            dismissCallback: dismissCallback,
            completer: completer,
        );

		_markNeedsBuild();
		return completer.future;
    }



    Future<void> _dismiss(bool animation) async {
        // 处理对话框容器状态并执行关闭动画
        return key?.currentState?.dismiss(animation).whenComplete(() {
            _reset();
        });
    }

    static Future<void> dismiss({bool animation = true}) {
        return _instance._dismiss(animation);
    }

    /// 重置对话框内部状态
    void _reset() {
        // 清理组件引用并触发界面更新
        _w = null;
        _key = null;
        _markNeedsBuild();
        _callback(QuickDialogStatus.dismiss);
    }

    /// 执行所有状态回调函数
    void _callback(QuickDialogStatus status) {
        for (final callback in _statusCallbacks) {
            callback(status);
        }
    }

    /// 标记需要重新构建覆盖层
    void _markNeedsBuild() {
        overlayEntry?.markNeedsBuild();
    }
}

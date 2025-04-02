import 'package:flutter/material.dart';

import '../quick_dialog.dart';
import 'animations/offset_animation.dart';
import 'animations/opacity_animation.dart';
import 'animations/scale_animation.dart';

/// QuickDialog 主题配置类，提供对话框样式、颜色、动画等主题配置的静态访问方法
class QuickDialogTheme {

    /// 获取对话框背景颜色
    /// 根据 [QuickDialog.instance.style] 的值返回对应颜色：
    /// - light 模式返回白色 (0xFFFFFFFF)
    /// - dark 模式返回深灰色 (0xFF191919)
    static Color get backgroud => QuickDialog.instance.style == QuickDialogStyle.light
        ? const Color(0xFFFFFFFF)
        : const Color(0xFF191919);


    /// 获取标题文本样式
    /// 根据 [QuickDialog.instance.style] 的值返回对应样式：
    /// - light 模式使用黑色文字（透明度 0.9）
    /// - dark 模式使用白色文字（透明度 0.9）
    /// 统一使用 18 号字体并加粗
    static TextStyle get titleTextStyle => QuickDialog.instance.style == QuickDialogStyle.light
        ? TextStyle(fontSize: 18, color: Colors.black.withValues(alpha: 0.9), fontWeight: FontWeight.bold)
        : TextStyle(fontSize: 18, color: Colors.white.withValues(alpha: 0.9), fontWeight: FontWeight.bold);


    /// 获取内容文本样式
    /// 根据 [QuickDialog.instance.style] 的值返回对应样式：
    /// - light 模式使用半透明黑色文字（透明度 0.55）
    /// - dark 模式使用半透明白色文字（透明度 0.55）
    /// 统一使用 18 号字体
    static TextStyle get contentTextStyle => QuickDialog.instance.style == QuickDialogStyle.light
        ? TextStyle(fontSize: 18, color: Colors.black.withValues(alpha: 0.55))
        : TextStyle(fontSize: 18, color: Colors.white.withValues(alpha: 0.55));


    /// 获取确认按钮文本样式
    /// 固定使用蓝色 (0xFF226BF0) 并保持 0.9 透明度
    /// 统一使用 18 号字体并加粗（不受主题模式影响）
    static TextStyle get confirmTextStyle => QuickDialog.instance.style == QuickDialogStyle.light
        ? TextStyle(fontSize: 18, color: const Color(0xFF226BF0).withValues(alpha: 0.9), fontWeight: FontWeight.bold)
        : TextStyle(fontSize: 18, color: const Color(0xFF226BF0).withValues(alpha: 0.9), fontWeight: FontWeight.bold);


    /// 获取取消按钮文本样式
    /// 根据 [QuickDialog.instance.style] 的值返回对应样式：
    /// - light 模式使用黑色文字（透明度 0.9）
    /// - dark 模式使用白色文字（透明度 0.9）
    /// 统一使用 18 号字体并加粗
    static TextStyle get cancelTextStyle => QuickDialog.instance.style == QuickDialogStyle.light
        ? TextStyle(fontSize: 18, color: Colors.black.withValues(alpha: 0.55), fontWeight: FontWeight.bold)
        : TextStyle(fontSize: 18, color: Colors.white.withValues(alpha: 0.55), fontWeight: FontWeight.bold);


    /// 获取删除按钮文本样式
    /// 固定使用红色 (0xFFFA5151) 并保持 0.9 透明度
    /// 统一使用 18 号字体并加粗（不受主题模式影响）
    static TextStyle get deleteTextStyle => QuickDialog.instance.style == QuickDialogStyle.light
        ? TextStyle(fontSize: 18, color: const Color(0xFFFA5151).withValues(alpha: 0.9), fontWeight: FontWeight.bold)
        : TextStyle(fontSize: 18, color: const Color(0xFFFA5151).withValues(alpha: 0.9), fontWeight: FontWeight.bold);


    /// 获取内容区域内边距
    /// 直接返回 [QuickDialog.instance.padding] 的配置值
    static EdgeInsets get contentPadding => QuickDialog.instance.padding;


    /// 获取内容区域外边距
    /// 直接返回 [QuickDialog.instance.margin] 的配置值
    static EdgeInsets get contentMargin => QuickDialog.instance.margin;


    /// 获取遮罩层颜色
    /// [maskType] 参数优先级高于实例配置，当为 null 时使用 [QuickDialog.instance.maskType]
    /// - custom 模式返回自定义颜色 [QuickDialog.instance.maskColor]
    /// - black 模式返回半透明黑色（透明度 0.5）
    /// - 默认返回透明色
    static Color maskColor(QuickDialogMaskType? maskType) {
        maskType ??= QuickDialog.instance.maskType;
        return maskType == QuickDialogMaskType.custom
            ? QuickDialog.instance.maskColor!
            : maskType == QuickDialogMaskType.black
                ? Colors.black.withValues(alpha: 0.5)
                : Colors.transparent;
    }

    /// 获取加载动画实例
    /// 根据 [QuickDialog.instance.animationStyle] 返回对应动画：
    /// - custom 使用自定义动画 [QuickDialog.instance.customAnimation]
    /// - offset 使用位移动画 [OffsetAnimation]
    /// - scale 使用缩放动画 [ScaleAnimation]
    /// - 默认使用透明度动画 [OpacityAnimation]
    static QuickDialogAnimation get loadingAnimation {
        QuickDialogAnimation animation;
        switch (QuickDialog.instance.animationStyle) {
            case QuickDialogAnimationStyle.custom:
                animation = QuickDialog.instance.customAnimation!;
                break;
            case QuickDialogAnimationStyle.offset:
                animation = OffsetAnimation();
                break;
            case QuickDialogAnimationStyle.scale:
                animation = ScaleAnimation();
                break;
            default:
                animation = OpacityAnimation();
                break;
        }
        return animation;
    }


    /// 获取分割线宽度
    /// 直接返回 [QuickDialog.instance.lineWidth] 的配置值
    static double get lineWidth => QuickDialog.instance.lineWidth;

    /// 获取分割线颜色
    /// 根据 [QuickDialog.instance.style] 的值返回对应颜色：
    /// - light 模式使用黑色（透明度 0.05）
    /// - dark 模式使用白色（透明度 0.05）
    static Color get lineColor => QuickDialog.instance.style == QuickDialogStyle.light
        ? const Color(0xFF000000).withValues(alpha: 0.05)
        : const Color(0xFFFFFFFF).withValues(alpha: 0.05);

    /// 获取对话框显示位置
    /// 直接返回 [QuickDialog.instance.position] 的配置值
    static QuickDialogPosition get position => QuickDialog.instance.position;

    /// 将对话框位置转换为 MainAxisAlignment 对齐方式
    /// [position] 参数优先级高于实例配置，当为 null 时使用 [QuickDialog.instance.position]
    /// - top 对应 MainAxisAlignment.start
    /// - bottom 对应 MainAxisAlignment.end
    /// - center 对应 MainAxisAlignment.center
    static MainAxisAlignment alignment(QuickDialogPosition? position) {

        QuickDialogPosition alignment = position ?? QuickDialog.instance.position;

        switch (alignment){
            case QuickDialogPosition.top:
                return MainAxisAlignment.start;
            case QuickDialogPosition.bottom:
                return MainAxisAlignment.end;
            case QuickDialogPosition.center:
                return MainAxisAlignment.center;
        }

    }


    /// 获取动画持续时间
    /// 直接返回 [QuickDialog.instance.animationDuration] 的配置值
    static Duration get animationDuration => QuickDialog.instance.animationDuration;

    /// 获取对话框圆角半径
    /// 直接返回 [QuickDialog.instance.radius] 的配置值
    static BorderRadius get radius => QuickDialog.instance.radius;

    /// 获取点击外部是否关闭对话框配置
    /// 直接返回 [QuickDialog.instance.dismissOnTap] 的配置值
    static bool? get dismissOnTap => QuickDialog.instance.dismissOnTap;

}
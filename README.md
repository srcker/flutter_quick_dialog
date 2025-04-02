# Flutter QuickDialog
> A lightweight Dialog library for Flutter, which is implemented purely in Flutter and enables you to easily call the Dialog and loading functions without the need for context. 


[![Pub Version](https://img.shields.io/pub/v/quick_dialog)](https://pub.dev/packages/flutter_quick_dialog)
[![GitHub License](https://img.shields.io/github/license/srcker/flutter_quick_dialog)](https://github.com/srcker/flutter_quick_dialog)


## Installation

Add the following code to the `pubspec.yaml` file in your project:

```yaml
dependencies:
  quick_dialog: ^latest
```

## Import

```dart
import 'package:quick_dialog/quick_dialog.dart';
```



# QuickDialog Flutter 插件

![](https://img.shields.io/badge/Flutter-3.19.5-blue) ![](https://img.shields.io/badge/Dart-3.3.0-blue) ![](https://img.shields.io/badge/license-MIT-green)

一个轻量高效的Flutter对话框解决方案，提供丰富的自定义配置和流畅的动画效果。

## 🌟 功能特性

- **多主题支持**：内置浅色/深色双主题
- **多种对话框类型**：
  - 模态对话框（Modal）
  - 半屏对话框（Half Screen）
  - 自定义组件对话框（Widget）
- **灵活动画系统**：
  - 支持透明度/位移/缩放动画
  - 可扩展自定义动画
- **智能布局**：
  - 顶部/居中/底部定位
  - 按钮水平/垂直排列
- **可定制样式**：
  - 圆角半径
  - 边距/内边距
  - 文本样式覆盖
  - 自定义遮罩颜色

## 📦 安装

在 `pubspec.yaml` 中添加：

```yaml
dependencies:
  quick_dialog: ^latest_version
```

## 🚀 快速开始

### 1. 初始化

```dart
void main() {
  runApp(MaterialApp(
    builder: QuickDialog.init(),
    home: MyApp(),
  ));
}
```

### 2. 基本使用

```dart
// 显示模态对话框
QuickDialog.showModal(
  title: "系统提示",
  content: "确认要删除这条数据吗？",
  confirmText: "确认删除",
  cancelText: "取消操作",
  confirmCallback: () => print("确认操作"),
  cancelCallback: () => print("取消操作"),
);

// 显示自定义对话框
QuickDialog.showDialog(
  child: MyCustomWidget(),
  maskType: QuickDialogMaskType.black,
  animation: QuickDialogAnimationStyle.scale,
);

// 关闭对话框
QuickDialog.dismiss();
```

## ⚙️ 参数说明


### showModal 方法参数说明

| 参数名              | 类型                                  | 说明                                                                 |
|---------------------|-------------------------------------|--------------------------------------------------------------------|
| title               | String?                             | 弹窗标题文本内容                                                     |
| content             | String?                             | 弹窗正文文本内容                                                     |
| titleTextStyle      | TextStyle?                          | 标题文本样式                                                         |
| contentTextStyle    | TextStyle?                          | 正文文本样式                                                         |
| cancelText          | String?                             | 取消按钮文本                                                         |
| confirmText         | String?                             | 确认按钮文本                                                         |
| cancelTextStyle     | TextStyle?                          | 取消按钮文本样式                                                     |
| confirmTextStyle    | TextStyle?                          | 确认按钮文本样式                                                     |
| dismissOnTap        | bool?                               | 点击遮罩层是否关闭弹窗                                               |
| contentPadding      | EdgeInsets?                         | 内容区域的内边距                                                     |
| contentMargin       | EdgeInsets?                         | 内容区域的外边距                                                     |
| radius              | BorderRadius?                       | 弹窗边框圆角半径                                                     |
| animation           | QuickDialogAnimationStyle?          | 动画样式（可选：fade\|scale\|slideUp\|slideDown\|slideLeft\|slideRight）|
| position            | QuickDialogPosition?                | 显示位置（可选：top\|center\|bottom）                                |
| maskType            | QuickDialogMaskType?                | 遮罩类型（可选：transparent\|translucent）                           |
| buttonAlignment     | QuickDialogButtonAlignment?         | 按钮排列方式（可选：left\|right\|spaceBetween）                      |
| confirmCallback     | QuickDialogConfirmCallback?         | 确认按钮点击回调（返回bool控制是否关闭弹窗）                         |
| cancelCallback      | QuickDialogCancelCallback?          | 取消按钮点击回调（返回bool控制是否关闭弹窗）                         |
| dismissCallback     | QuickDialogDismissCallback?         | 弹窗完全关闭后的回调                                                 |


### 动画类型枚举

```dart
enum QuickDialogAnimationStyle {
  opacity,    // 透明度动画
  offset,     // 位移动画
  scale,      // 缩放动画
  custom      // 自定义动画
}
```

### 遮罩类型枚举

```dart
enum QuickDialogMaskType {
  none,       // 无遮罩
  clear,      // 透明遮罩
  black,      // 黑色半透明遮罩
  custom      // 自定义遮罩
}
```

## 🎨 自定义样式

```dart
// 修改全局配置
QuickDialog.instance
  ..style = QuickDialogStyle.dark
  ..radius = BorderRadius.circular(20)
  ..animationDuration = Duration(milliseconds: 300)
  ..margin = EdgeInsets.symmetric(vertical: 50);

// 自定义按钮样式
QuickDialog.showModal(
  confirmTextStyle: TextStyle(
    color: Colors.red,
    fontWeight: FontWeight.bold
  ),
  cancelTextStyle: TextStyle(
    color: Colors.grey,
    decoration: TextDecoration.underline
  ),
);
```

## ⚠️ 注意事项

1. **必须初始化**：在 MaterialApp 中调用 `QuickDialog.init()`


## Open Source License

[MIT License](./LICENSE)

## ❤️❤️❤️


Thanks to [JetBrains Open Source](https://www.jetbrains.com/community/opensource/#support) for support
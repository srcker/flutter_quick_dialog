# Flutter QuickDialog
> A lightweight Dialog library for Flutter, which is implemented purely in Flutter and enables you to easily call the Dialog and loading functions without the need for context. 


[![Pub Version](https://img.shields.io/pub/v/quick_dialog)](https://pub.dev/packages/quick_dialog)
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
  confimText: "确认删除",
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

### showModal 方法

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
  confimTextStyle: TextStyle(
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
2. **自定义动画**：当使用 `custom` 动画时需要提供 `customAnimation` 参数
3. **状态管理**：通过 `QuickDialogStatusCallback` 监听对话框状态变化
4. **性能优化**：长列表内容建议使用 `ListView.builder`


## Open Source License

[MIT License](./LICENSE)

## ❤️❤️❤️


Thanks to [JetBrains Open Source](https://www.jetbrains.com/community/opensource/#support) for support
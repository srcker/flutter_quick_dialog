import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../theme.dart';
import '../quick_dialog.dart';

T? _ambiguate<T>(T? value) => value;

class QuickDialogContainer extends StatefulWidget {
    // 指示器组件
    final Widget indicator;
    // 显示的状态文本
    final String? status;
    // 点击时是否自动消失
    final bool? dismissOnTap;
   
    // 提示框的类型
    final QuickDialogType? type;

     // 提示框的位置
    final QuickDialogPosition? position;

    // 遮罩的类型
    final QuickDialogMaskType? maskType;

    // 完成器，用于完成异步操作
    final Completer<void>? completer;

    // 是否启用动画效果
    final bool animation;


    final QuickDialogDismissCallback? dismissCallback;



    const QuickDialogContainer({
        super.key,
        required this.indicator,
        this.type,
        this.status,
        this.dismissOnTap,
        this.maskType,
        this.position,
        this.completer,
        this.dismissCallback,
        this.animation = true,
    });

    // 创建对应的 State 对象
    @override
    QuickDialogContainerState createState() => QuickDialogContainerState();
}

class QuickDialogContainerState extends State<QuickDialogContainer> with SingleTickerProviderStateMixin {

    String? _status;

    Color? _maskColor;

    late AnimationController _animationController;

    late bool _dismissOnTap, _ignoring;

    late AlignmentGeometry _alignment;


    // 判断当前调度器是否处于持续回调阶段
    bool get isPersistentCallbacks => _ambiguate(SchedulerBinding.instance)!.schedulerPhase == SchedulerPhase.persistentCallbacks;

    @override
    void initState() {
        super.initState();
        if (!mounted) return;

        // 获取是否在点击时关闭
        _dismissOnTap = _getDismissOnTap();
         // 获取是否忽略点击事件
        _ignoring = _getIgnoring();
         // 获取是否忽略点击事件
        _maskColor = _getMaskColor();
         // 获取对齐方式
        _alignment = _getAlignment();


        print("当前动画 $_alignment");
        
         // 添加动画状态监听器
        _animationController = AnimationController(vsync: this, duration: QuickDialogTheme.animationDuration)..addStatusListener(_onAnimationStatusChanged);
        show(widget.animation);
    }

    // 获取是否在点击时关闭
    bool _getDismissOnTap() {
        return widget.dismissOnTap ?? (QuickDialogTheme.dismissOnTap ?? false);
    }

    // 获取是否忽略点击事件
    bool _getIgnoring() {
        return _dismissOnTap ? false : true;
    }

    // 获取遮罩颜色
    Color? _getMaskColor() {
        return QuickDialogTheme.maskColor(widget.maskType);
    }

    AlignmentGeometry _getAlignment() {
        switch(widget.position){
            case QuickDialogPosition.bottom:
                return AlignmentDirectional.bottomCenter;
            case QuickDialogPosition.top:
                return AlignmentDirectional.topCenter;
            case QuickDialogPosition.center:
            case null:
                return AlignmentDirectional.center;
        }
    }

    // 动画状态改变时的处理逻辑
    void _onAnimationStatusChanged(AnimationStatus status) {
        if (status == AnimationStatus.completed && !(widget.completer?.isCompleted ?? false)) {
            widget.completer?.complete();
        }
    }


    // 显示动画
    Future<void> show(bool animation) {
        if (isPersistentCallbacks) {
            return _postFrameCallback(() => _animationController.forward(from: animation ? 0 : 1));
        } else {
            return _animationController.forward(from: animation ? 0 : 1);
        }
    }

    // 关闭动画
    Future<void> dismiss(bool animation) {
        if (isPersistentCallbacks) {
            return _postFrameCallback(() => _animationController.reverse(from: animation ? 1 : 0));
        } else {
            return _animationController.reverse(from: animation ? 1 : 0);
        }
    }

    // 更新状态
    void updateStatus(String status) {
        if (_status == status) return;
        setState(() => _status = status);
    }

    // 在下一帧回调中执行操作
    Future<void> _postFrameCallback(VoidCallback callback) {
        Completer<void> completer = Completer<void>();
        _ambiguate(SchedulerBinding.instance)!.addPostFrameCallback((_) {
            callback();
            completer.complete();
        });
        return completer.future;
    }

    // 点击事件处理
    void _onTap() async {
        if (_dismissOnTap){
            await QuickDialog.dismiss();
            widget.dismissCallback?.call();
        }
    }

      // 构建遮罩容器
    Widget _buildMaskContainer() {
        return Container(
            width: double.infinity,
            height: double.infinity,
            color: _maskColor,
        );
    }

    @override
    Widget build(BuildContext context) {
        return Stack(
            children: <Widget>[
                AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) => Opacity(
                        opacity: _animationController.value,
                        child: IgnorePointer(
                            ignoring: _ignoring,
                            child: _dismissOnTap
                                ? GestureDetector(
                                    onTap: _onTap,
                                    behavior: HitTestBehavior.translucent,
                                    child: _buildMaskContainer(),
                                )
                                : _buildMaskContainer(),
                        ),
                    ),
                ),
                AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) => QuickDialogTheme.loadingAnimation.buildWidget(
                        widget.indicator,
                        _animationController,
                        _alignment
                    ),
                ),
            ],
        );
    }



    @override
    void dispose() {
        _animationController.dispose(); // 释放动画控制器
        super.dispose();
    }

  
}



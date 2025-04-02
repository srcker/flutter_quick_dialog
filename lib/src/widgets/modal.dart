import 'package:flutter/material.dart';

import '../quick_dialog.dart';
import '../theme.dart';

/// 
class QuickDialogModal extends StatefulWidget {

    final String? title;
    final String? content;
    final TextStyle? titleTextStyle;
    final TextStyle? contentTextStyle;
    final String? cancelText;
    final String? confirmText;
    final TextStyle? cancelTextStyle;
    final TextStyle? confirmTextStyle;
    final bool? dismissOnTap;
    final EdgeInsets? contentPadding;
    final EdgeInsets? contentMargin;
    final BorderRadius? radius;
    final QuickDialogPosition? position;
    final QuickDialogButtonAlignment? buttonAlignment;
    final QuickDialogConfirmCallback? confirmCallback;
    final QuickDialogCancelCallback? cancelCallback;
    final QuickDialogDismissCallback? dismissCallback;

    const QuickDialogModal({
        super.key,
        this.title,
        this.content,
        this.titleTextStyle,
        this.contentTextStyle,
        this.cancelText,
        this.confirmText,
        this.cancelTextStyle,
        this.confirmTextStyle,
        this.dismissOnTap,
        this.contentPadding,
        this.contentMargin,
        this.radius,
        this.position,
        this.buttonAlignment = QuickDialogButtonAlignment.horizontal,
        this.confirmCallback,
        this.cancelCallback,
        this.dismissCallback,
    });
        
    @override
    State<StatefulWidget> createState() => _QuickDialogModalState();
        
}

class _QuickDialogModalState extends State<QuickDialogModal>{

    late bool dismissOnTap;


    @override
    void initState() {
        super.initState();
        dismissOnTap = widget.dismissOnTap ?? (QuickDialog.instance.dismissOnTap ?? false);
    }


    @override
    Widget build(BuildContext context) {
        return Column(
            mainAxisAlignment: QuickDialogTheme.alignment(widget.position),
            children: [
                Container(
                    margin: widget.contentMargin ?? QuickDialogTheme.contentMargin,
                    padding: widget.contentPadding ?? QuickDialogTheme.contentPadding,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                        color: QuickDialogTheme.backgroud,
                        borderRadius: widget.radius ?? QuickDialogTheme.radius
                    ),
                    child: Column(
                        children: [

                            Visibility(
                                visible: widget.title != null,
                                child: Padding(
                                    padding: const EdgeInsets.only(top: 32, left: 24, right: 24, bottom: 16),
                                    child: Text(widget.title.toString(), style: widget.titleTextStyle ?? QuickDialogTheme.titleTextStyle),
                                ),
                            ),

                            Visibility(
                                visible: widget.content != null,
                                child: Padding(
                                    padding: const EdgeInsets.only(left: 24, right: 24, bottom: 16),
                                    child: Text(widget.content.toString(), style: widget.contentTextStyle ?? QuickDialogTheme.contentTextStyle),
                                ),
                            ),

                            buttons(dismissOnTap)

                        ],
                    ),
                ),
            ],
        );
    }


    Widget buttons(bool dismissOnTap){

        if(widget.buttonAlignment == QuickDialogButtonAlignment.horizontal){
            return Container(
                height: 65,
                decoration: BoxDecoration(
                    border: Border(top: BorderSide(width: QuickDialogTheme.lineWidth, color: QuickDialogTheme.lineColor)),
                ),
                child: Flex(
                    direction: Axis.horizontal,
                    children: [
                        if(widget.cancelText != null)
                            Flexible(
                                fit: FlexFit.tight,
                                child: MaterialButton(
                                    onPressed: () async {
                                        if(dismissOnTap){
                                           await QuickDialog.dismiss();
                                           widget.dismissCallback?.call();
                                        }
                                        widget.cancelCallback?.call();
                                    },
                                    height: 64,
                                    color: QuickDialogTheme.backgroud,
                                    elevation: 0,
                                    child: Text(widget.cancelText.toString(), style: widget.cancelTextStyle ?? QuickDialogTheme.cancelTextStyle),
                                )
                            ),

                        Visibility(
                            visible: widget.cancelText != null && widget.confirmText != null,
                            child: Container(
                                width: QuickDialogTheme.lineWidth,
                                height: 64,
                                color: QuickDialogTheme.lineColor
                            ),
                        ),

                        if(widget.confirmText != null)
                                Flexible(
                                    fit: FlexFit.tight,
                                    child: MaterialButton(
                                        onPressed: () async {
                                            if(dismissOnTap){
                                                await QuickDialog.dismiss();
                                                widget.dismissCallback?.call();
                                            }
                                            widget.confirmCallback?.call();
                                        },
                                        height: 64,
                                        color: QuickDialogTheme.backgroud,
                                        elevation: 0,
                                        child: Text(widget.confirmText.toString(), style: widget.confirmTextStyle ?? QuickDialogTheme.confirmTextStyle),
                                    ),
                                ),

                    ],
                ),
            );
        }else{
            return Container(
                decoration: BoxDecoration(
                    border: Border(top: BorderSide(width: QuickDialogTheme.lineWidth, color: QuickDialogTheme.lineColor)),
                ),
                child: Flex(
                    direction: Axis.vertical,
                    children: [
                        

                        if(widget.confirmText != null)
                            Row(
                                children: [
                                    Expanded(child: MaterialButton(
                                        onPressed: () async {
                                            if(dismissOnTap){
                                                await QuickDialog.dismiss();
                                                widget.dismissCallback?.call();
                                            }
                                            widget.confirmCallback?.call();
                                        },
                                        height: 64,
                                        color: QuickDialogTheme.backgroud,
                                        elevation: 0,
                                        child: Text(widget.confirmText.toString(), style: widget.confirmTextStyle ?? QuickDialogTheme.confirmTextStyle),
                                    ))
                                ],
                            ),

                        Visibility(
                            visible: widget.cancelText != null && widget.confirmText != null,
                            child: Container(
                                height: QuickDialogTheme.lineWidth,
                                color: QuickDialogTheme.lineColor
                            ),
                        ),

                        if(widget.cancelText != null)
                            Row(
                                children: [
                                    Expanded(child: MaterialButton(
                                        onPressed: () async {
                                            if(dismissOnTap){
                                                await QuickDialog.dismiss();
                                                widget.dismissCallback?.call();
                                            }
                                            widget.cancelCallback?.call();
                                        },
                                        height: 64,
                                        color: QuickDialogTheme.backgroud,
                                        elevation: 0,
                                        child: Text(widget.cancelText.toString(), style: widget.cancelTextStyle ?? QuickDialogTheme.cancelTextStyle),
                                    ))
                                ],
                            ),

                    ],
                ),
            );
        }


    }

}
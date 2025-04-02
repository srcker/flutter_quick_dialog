// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../quick_dialog.dart';
import '../theme.dart';

/// 
class QuickDialogModal extends StatefulWidget {

    String? title;
    String? content;
    TextStyle? titleTextStyle;
    TextStyle? contentTextStyle;
    String? cancelText;
    String? confimText;
    TextStyle? cancelTextStyle;
    TextStyle? confimTextStyle;
    bool? dismissOnTap;
    EdgeInsets? contentPadding;
    EdgeInsets? contentMargin;
    BorderRadius? radius;
    QuickDialogPosition? position;
    QuickDialogButtonAlignment? buttonAlignment;
    QuickDialogConfirmCallback? confirmCallback;
    QuickDialogCancelCallback? cancelCallback;

    QuickDialogModal({
        super.key,
        this.title,
        this.content,
        this.titleTextStyle,
        this.contentTextStyle,
        this.cancelText,
        this.confimText,
        this.cancelTextStyle,
        this.confimTextStyle,
        this.dismissOnTap,
        this.contentPadding,
        this.contentMargin,
        this.buttonAlignment = QuickDialogButtonAlignment.horizontal,
        this.confirmCallback,
        this.cancelCallback,
        this.position,
        this.radius,
    });
        
    @override
    State<StatefulWidget> createState() => QuickDialogModalState();
        
}

class QuickDialogModalState extends State<QuickDialogModal>{

    bool? dismissOnTap;


    @override
    void initState() {
        super.initState();
        dismissOnTap = widget.dismissOnTap ?? QuickDialog.instance.dismissOnTap;
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

                            buttons()

                        ],
                    ),
                ),
            ],
        );
    }


    Widget buttons(){

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
                                    onPressed: () => widget.cancelCallback?.call(),
                                    height: 64,
                                    color: QuickDialogTheme.backgroud,
                                    elevation: 0,
                                    child: Text(widget.cancelText.toString(), style: widget.cancelTextStyle ?? QuickDialogTheme.cancelTextStyle),
                                )
                            ),

                        Visibility(
                            visible: widget.cancelText != null && widget.confimText != null,
                            child: Container(
                                width: QuickDialogTheme.lineWidth,
                                height: 64,
                                color: QuickDialogTheme.lineColor
                            ),
                        ),

                        if(widget.confimText != null)
                                Flexible(
                                    fit: FlexFit.tight,
                                    child: MaterialButton(
                                        onPressed: () => widget.confirmCallback?.call(),
                                        height: 64,
                                        color: QuickDialogTheme.backgroud,
                                        elevation: 0,
                                        child: Text(widget.confimText.toString(), style: widget.confimTextStyle ?? QuickDialogTheme.confirmTextStyle),
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
                        

                        if(widget.confimText != null)
                            Row(
                                children: [
                                    Expanded(child: MaterialButton(
                                        onPressed: () => widget.confirmCallback?.call(),
                                        height: 64,
                                        color: QuickDialogTheme.backgroud,
                                        elevation: 0,
                                        child: Text(widget.confimText.toString(), style: widget.confimTextStyle ?? QuickDialogTheme.confirmTextStyle),
                                    ))
                                ],
                            ),

                        Visibility(
                            visible: widget.cancelText != null && widget.confimText != null,
                            child: Container(
                                height: QuickDialogTheme.lineWidth,
                                color: QuickDialogTheme.lineColor
                            ),
                        ),

                        if(widget.cancelText != null)
                            Row(
                                children: [
                                    Expanded(child: MaterialButton(
                                        onPressed: () => widget.cancelCallback?.call(),
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
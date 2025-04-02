import 'package:flutter/material.dart';

import '../quick_dialog.dart';
import './overlay_entry.dart';


class QuickDialogLoading extends StatefulWidget {
    final Widget? child;

    const QuickDialogLoading({super.key, required this.child, })  : assert(child != null);
    
    @override
    State<StatefulWidget> createState() =>  _QuickDialogLoadingState();

}

class _QuickDialogLoadingState extends State<QuickDialogLoading> {

    late QuickDialogOverlayEntry _overlayEntry;

    @override
    void initState() {
    super.initState();
        _overlayEntry = QuickDialogOverlayEntry(
            builder: (BuildContext context) => QuickDialog.instance.w ?? Container(),
        );
        QuickDialog.instance.overlayEntry = _overlayEntry;
    }

    @override
    Widget build(BuildContext context) {
        return Material(
            child: Overlay(
                initialEntries: [
                    QuickDialogOverlayEntry(
                        builder: (BuildContext context) {
                            if (widget.child != null) {
                                return widget.child!;
                            } else {
                                return Container();
                            }
                        },
                    ),
                    _overlayEntry,
                ],
            ),
        );
    }
}

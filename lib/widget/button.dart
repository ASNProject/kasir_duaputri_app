// Copyright 2023 ariefsetyonugroho
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class ButtonOptions {
  const ButtonOptions({
    this.textStyle,
    this.elevation,
    this.height,
    this.width,
    this.padding,
    this.color,
    this.disabledColor,
    this.disabledTextColor,
    this.splashColor,
    this.iconSize,
    this.iconColor,
    this.iconPadding,
    this.borderRadius,
    this.borderSide,
  });

  final TextStyle? textStyle;
  final double? elevation;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final Color? disabledColor;
  final Color? disabledTextColor;
  final Color? splashColor;
  final double? iconSize;
  final Color? iconColor;
  final EdgeInsetsGeometry? iconPadding;
  final BorderRadius? borderRadius;
  final BorderSide? borderSide;
}

class MyButtonWidget extends StatefulWidget {
  const MyButtonWidget({
    Key? key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.iconData,
    required this.options,
    this.showLoadingIndicator = true,
  }) : super(key: key);

  final String text;
  final Widget? icon;
  final IconData? iconData;
  final Function() onPressed;
  final ButtonOptions options;
  final bool showLoadingIndicator;

  @override
  State<MyButtonWidget> createState() => _MyButtonWidgetState();
}

class _MyButtonWidgetState extends State<MyButtonWidget> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    Widget textWidget = loading
        ? Center(
            child: Container(
              width: 23,
              height: 23,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  widget.options.textStyle!.color ?? Colors.white,
                ),
              ),
            ),
          )
        : AutoSizeText(
            widget.text,
            style: widget.options.textStyle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          );

    final onPressed = widget.showLoadingIndicator
        ? () async {
            if (loading) {
              return;
            }
            setState(() => loading = true);
            try {
              await widget.onPressed();
            } finally {
              if (mounted) {
                setState(() => loading = false);
              }
            }
          }
        : () => widget.onPressed();

    ButtonStyle style = ButtonStyle(
      shape: MaterialStateProperty.all<OutlinedBorder>(
        RoundedRectangleBorder(
          borderRadius:
              widget.options.borderRadius ?? BorderRadius.circular(8.0),
          side: widget.options.borderSide ?? BorderSide.none,
        ),
      ),
      foregroundColor: MaterialStateProperty.resolveWith<Color?>(
        (states) {
          if (states.contains(MaterialState.disabled)) {
            return widget.options.disabledTextColor;
          }
          return widget.options.textStyle!.color;
        },
      ),
      backgroundColor: MaterialStateProperty.resolveWith<Color?>(
        (states) {
          if (states.contains(MaterialState.disabled)) {
            return widget.options.disabledColor;
          }
          return widget.options.color;
        },
      ),
      overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
        if (states.contains(MaterialState.pressed)) {
          return widget.options.splashColor;
        }
        return null;
      }),
      padding: MaterialStateProperty.all(widget.options.padding ??
          const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0)),
      elevation:
          MaterialStateProperty.all<double>(widget.options.elevation ?? 2.0),
    );

    if (widget.icon != null || widget.iconData != null) {
      return Container(
        height: widget.options.height,
        width: widget.options.width,
        child: ElevatedButton.icon(
          icon: Padding(
            padding: widget.options.iconPadding ?? EdgeInsets.zero,
            child: widget.icon ??
                Icon(
                  widget.iconData,
                  size: widget.options.iconSize,
                  color: widget.options.iconColor ??
                      widget.options.textStyle!.color,
                ),
          ),
          label: textWidget,
          onPressed: onPressed,
          style: style,
        ),
      );
    }

    return Container(
      height: widget.options.height,
      width: widget.options.width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: style,
        child: textWidget,
      ),
    );
  }
}
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

import 'package:flutter/material.dart';

class CountController extends StatefulWidget {
  const CountController({
    Key? key,
    required this.decrementIconBuilder,
    required this.incrementIconBuilder,
    required this.countBuilder,
    required this.count,
    required this.updateCount,
    this.stepSize = 1,
    this.minimum,
    this.maximum,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 25.0),
  }) : super(key: key);

  final Widget Function(bool enabled) decrementIconBuilder;
  final Widget Function(bool enabled) incrementIconBuilder;
  final Widget Function(int count) countBuilder;
  final int count;
  final Function(int) updateCount;
  final int stepSize;
  final int? minimum;
  final int? maximum;
  final EdgeInsetsGeometry contentPadding;

  @override
  _CountControllerState createState() => _CountControllerState();
}

class _CountControllerState extends State<CountController> {
  int get count => widget.count;
  int? get minimum => widget.minimum;
  int? get maximum => widget.maximum;
  int get stepSize => widget.stepSize;

  bool get canDecrement => minimum == null || count - stepSize >= minimum!;
  bool get canIncrement => maximum == null || count + stepSize <= maximum!;

  void _decrementCounter() {
    if (canDecrement) {
      setState(() => widget.updateCount(count - stepSize));
    }
  }

  void _incrementCounter() {
    if (canIncrement) {
      setState(() => widget.updateCount(count + stepSize));
    }
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: widget.contentPadding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: _decrementCounter,
              child: widget.decrementIconBuilder(canDecrement),
            ),
            widget.countBuilder(count),
            InkWell(
              onTap: _incrementCounter,
              child: widget.incrementIconBuilder(canIncrement),
            ),
          ],
        ),
      );
}

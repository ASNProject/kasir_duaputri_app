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

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kasir_duaputri_app/presentation/product_list_widget.dart';
import 'package:responsive_grid/responsive_grid.dart';

class TransaksiScreen extends StatefulWidget {
  const TransaksiScreen({super.key});

  @override
  State<TransaksiScreen> createState() => _TransaksiScreenState();
}

class _TransaksiScreenState extends State<TransaksiScreen> {
  final List<String> items = [
    'Avian',
    'Paku',
    'Bendrat',
    'Usuk',
    'Kawat',
    'Semen',
    'Besi',
    'Lampu',
  ];

  String? selectedValue;
  final TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Align(
              alignment: Alignment.topRight,
              child: Text(
                '26 April 2023',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
            ResponsiveGridRow(children: [
              ResponsiveGridCol(lg: 6, child: ProductListWidget()),
              ResponsiveGridCol(
                  lg: 6,
                  child: Container(
                    color: Colors.red,
                    height: MediaQuery.of(context).size.height,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                    ),
                  )),
            ])
          ],
        ),
      ),
    );
  }
}

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
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kasir_duaputri_app/presentation/product_detail_widget.dart';
import 'package:kasir_duaputri_app/widget/product_tile_animation.dart';

import '../bloc/cart_bloc.dart';
import '../bloc/state/cart_state.dart';
import '../models/product.dart';
import 'product_tile.dart';

class ProductList extends StatelessWidget {
  const ProductList({super.key, required this.products});

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(builder: (_, cartState) {
      bool isGridView = cartState.isGridView;
      if (isGridView) {
        return LayoutBuilder(builder: (context, constraints) {
          return GridView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) => ProductTileAnimation(
              itemNo: index,
              product: products[index],
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: constraints.maxWidth > 100 ? 4 : 2,
              childAspectRatio: 1,
            ),
          );
        });
      } else {
        return ListView.builder(
            itemCount: products.length,
            itemBuilder: (BuildContext context, int index) {
              return ProductTileAnimation(
                itemNo: index,
                product: products[index],
              );
            });
      }
    });

    return LayoutBuilder(builder: (context, constraints) {
      return GridView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailWidget(
                  product: products[index],
                ),
              ),
            );
          },
          child: ProductTile(
            itemNo: index,
            product: products[index],
          ),
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
        ),
      );
    });
  }
}

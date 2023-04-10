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

import '../../models/product.dart';

abstract class CartState {
  final List<Product> cartItem;
  final bool isGridView;
  const CartState({this.cartItem = const [], this.isGridView = true});

  @override
  List<Object> get props => [];
}

class CartLoadInProgress extends CartState {
  CartLoadInProgress({required super.cartItem});
}

class ProductAdded extends CartState {
  final List<Product> cartItem;

  const ProductAdded({required this.cartItem}) : super(cartItem: cartItem);

  @override
  List<Object> get props => [cartItem];

  @override
  String toString() => 'ProductAdded { todos: $cartItem }';
}

class ProductRemoved extends CartState {
  final List<Product> cartItem;

  const ProductRemoved({required this.cartItem}) : super(cartItem: cartItem);

  @override
  List<Object> get props => [cartItem];

  @override
  String toString() => 'ProductRemoved { todos: $cartItem }';
}

class ChangeGallaryViewState extends CartState {
  final isGridView;

  const ChangeGallaryViewState({required this.isGridView})
      : super(isGridView: isGridView);

  @override
  List<Object> get props => [isGridView];
}

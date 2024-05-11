import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocey_app/features/cart/bloc/cart_bloc.dart';
import 'package:grocey_app/features/cart/ui/cart_tile_widget.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  void initState() {
    cartBloc.add(CartInitialEvent());
    super.initState();
  }

  final CartBloc cartBloc = CartBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart Items",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500)),
         backgroundColor: Colors.teal,
      ),
      body: BlocConsumer<CartBloc, CartState>(
        bloc: cartBloc,
        listener: (context, state) {},
        listenWhen: (previous, current) => current is CartActionState,
        buildWhen: (previous, current) => current is !CartActionState,
        builder: (context, state) {
          switch (state.runtimeType) {
            case CartSuccessState:
              final successState=state as CartSuccessState;
             return ListView.builder(
              itemCount: successState.cartItems.length,
              itemBuilder: (context,index){
               return  CartTileWidget(productDataModel: successState.cartItems[index], cartBloc: cartBloc);
             });
            default:
          }
          return Container();
        },
      ),
    );
  }
}

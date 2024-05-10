import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocey_app/features/cart/ui/cart_screen.dart';
import 'package:grocey_app/features/home/bloc/home_bloc.dart';
import 'package:grocey_app/features/home/ui/product_tile_widget.dart';
import 'package:grocey_app/features/wishlist/ui/wishlist_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }
  final HomeBloc homeBloc = HomeBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeNavigateToCartPageActionState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const Cart()));
        } else if (state is HomeNavigateToWishlistPageActionState) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Wishlist()));
        }
        else if(state is HomeProductItemWishListedActionState){
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Product added to the wishlist")));
        }
         else if(state is HomeProductItemCartedActionState){
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Product added to the cart")));
        }
       
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return const Scaffold(
              body: Center(child: CircularProgressIndicator(),),
            );
           
          case HomeLoadedSucessState:
          final successState= state as HomeLoadedSucessState;
            return Scaffold(
            appBar: AppBar(
            title: const Text("Grocery App",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),),
            backgroundColor: Colors.teal,
            actions: [
              IconButton(
                  onPressed: () {
                    homeBloc.add(HomeWishlistButtonNavigateClickedEvent());
                  },
                  icon: const Icon(Icons.favorite_border,color: Colors.white,)),
              IconButton(
                  onPressed: () {
                    homeBloc.add(HomeCartButtonNavigateClickedEvent());
                  },
                  icon: const Icon(Icons.shopping_bag_outlined,color: Colors.white)),
            ],
          ),
          body: ListView.builder(
            itemCount: successState.products.length,
            itemBuilder: (context,index){
            return ProductTileWidget(
              homeBloc: homeBloc,
              productDataModel: successState.products[index]);
          }),
        );
          case HomeErrorState:
          return const Scaffold(body: Center(child: Text("Error"),),);
          default:
          return const SizedBox();
        }
      },
    );
  }
}


  
import 'package:flutter/material.dart';
import 'package:grocey_app/data/wishlist_items.dart';
import 'package:grocey_app/features/home/models/home_product_data_model.dart';
import 'package:grocey_app/features/wishlist/bloc/wishlist_bloc.dart';

class WishlistTileWidget extends StatelessWidget {
  final ProductDataModel productDataModel;
  final WishlistBloc wishlistBloc;

  const WishlistTileWidget({super.key, required this.productDataModel, required this.wishlistBloc});


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:  BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10.0),


      ),
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(10.0),
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Container(
            height: 200,
            width: double.maxFinite,
             decoration: BoxDecoration(
              
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(productDataModel.imageUrl))
             ),
          ),
          const SizedBox(height:20),
          Text(productDataModel.name,style: const TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold
          ),),
          Text(productDataModel.description),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text( "\$ ${productDataModel.price}",style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold
              ),),
              Row(
                children: [
                   IconButton(
                  onPressed: () {
                   wishlistBloc.add(WishlistRemoveEvent(productDataModel: productDataModel));
                  },
                  icon: const Icon(Icons.favorite,color: Colors.black,)),
              // IconButton(
              //     onPressed: () {
              //     cartBloc.add(CartRemoveEvent(productDataModel: productDataModel));
              //     },
              //     icon: const Icon(Icons.shopping_bag,color: Colors.black)),
                ],
              ),
            ],
          ),
           
        ],
      ),
    );
  }
}
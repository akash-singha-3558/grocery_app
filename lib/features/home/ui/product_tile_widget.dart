import 'package:flutter/material.dart';
import 'package:grocey_app/features/home/bloc/home_bloc.dart';
import 'package:grocey_app/features/home/models/home_product_data_model.dart';

class ProductTileWidget extends StatelessWidget {
  final ProductDataModel productDataModel;
  final HomeBloc homeBloc;
  const ProductTileWidget({super.key, required this.productDataModel, required this.homeBloc});

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
                     homeBloc.add(HomeProductWishlistButtonClickedEvent(
                      clickedProduct: productDataModel
                     ));
                  },
                  icon: const Icon(Icons.favorite_border,color: Colors.black,)),
              IconButton(
                  onPressed: () {
                     homeBloc.add(HomeProductCartButtonClickedEvent(
                      clickedProduct: productDataModel
                     ));
                  },
                  icon: const Icon(Icons.shopping_bag_outlined,color: Colors.black)),
                ],
              ),
            ],
          ),
           
        ],
      ),
    );
  }
}
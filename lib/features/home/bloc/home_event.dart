part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class HomeInitialEvent extends HomeEvent{
  
}

class HomeProductWishlistButtonClickedEvent extends HomeEvent{

}

class HomeProductCartButtonClickedEvent extends HomeEvent{
  
}

class HomeWishlistButtonNavigateClickedEvent extends HomeEvent{
  
}

class HomeCartButtonNavigateClickedEvent extends HomeEvent{
  
}
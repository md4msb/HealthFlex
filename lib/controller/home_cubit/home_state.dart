part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class LoadingState extends HomeState {}

class LoadedState extends HomeState {}

class ErrorState extends HomeState {}

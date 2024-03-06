import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helthflex_giphy/repository/home_repository.dart';

import '../../model/giphy_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  final _homeRepo = HomeRepository();

  List<Gif> trendingGifs = [];

  void getTrendingGifs({int limit = 25, int offset = 1}) async {
    emit(LoadingState());

    final giphyModel =  await _homeRepo.readTrendingGiphy(limit, offset);
    if (giphyModel != null) {
      trendingGifs.addAll(giphyModel.gifs ?? []);
      log('[count] ${giphyModel.pagination?.count}');
    }
    emit(LoadedState());
  }
}

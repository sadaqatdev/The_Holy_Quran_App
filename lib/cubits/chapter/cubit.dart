import 'dart:async';

import 'package:al_quran/models/ayah/ayah.dart';
import 'package:al_quran/screens/page/quran_repo.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

part 'state.dart';

class ChapterCubit extends Cubit<ChapterState> {
  //

  static ChapterCubit cubit(BuildContext context, [bool listen = false]) =>
      BlocProvider.of<ChapterCubit>(context, listen: listen);

  ChapterCubit() : super(const ChapterDefault(data: []));

  final repo = QuranRepo();

  Future<void> fetchAys(id) async {
    //

    emit(AyaLoading());

    try {
      //

      List<Ayah?>? cached = await repo.getQuranBySuraId(id);

      if (cached.isNotEmpty) {
        //

        emit(AyaFetchSuccess(data: cached));
      } else {
        emit(AyaFetchFailed(message: "Erorr in getting Suras"));
      }
    } catch (e) {
      print("Error in fetchig $e ");
      emit(AyaFetchFailed(message: e.toString()));
    }
  }
}

import 'dart:async';

import 'package:al_quran/screens/page/quran_repo.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:al_quran/models/juz/juz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'state.dart';

class JuzCubit extends Cubit<JuzState> {
  static JuzCubit cubit(BuildContext context, [bool listen = false]) =>
      BlocProvider.of<JuzCubit>(context, listen: listen);

  JuzCubit() : super(JuzDefault());

  final repo = QuranRepo();

  Future<void> fetchJuz() async {
    emit(const JuzFetchLoading());

    try {
      List<Juz>? cached = await repo.getParasJuz();

      if (cached.isNotEmpty) {
        emit(JuzFetchSuccess(data: cached));
      } else {
        emit(JuzFetchSuccess(data: cached));
      }
    } catch (e) {
      print("Error in quran fetch $e");
      emit(JuzFetchFailed(message: e.toString()));
    }
  }
}

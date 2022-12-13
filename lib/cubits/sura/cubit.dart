import 'dart:async';
import 'package:al_quran/models/ayah/ayah.dart';
import 'package:al_quran/screens/page/quran_repo.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:al_quran/models/chapter/sura_name.dart';
part 'state.dart';

class SurasCubit extends Cubit<SurasState> {
  //

  static SurasCubit cubit(BuildContext context, [bool listen = false]) =>
      BlocProvider.of<SurasCubit>(context, listen: listen);

  SurasCubit() : super(const SurasDefault());

  final repo = QuranRepo();

  Future<void> fetchSuras() async {
    //

    emit(const SurasFetchLoading());

    try {
      List<SuraName?>? cached = await repo.getSuras();

      print("Suras lenght ${cached.length}");

      if (cached.isNotEmpty) {
        //
        print("Sura lenght ${cached.length}");
        cached.sort((a, b) => a!.surah_no.compareTo(b!.surah_no));
        emit(SurasFetchSuccess(data: cached));
      } else {
        emit(const SurasFetchFailed(message: "Erorr in getting Suras"));
      }
    } catch (e) {
      print("Eror3 $e");
      emit(SurasFetchFailed(message: e.toString()));
    }
  }
}

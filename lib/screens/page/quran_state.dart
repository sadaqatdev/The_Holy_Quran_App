import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum QuranState { loading, loaded, error }

class QuranCubit extends Cubit<QuranState> {
  QuranCubit() : super(QuranState.loading);

  static QuranCubit cubit(BuildContext context, [bool listen = false]) =>
      BlocProvider.of<QuranCubit>(context, listen: listen);

  Future<void> fetchQuran() async {
    //

    //
  }
}

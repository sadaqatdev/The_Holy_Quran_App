import 'package:al_quran/models/chapter/sura_name.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

part 'state.dart';
part 'data_provider.dart';

class BookmarkCubit extends Cubit<BookmarkState> {
  static BookmarkCubit cubit(BuildContext context, [bool listen = false]) =>
      BlocProvider.of<BookmarkCubit>(context, listen: listen);

  BookmarkCubit() : super(BookmarkDefault());

  Future<void> fetch() async {
    emit(const BookmarkFetchLoading());
    try {
      List<SuraName?>? data = await BookmarksDataProvider.fetch();

      emit(BookmarkFetchSuccess(data: data, isBookmarked: false));
    } catch (e) {
      emit(BookmarkFetchFailed(message: e.toString()));
    }
  }

  Future<void> updateBookmark(SuraName chapter, bool add) async {
    emit(const BookmarkFetchLoading());
    try {
      List<SuraName?>? data = [];
      if (add) {
        data = await BookmarksDataProvider.addBookmark(chapter);
      } else {
        data = await BookmarksDataProvider.removeBookmark(chapter);
      }
      emit(
        BookmarkFetchSuccess(data: data, isBookmarked: add),
      );
    } catch (e) {
      emit(BookmarkFetchFailed(message: e.toString()));
    }
  }

  Future<void> checkBookmarked(SuraName chapter) async {
    emit(const BookmarkFetchLoading());
    try {
      final isBookmarked = await BookmarksDataProvider.checkBookmarked(chapter);
      final data = await BookmarksDataProvider.fetch();
      emit(
        BookmarkFetchSuccess(
          data: data,
          isBookmarked: isBookmarked ?? false,
        ),
      );
    } catch (e) {
      emit(BookmarkFetchFailed(message: e.toString()));
    }
  }
}

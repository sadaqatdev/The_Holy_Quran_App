part of 'cubit.dart';

class BookmarksDataProvider {
  static final cache = Hive.box('data');

  static Future<List<SuraName?>?> fetch() async {
    try {
      List? bookmarks = await cache.get('bookmarks');
      if (bookmarks == null) {
        bookmarks = <SuraName?>[];
        await cache.put('bookmarks', bookmarks);
      }

      final List<SuraName?>? cachedBookmarks = List.from(bookmarks);
      return cachedBookmarks;
    } catch (e) {
      throw Exception("Internal Server Error");
    }
  }

  static Future<List<SuraName?>?> addBookmark(SuraName? chapter) async {
    try {
      List? bookmarks = await cache.get('bookmarks');
      if (bookmarks == null) {
        bookmarks = <SuraName?>[];
        await cache.put('bookmarks', bookmarks);
      }

      final List<SuraName?>? updatedBookmarks = List.from(bookmarks);
      updatedBookmarks!.add(chapter);

      await cache.put('bookmarks', updatedBookmarks);
      return updatedBookmarks;
    } catch (e) {
      throw Exception("Internal Server Error");
    }
  }

  static Future<List<SuraName?>?> removeBookmark(SuraName? chapter) async {
    try {
      List bookmarks = await cache.get('bookmarks');

      final List<SuraName?>? updatedBookmarks = List.from(bookmarks);
      updatedBookmarks!.remove(chapter);

      await cache.put('bookmarks', updatedBookmarks);
      return updatedBookmarks;
    } catch (e) {
      throw Exception("Internal Server Error");
    }
  }

  static Future<bool?> checkBookmarked(SuraName? chapter) async {
    try {
      List bookmarks = await cache.get('bookmarks');

      final List<SuraName?>? updatedBookmarks = List.from(bookmarks);
      return updatedBookmarks!.contains(chapter);
    } catch (e) {
      throw Exception("Internal Server Error");
    }
  }
}

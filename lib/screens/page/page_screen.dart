part of '../surah/surah_index_screen.dart';

class PageScreen extends StatefulWidget {
  final bool? isPara;
  final String? name;
  final int? number;
  const PageScreen({
    Key? key,
    this.isPara,
    required this.name,
    this.number,
  }) : super(key: key);

  @override
  State<PageScreen> createState() => _PageScreenState();
}

class _PageScreenState extends State<PageScreen> {
  @override
  void initState() {
    //

    final bookmarkCubit = BookmarkCubit.cubit(context);

    final chapterCubit = ChapterCubit.cubit(context);

    chapterCubit.fetchAys(widget.number);

    if (widget.isPara != null) {
      //
      // bookmarkCubit.checkBookmarked(widget.chapter!);
      //
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    App.init(context);

    final appProvider = Provider.of<AppProvider>(context);
    final bookmarkCubit = BookmarkCubit.cubit(context);

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        height: 50,
        padding: EdgeInsets.all(12),
        color: Colors.green,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
                onTap: () {
                  showAboutDialog(
                      context: context, children: [const Text("coming soon")]);
                },
                child: Icon(Icons.play_arrow)),
            Icon(Icons.stop),
            Icon(Icons.download)
          ],
        ),
      ),
      body: BlocBuilder<ChapterCubit, ChapterState>(builder: (context, state) {
        if (state is AyaLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is AyaFetchFailed) {
          return const Center(
            child: Text("Error in fetching Data"),
          );
        } else {
          List<Ayah> ayaList = state.data as List<Ayah>;
          return CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                actions: [
                  BlocBuilder<BookmarkCubit, BookmarkState>(
                    builder: (context, state) {
                      return IconButton(
                        onPressed: () {
                          // if (bookmarkCubit.state.isBookmarked!) {
                          //   bookmarkCubit.updateBookmark(
                          //       widget.chapter!, false);
                          // } else {
                          //   bookmarkCubit.updateBookmark(
                          //       widget.chapter!, true);
                          // }
                        },
                        icon: Icon(
                          bookmarkCubit.state.isBookmarked!
                              ? Icons.bookmark_added
                              : Icons.bookmark_add_outlined,
                          color: appProvider.isDark
                              ? Colors.white
                              : Colors.black54,
                        ),
                      );
                    },
                  ),
                ],
                leading: BackButton(
                  color: appProvider.isDark ? Colors.white : Colors.black54,
                ),
                backgroundColor:
                    appProvider.isDark ? Colors.grey[850] : Colors.white,
                pinned: true,
                floating: true,
                expandedHeight: height * 0.27,
                flexibleSpace: _SurahAppBar(data: widget.name),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return Padding(
                      padding: EdgeInsets.fromLTRB(width * 0.015, 0, 0, 0),
                      child: WidgetAnimator(
                        child: ListTile(
                          contentPadding: Space.h,
                          trailing: CircleAvatar(
                            radius: AppDimensions.normalize(3.2),
                            backgroundColor: const Color(0xff04364f),
                            child: CircleAvatar(
                              radius: AppDimensions.normalize(2.9),
                              backgroundColor: Colors.white,
                              child: Text(
                                (index + 1).toString(),
                                style: AppText.l2!.copyWith(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                ayaList[index].arabic ?? '',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontFamily: 'Noor',
                                  fontSize: height * 0.03,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                ayaList[index].shina ?? '',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    fontFamily: 'PDMSIslamicFont',
                                    fontSize: height * 0.03,
                                    color: const Color(0xff045264),
                                    fontWeight: FontWeight.w600),
                              ),
                              const Align(
                                alignment: Alignment.center,
                                child: Divider(
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  childCount: ayaList.length,
                ),
              )
            ],
          );
        }
      }),
    );
  }
}

part of '../surah_index_screen.dart';

class _SurahAppBar extends StatelessWidget {
  final String? data;
  const _SurahAppBar({
    Key? key,
    this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(
      centerTitle: true,
      title: Text(
        data ?? '',
        style: AppText.b2b,
      ),
      background: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.bottomRight,
            child: Opacity(
              opacity: 0.3,
              child: Image.asset(
                StaticAssets.quranRail,
                height: AppDimensions.normalize(60),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Text(data!.englishNameTranslation!),
                Text(
                  '',
                  style: AppText.h1b!.copyWith(
                    fontFamily: 'Noor',
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

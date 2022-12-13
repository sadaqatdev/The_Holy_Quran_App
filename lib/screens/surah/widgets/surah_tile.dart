part of '../surah_index_screen.dart';

class SurahTile extends StatelessWidget {
  final SuraName? chapter;

  const SurahTile({
    Key? key,
    this.chapter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WidgetAnimator(
      child: ListTile(
        minLeadingWidth: 15.0,
        leading: const SizedBox(),
        title: Text(
          chapter?.surah_no.toString() ?? "",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        // subtitle: Text(chapter!.englishNameTranslation!),
        trailing: Text(
          chapter!.name_arabic,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => PageScreen(
                name: chapter?.name_arabic ?? '',
                number: chapter!.surah_no.toInt(),
              ),
            ),
          );
        },
        onLongPress: () => showDialog(
          context: context,
          builder: (context) => _SurahInformation(
            chapterData: chapter,
          ),
        ),
      ),
    );
  }
}

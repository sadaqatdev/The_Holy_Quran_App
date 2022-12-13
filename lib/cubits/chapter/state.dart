part of 'cubit.dart';

@immutable
class ChapterState extends Equatable {
  final List<Ayah?>? data;
  final String? message;

  const ChapterState({
    this.data,
    this.message,
  });

  @override
  List<Object?> get props => [
        data,
        message,
      ];
}

@immutable
class ChapterDefault extends ChapterState {
  const ChapterDefault({required super.data});
}

@immutable
class ChapterFetchLoading extends ChapterState {
  ChapterFetchLoading() : super(data: []);
}

@immutable
class AyaLoading extends ChapterState {
  AyaLoading() : super(data: []);
}

@immutable
class ChapterFetchSuccess extends ChapterState {
  const ChapterFetchSuccess({List<Ayah?>? data}) : super(data: data);
}

@immutable
class AyaFetchSuccess extends ChapterState {
  const AyaFetchSuccess({List<Ayah?>? data}) : super(data: data);
}

@immutable
class ChapterFetchFailed extends ChapterState {
  ChapterFetchFailed({String? message}) : super(message: message, data: []);
}

@immutable
class AyaFetchFailed extends ChapterState {
  AyaFetchFailed({String? message}) : super(message: message, data: []);
}

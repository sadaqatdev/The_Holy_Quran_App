part of 'cubit.dart';

@immutable
class JuzState extends Equatable {
  final List<Juz>? data;
  final String? message;

  const JuzState({
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
class JuzDefault extends JuzState {}

@immutable
class JuzFetchLoading extends JuzState {
  const JuzFetchLoading() : super();
}

@immutable
class JuzFetchSuccess extends JuzState {
  const JuzFetchSuccess({List<Juz>? data}) : super(data: data);
}

@immutable
class JuzFetchFailed extends JuzState {
  const JuzFetchFailed({String? message}) : super(message: message);
}

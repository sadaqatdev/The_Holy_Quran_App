part of 'cubit.dart';

@immutable
class SurasState extends Equatable {
  final List<SuraName?>? data;
  final String? message;

  const SurasState({
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
class SurasDefault extends SurasState {
  const SurasDefault();
}

@immutable
class SurasFetchLoading extends SurasState {
  const SurasFetchLoading() : super();
}

@immutable
@immutable
class SurasFetchSuccess extends SurasState {
  const SurasFetchSuccess({List<SuraName?>? data}) : super(data: data);
}

@immutable
class SurasFetchFailed extends SurasState {
  const SurasFetchFailed({String? message}) : super();
}

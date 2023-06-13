import 'package:equatable/equatable.dart';

enum HomeScreenStage {
  loading,
  dummy,
  webView,
  error,
}

class HomeScreenState extends Equatable {
  final HomeScreenStage stage;
  final String? url;
  final String? errorMessage;

  const HomeScreenState({required this.stage, this.url, this.errorMessage});

  HomeScreenState copyWith({
    HomeScreenStage? stage,
    String? url,
    String? errorMessage,
  }) {
    return HomeScreenState(
        stage: stage ?? this.stage,
        url: url ?? this.url,
        errorMessage: errorMessage ?? this.errorMessage);
  }

  @override
  List<Object?> get props => [stage, url, errorMessage];
}
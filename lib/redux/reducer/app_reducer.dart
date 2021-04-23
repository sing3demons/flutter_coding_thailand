import 'package:flutter_coding_thailand/redux/reducer/profile.dart';
import 'package:meta/meta.dart';

@immutable
class AppState {
  final ProfileState profileState;

  AppState({this.profileState});

  factory AppState.initial() {
    return AppState(profileState: ProfileState());
  }
}

AppState appReducer(AppState state, dynamic action) {
  return AppState(profileState: profileReducer(state.profileState, action));
}

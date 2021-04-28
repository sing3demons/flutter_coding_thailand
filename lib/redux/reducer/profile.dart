import 'package:flutter_coding_thailand/redux/acions/action.dart';
import 'package:meta/meta.dart';

@immutable
class ProfileState {
  final Map<String, dynamic> profile;
  bool isLogin = false;
  // ProfileState(
  //     {this.profile = const {'email': 'sing@dev.com', 'name': 'KPsing'}});
  ProfileState({this.profile, this.isLogin});

  ProfileState copyWith({Map<String, dynamic> profile, bool isLogin}) {
    return ProfileState(
        profile: profile ?? this.profile, isLogin: isLogin ?? this.isLogin);
  }
}

profileReducer(ProfileState state, dynamic action) {
  if (action is GetProfileAction) {
    return state.copyWith(
      profile: action.profileState.profile,
      isLogin: action.profileState.isLogin,
    );
  }

  return state;
}

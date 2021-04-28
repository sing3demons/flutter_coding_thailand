import 'package:flutter_coding_thailand/redux/acions/action.dart';
import 'package:meta/meta.dart';

@immutable
class ProfileState {
  final Map<String, dynamic> profile;
  // ProfileState(
  //     {this.profile = const {'email': 'sing@dev.com', 'name': 'KPsing'}});
  ProfileState({this.profile});

  ProfileState copyWith({Map<String, dynamic> profile}) {
    return ProfileState(profile: profile ?? this.profile);
  }
}

profileReducer(ProfileState state, dynamic action) {
  if (action is GetProfileAction) {
    return state.copyWith(profile: action.profileState.profile);
  }

  return state;
}

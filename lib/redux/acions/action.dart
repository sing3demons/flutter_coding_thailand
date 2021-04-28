import 'package:flutter_coding_thailand/redux/reducer/profile.dart';
import 'package:meta/meta.dart';

@immutable
class GetProfileAction {
  final ProfileState profileState;

  GetProfileAction(this.profileState);
}

//action
getProfileAction(Map profile) {
  bool isLogin = false;
  if (profile != null) isLogin = true;

  return GetProfileAction(ProfileState(profile: profile, isLogin: isLogin));
}

logout(bool isLogin) {
  return GetProfileAction(ProfileState(profile: null, isLogin: isLogin));
}

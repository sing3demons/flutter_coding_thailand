import 'package:flutter_coding_thailand/redux/reducer/profile.dart';
import 'package:meta/meta.dart';

@immutable
class GetProfileAction {
  final ProfileState profileState;

  GetProfileAction({this.profileState});
}

//action
getProfileAction(Map profile) =>
    GetProfileAction(profileState: ProfileState(profile: profile));

// ignore_for_file: public_member_api_docs

part of 'bloc.dart';

abstract class AudioControlEvent extends Equatable {
  const AudioControlEvent();

  @override
  List<Object> get props => [];
}

class AudioToggled extends AudioControlEvent {}

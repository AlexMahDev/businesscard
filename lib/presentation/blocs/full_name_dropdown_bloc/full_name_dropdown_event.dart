part of 'full_name_dropdown_bloc.dart';

@immutable
abstract class FullNameDropdownEvent {}

class FullNameDropdownCloseEvent extends FullNameDropdownEvent {}

class FullNameDropdownOpenEvent extends FullNameDropdownEvent {}

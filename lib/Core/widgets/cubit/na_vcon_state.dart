part of 'na_vcon_cubit.dart';

class NaVconState {
  StatusFull status;

  Color color;
  Color color2;
  NaVconState(
      {required this.status, required this.color, required this.color2});
}

abstract class StatusFull {}

class InitFull extends StatusFull {}

class Araghi extends StatusFull {}

class Nnews extends StatusFull {}

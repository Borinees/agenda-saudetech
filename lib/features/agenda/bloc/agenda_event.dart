part of 'agenda_bloc.dart';

sealed class AgendaEvent extends Equatable {
  const AgendaEvent();
  @override
  List<Object?> get props => [];
}

class CarregarAgenda extends AgendaEvent {
  const CarregarAgenda();
}

class BuscarTexto extends AgendaEvent {
  final String texto;
  const BuscarTexto(this.texto);
  @override
  List<Object?> get props => [texto];
}

class FiltrarAgenda extends AgendaEvent {
  final FiltroAgenda filtro;
  const FiltrarAgenda(this.filtro);
  @override
  List<Object?> get props => [filtro];
}
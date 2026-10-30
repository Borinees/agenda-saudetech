import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/vistoria.dart';

part 'agenda_event.dart';
part 'agenda_state.dart';

class AgendaBloc extends Bloc<AgendaEvent, AgendaState> {
  /// Fonte dos dados. Hoje: mock. Depois: banco local/API (o grupo troca).
  final Future<List<Vistoria>> Function() carregarVistorias;

  AgendaBloc({required this.carregarVistorias})
      : super(const AgendaCarregando()) {
    on<CarregarAgenda>(_aoCarregar);
    on<BuscarTexto>(_aoBuscar);
    on<FiltrarAgenda>(_aoFiltrar);
  }

  Future<void> _aoCarregar(
    CarregarAgenda event,
    Emitter<AgendaState> emit,
  ) async {
    // Preserva busca e filtro caso seja um "puxar para atualizar".
    final atual = state;
    final busca = atual is AgendaCarregada ? atual.busca : '';
    final filtro = atual is AgendaCarregada ? atual.filtro : FiltroAgenda.todas;

    if (atual is! AgendaCarregada) emit(const AgendaCarregando());

    try {
      final lista = await carregarVistorias();
      if (lista.isEmpty) {
        emit(const AgendaVazia());
      } else {
        // Ordena por horário agendado.
        lista.sort((a, b) => a.dataAgendada.compareTo(b.dataAgendada));
        emit(AgendaCarregada(todas: lista, busca: busca, filtro: filtro));
      }
    } catch (e) {
      emit(AgendaErro('Não foi possível carregar a agenda.'));
    }
  }

  void _aoBuscar(BuscarTexto event, Emitter<AgendaState> emit) {
    final atual = state;
    if (atual is AgendaCarregada) {
      emit(atual.copyWith(busca: event.texto));
    }
  }

  void _aoFiltrar(FiltrarAgenda event, Emitter<AgendaState> emit) {
    final atual = state;
    if (atual is AgendaCarregada) {
      emit(atual.copyWith(filtro: event.filtro));
    }
  }
}
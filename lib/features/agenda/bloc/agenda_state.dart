part of 'agenda_bloc.dart';

/// Opções do filtro exibido na tela.
enum FiltroAgenda { todas, agendadas, emAndamento, concluidas, pendentesSync }

/// Números do cabeçalho: "8 vistorias · 3 concluídas · 2 pendentes".
class ResumoDoDia extends Equatable {
  final int total;
  final int concluidas;
  final int emAndamento;
  final int pendentesSync;
  final int comErro;

  const ResumoDoDia({
    required this.total,
    required this.concluidas,
    required this.emAndamento,
    required this.pendentesSync,
    required this.comErro,
  });

  factory ResumoDoDia.de(List<Vistoria> lista) => ResumoDoDia(
        total: lista.length,
        concluidas:
            lista.where((v) => v.status == StatusVistoria.concluida).length,
        emAndamento:
            lista.where((v) => v.status == StatusVistoria.emAndamento).length,
        pendentesSync:
            lista.where((v) => v.syncStatus == SyncStatus.pendente).length,
        comErro: lista.where((v) => v.syncStatus == SyncStatus.erro).length,
      );

  @override
  List<Object?> get props =>
      [total, concluidas, emAndamento, pendentesSync, comErro];
}

sealed class AgendaState extends Equatable {
  const AgendaState();
  @override
  List<Object?> get props => [];
}

class AgendaCarregando extends AgendaState {
  const AgendaCarregando();
}

/// Não há nenhuma vistoria agendada para o dia.
class AgendaVazia extends AgendaState {
  const AgendaVazia();
}

class AgendaErro extends AgendaState {
  final String mensagem;
  const AgendaErro(this.mensagem);
  @override
  List<Object?> get props => [mensagem];
}

class AgendaCarregada extends AgendaState {
  /// Lista completa do dia (sem filtro). O resumo usa esta lista.
  final List<Vistoria> todas;
  final String busca;
  final FiltroAgenda filtro;

  const AgendaCarregada({
    required this.todas,
    this.busca = '',
    this.filtro = FiltroAgenda.todas,
  });

  ResumoDoDia get resumo => ResumoDoDia.de(todas);

  /// Lista exibida: aplica filtro e busca. Pode ficar vazia
  /// (a UI deve mostrar "Nenhum resultado para os filtros").
  List<Vistoria> get visiveis {
    final termo = _normalizar(busca);
    return todas.where((v) {
      final passaFiltro = switch (filtro) {
        FiltroAgenda.todas => true,
        FiltroAgenda.agendadas => v.status == StatusVistoria.agendada,
        FiltroAgenda.emAndamento => v.status == StatusVistoria.emAndamento,
        FiltroAgenda.concluidas => v.status == StatusVistoria.concluida,
        FiltroAgenda.pendentesSync => v.syncStatus != SyncStatus.sincronizado,
      };
      if (!passaFiltro) return false;
      if (termo.isEmpty) return true;
      return _normalizar(v.razaoSocial).contains(termo) ||
          _normalizar(v.endereco).contains(termo) ||
          _normalizar(v.bairro).contains(termo) ||
          _normalizar(v.tipoEstabelecimento).contains(termo);
    }).toList();
  }

  AgendaCarregada copyWith({String? busca, FiltroAgenda? filtro}) =>
      AgendaCarregada(
        todas: todas,
        busca: busca ?? this.busca,
        filtro: filtro ?? this.filtro,
      );

  @override
  List<Object?> get props => [todas, busca, filtro];
}

/// Minúsculas e sem acentos, para "farmacia" achar "Farmácia".
String _normalizar(String s) {
  const de = 'áàâãäéèêëíìîïóòôõöúùûüçÁÀÂÃÄÉÈÊËÍÌÎÏÓÒÔÕÖÚÙÛÜÇ';
  const para = 'aaaaaeeeeiiiiooooouuuucAAAAAEEEEIIIIOOOOOUUUUC';
  var r = s;
  for (var i = 0; i < de.length; i++) {
    r = r.replaceAll(de[i], para[i]);
  }
  return r.toLowerCase().trim();
}
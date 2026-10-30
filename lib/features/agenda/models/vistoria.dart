import 'package:equatable/equatable.dart';

enum StatusVistoria { agendada, emAndamento, concluida }

enum SyncStatus { sincronizado, pendente, erro }

class Vistoria extends Equatable {
  final String id;
  final String razaoSocial;
  final String endereco;
  final String bairro;
  final String tipoEstabelecimento;
  final DateTime dataAgendada;
  final StatusVistoria status;
  final SyncStatus syncStatus;

  const Vistoria({
    required this.id,
    required this.razaoSocial,
    required this.endereco,
    required this.bairro,
    required this.tipoEstabelecimento,
    required this.dataAgendada,
    required this.status,
    required this.syncStatus,
  });

  @override
  List<Object?> get props => [
    id,
    razaoSocial,
    endereco,
    bairro,
    tipoEstabelecimento,
    dataAgendada,
    status,
    syncStatus,
  ];
}

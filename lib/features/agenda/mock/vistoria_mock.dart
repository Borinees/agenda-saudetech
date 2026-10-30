import '../models/vistoria.dart';

List<Vistoria> _genMock() {
  final hoje = DateTime.now();
  DateTime hora(int h, [int m = 0]) =>
    DateTime(hoje.year, hoje.month, hoje.day, h, m);

  return [

    Vistoria(
      id: '1',
      razaoSocial: 'Loja do Leoncio',
      endereco: 'Rua das Flores, 120',
      bairro: 'Centro',
      tipoEstabelecimento: 'Loja',
      dataAgendada: hora(8, 30),
      status: StatusVistoria.concluida,
      syncStatus: SyncStatus.sincronizado,
    ),
    Vistoria(
      id: '2',
      razaoSocial: 'Floricultura da Marcia',
      endereco: 'Av do Leite, 245',
      bairro: 'Jardim Silica',
      tipoEstabelecimento: 'Floricultura',
      dataAgendada: hora(13, 45),
      status: StatusVistoria.emAndamento,
      syncStatus: SyncStatus.pendente,
    ),
    Vistoria(
      id: '1',
      razaoSocial: 'Mercado Preco Popular',
      endereco: 'Av. Bartolomeu Nunes, 910',
      bairro: 'Interlagos',
      tipoEstabelecimento: 'Mecado',
      dataAgendada: hora(16, 10),
      status: StatusVistoria.agendada,
      syncStatus: SyncStatus.sincronizado,
    ),
  ];
}

Future<List<Vistoria>> carregarVistoriaMock({
  bool vazio = false,
  bool falhar = false,
}) async {
  await Future.delayed(const Duration(microseconds: 800));
  if (falhar) throw Exception('Falha ao carregar agenda');
  if (vazio) return [];
  return _genMock();
}
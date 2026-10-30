import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/app_theme.dart';
import '../bloc/agenda_bloc.dart';
import '../widgets/busca_field.dart';
import '../widgets/estados_view.dart';
import '../widgets/faixa_offline.dart';
import '../widgets/filtro_status.dart';
import '../widgets/resumo_do_dia_card.dart';
import '../widgets/vistoria_card.dart';


class AgendaPage extends StatelessWidget {
  final ValueChanged<String> onAbrirVistoria;

  final bool offline;

  const AgendaPage({
    super.key,
    required this.onAbrirVistoria,
    this.offline = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agenda'),
        actions: [
          IconButton(
            tooltip: 'Atualizar',
            icon: const Icon(Icons.refresh),
            onPressed: () =>
                context.read<AgendaBloc>().add(const CarregarAgenda()),
          ),
        ],
      ),
      body: Column(
        children: [
          FaixaOffline(offline: offline),
          Expanded(
            child: BlocBuilder<AgendaBloc, AgendaState>(
              builder: (context, state) => switch (state) {
                AgendaCarregando() =>
                  const Center(child: CircularProgressIndicator()),
                AgendaErro(:final mensagem) => ErroView(
                    mensagem: mensagem,
                    onTentarNovamente: () => context
                        .read<AgendaBloc>()
                        .add(const CarregarAgenda()),
                  ),
                AgendaVazia() => const AgendaVaziaView(),
                AgendaCarregada() => _ConteudoAgenda(
                    state: state,
                    onAbrirVistoria: onAbrirVistoria,
                  ),
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ConteudoAgenda extends StatelessWidget {
  final AgendaCarregada state;
  final ValueChanged<String> onAbrirVistoria;

  const _ConteudoAgenda({
    required this.state,
    required this.onAbrirVistoria,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AgendaBloc>();
    final visiveis = state.visiveis;
    final dataHoje =
        DateFormat("EEEE, d 'de' MMMM", 'pt_BR').format(DateTime.now());

    return RefreshIndicator(
      onRefresh: () async {
        bloc.add(const CarregarAgenda());
        await Future.delayed(const Duration(milliseconds: 600));
      },
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dataHoje,
                    style: const TextStyle(
                      fontSize: 15,
                      color: AppColors.textoSecundario,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ResumoDoDiaCard(resumo: state.resumo),
                  const SizedBox(height: 16),
                  BuscaField(
                    onChanged: (t) => bloc.add(BuscarTexto(t)),
                  ),
                  const SizedBox(height: 12),
                  FiltroStatus(
                    selecionado: state.filtro,
                    onSelecionado: (f) => bloc.add(FiltrarAgenda(f)),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          if (visiveis.isEmpty)
            const SliverFillRemaining(
              hasScrollBody: false,
              child: SemResultadoView(),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              sliver: SliverGrid.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 560,
                  mainAxisExtent: 164,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: visiveis.length,
                itemBuilder: (context, i) {
                  final v = visiveis[i];
                  return VistoriaCard(
                    vistoria: v,
                    onTap: () => onAbrirVistoria(v.id),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
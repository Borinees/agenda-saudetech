import 'package:material_ui/material_ui.dart';
import '../../../core/theme/app_theme.dart';
import '../bloc/agenda_bloc.dart';

class FiltroStatus extends StatelessWidget {
  final FiltroAgenda selecionado;
  final ValueChanged<FiltroAgenda> onSelecionado;
  const FiltroStatus(
      {super.key, required this.selecionado, required this.onSelecionado});

  static const _rotulos = {
    FiltroAgenda.todas: 'Todas',
    FiltroAgenda.agendadas: 'Agendadas',
    FiltroAgenda.emAndamento: 'Em andamento',
    FiltroAgenda.concluidas: 'Concluídas',
    FiltroAgenda.pendentesSync: 'Pendentes de sync',
  };

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: FiltroAgenda.values.map((f) {
        final ativo = f == selecionado;
        return ChoiceChip(
          label: Text(_rotulos[f]!),
          selected: ativo,
          onSelected: (_) => onSelecionado(f),
          showCheckmark: false,
          selectedColor: AppColors.azul,
          backgroundColor: Colors.white,
          labelStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: ativo ? Colors.white : AppColors.marinho,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          side: const BorderSide(color: AppColors.borda),
        );
      }).toList(),
    );
  }
}
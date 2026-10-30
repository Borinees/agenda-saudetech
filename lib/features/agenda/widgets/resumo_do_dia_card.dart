import 'package:material_ui/material_ui.dart';
import '../../../core/theme/app_theme.dart';
import '../bloc/agenda_bloc.dart';

class ResumoDoDiaCard extends StatelessWidget {
  final ResumoDoDia resumo;
  const ResumoDoDiaCard({super.key, required this.resumo});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.marinho,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _Numero(valor: resumo.total, rotulo: 'Vistorias hoje'),
          _Numero(valor: resumo.concluidas, rotulo: 'Concluídas'),
          _Numero(valor: resumo.emAndamento, rotulo: 'Em andamento'),
          _Numero(valor: resumo.pendentesSync, rotulo: 'Pendentes de sync'),
          if (resumo.comErro > 0)
            _Numero(
                valor: resumo.comErro,
                rotulo: 'Com erro',
                cor: const Color(0xFFFCA5A5)),
        ],
      ),
    );
  }
}

class _Numero extends StatelessWidget {
  final int valor;
  final String rotulo;
  final Color cor;
  const _Numero(
      {required this.valor, required this.rotulo, this.cor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('$valor',
            style: TextStyle(
                fontSize: 28, fontWeight: FontWeight.w800, color: cor)),
        const SizedBox(height: 2),
        Text(rotulo,
            style: const TextStyle(fontSize: 13, color: Colors.white70)),
      ],
    );
  }
}
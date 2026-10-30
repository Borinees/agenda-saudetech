import 'package:material_ui/material_ui.dart';
import '../../../core/theme/app_theme.dart';

class _MensagemCentral extends StatelessWidget {
  final IconData icone;
  final String titulo;
  final String? subtitulo;
  final Widget? acao;
  final Color cor;
  const _MensagemCentral({
    required this.icone,
    required this.titulo,
    this.subtitulo,
    this.acao,
    this.cor = AppColors.textoSecundario,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icone, size: 64, color: cor),
            const SizedBox(height: 16),
            Text(titulo,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppColors.marinho)),
            if (subtitulo != null) ...[
              const SizedBox(height: 8),
              Text(subtitulo!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 15, color: AppColors.textoSecundario)),
            ],
            if (acao != null) ...[const SizedBox(height: 20), acao!],
          ],
        ),
      ),
    );
  }
}

class ErroView extends StatelessWidget {
  final String mensagem;
  final VoidCallback onTentarNovamente;
  const ErroView(
      {super.key, required this.mensagem, required this.onTentarNovamente});

  @override
  Widget build(BuildContext context) => _MensagemCentral(
        icone: Icons.error_outline,
        cor: AppColors.vermelho,
        titulo: 'Algo deu errado',
        subtitulo: mensagem,
        acao: FilledButton.icon(
          onPressed: onTentarNovamente,
          icon: const Icon(Icons.refresh),
          label: const Text('Tentar novamente'),
        ),
      );
}

class AgendaVaziaView extends StatelessWidget {
  const AgendaVaziaView({super.key});

  @override
  Widget build(BuildContext context) => const _MensagemCentral(
        icone: Icons.event_available_outlined,
        titulo: 'Nenhuma vistoria para hoje',
        subtitulo: 'Quando houver vistorias agendadas, elas aparecem aqui.',
      );
}

class SemResultadoView extends StatelessWidget {
  const SemResultadoView({super.key});

  @override
  Widget build(BuildContext context) => const _MensagemCentral(
        icone: Icons.search_off,
        titulo: 'Nenhum resultado',
        subtitulo: 'Tente outro termo de busca ou mude o filtro.',
      );
}
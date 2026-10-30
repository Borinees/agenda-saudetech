import 'package:material_ui/material_ui.dart';
import '../../../core/theme/app_theme.dart';
import '../models/vistoria.dart';

class StatusSelo extends StatelessWidget {
  final StatusVistoria status;
  const StatusSelo({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final (texto, fundo, cor) = switch (status) {
      StatusVistoria.agendada =>
        ('Agendada', AppColors.azulFundo, AppColors.azul),
      StatusVistoria.emAndamento =>
        ('Em andamento', AppColors.ambarFundo, AppColors.ambar),
      StatusVistoria.concluida =>
        ('Concluída', AppColors.verdeFundo, AppColors.verde),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: fundo,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(texto,
          style: TextStyle(
              fontSize: 13, color: cor, fontWeight: FontWeight.w700)),
    );
  }
}
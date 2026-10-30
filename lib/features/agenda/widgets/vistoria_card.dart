import 'package:material_ui/material_ui.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_theme.dart';
import '../models/vistoria.dart';
import 'status_selo.dart';
import 'sync_badge.dart';

class VistoriaCard extends StatelessWidget {
  final Vistoria vistoria;
  final VoidCallback onTap;
  const VistoriaCard({super.key, required this.vistoria, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final hora = DateFormat('HH:mm').format(vistoria.dataAgendada);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 120),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.schedule,
                        size: 18, color: AppColors.textoSecundario),
                    const SizedBox(width: 4),
                    Text(hora,
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: AppColors.marinho)),
                    const Spacer(),
                    StatusSelo(status: vistoria.status),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  vistoria.razaoSocial,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: AppColors.marinho),
                ),
                const SizedBox(height: 4),
                Text(
                  '${vistoria.endereco} · ${vistoria.bairro}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 14, color: AppColors.textoSecundario),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColors.cinzaFundo,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(vistoria.tipoEstabelecimento,
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w600)),
                    ),
                    const Spacer(),
                    SyncBadge(status: vistoria.syncStatus),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
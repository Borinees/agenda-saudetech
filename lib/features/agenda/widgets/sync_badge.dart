import 'package:material_ui/material_ui.dart';
import '../../../core/theme/app_theme.dart';
import '../models/vistoria.dart';

class SyncBadge extends StatelessWidget {
  final SyncStatus status;
  const SyncBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final (icone, cor, texto) = switch (status) {
      SyncStatus.sincronizado =>
        (Icons.cloud_done_outlined, AppColors.verde, 'Sincronizado'),
      SyncStatus.pendente =>
        (Icons.cloud_upload_outlined, AppColors.ambar, 'Pendente'),
      SyncStatus.erro =>
        (Icons.cloud_off_outlined, AppColors.vermelho, 'Erro de sync'),
    };

    return Semantics(
      label: 'Sincronização: $texto',
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icone, size: 18, color: cor),
          const SizedBox(width: 4),
          Text(texto,
              style: TextStyle(
                  fontSize: 13, color: cor, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
import 'package:material_ui/material_ui.dart';
import '../../../core/theme/app_theme.dart';

class FaixaOffline extends StatelessWidget {
  final bool offline;
  const FaixaOffline({super.key, required this.offline});

  @override
  Widget build(BuildContext context) {
    if (!offline) return const SizedBox.shrink();
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      color: AppColors.ambarFundo,
      child: const Row(
        children: [
          Icon(Icons.wifi_off, color: AppColors.ambar),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'Sem conexão — seus dados estão sendo salvos no tablet.',
              style: TextStyle(
                  color: AppColors.ambar, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
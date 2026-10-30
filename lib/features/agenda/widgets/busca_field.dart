import 'package:material_ui/material_ui.dart';
import '../../../core/theme/app_theme.dart';

class BuscaField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  const BuscaField({super.key, required this.onChanged});

  @override
  State<BuscaField> createState() => _BuscaFieldState();
}

class _BuscaFieldState extends State<BuscaField> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      onChanged: (t) {
        setState(() {});
        widget.onChanged(t);
      },
      decoration: InputDecoration(
        hintText: 'Buscar por nome, endereço, bairro ou tipo',
        prefixIcon: const Icon(Icons.search),
        suffixIcon: _controller.text.isEmpty
            ? null
            : IconButton(
                tooltip: 'Limpar busca',
                icon: const Icon(Icons.close),
                onPressed: () {
                  _controller.clear();
                  setState(() {});
                  widget.onChanged('');
                },
              ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.borda),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.borda),
        ),
      ),
    );
  }
}
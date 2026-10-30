import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'core/theme/app_theme.dart';
import 'features/agenda/bloc/agenda_bloc.dart';
import 'features/agenda/mock/vistoria_mock.dart';
import 'features/agenda/pages/agenda_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('pt_BR'); // datas em português
  runApp(const DemoApp());
}

class DemoApp extends StatefulWidget {
  const DemoApp({super.key});

  @override
  State<DemoApp> createState() => _DemoAppState();
}

class _DemoAppState extends State<DemoApp> {
  bool _offline = false; // só para demonstrar a faixa offline

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SaúdeTech 2 — Agenda',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      home: BlocProvider(
        create: (_) => AgendaBloc(
          // Para testar outros estados, troque por:
          // () => carregarVistoriaMock(vazio: true)
          // () => carregarVistoriaMock(falhar: true)
          carregarVistorias: carregarVistoriaMock,
        )..add(const CarregarAgenda()),
        child: Stack(
          children: [
            AgendaPage(
              offline: _offline,
              onAbrirVistoria: (id) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Abrir vistoria $id')),
                );
              },
            ),
            // Botão de demonstração (remover na integração).
            Positioned(
              right: 80,
              top: 8,
              child: SafeArea(
                child: Material(
                  type: MaterialType.transparency,
                  child: Switch(
                    value: _offline,
                    onChanged: (v) => setState(() => _offline = v),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
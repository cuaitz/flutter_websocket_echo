import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:websocket_echo/model/connection_model.dart';
import 'package:websocket_echo/routes.dart';

class ConfigView extends StatefulWidget {
  const ConfigView({super.key});

  @override
  State<ConfigView> createState() => _ConfigViewState();
}

class _ConfigViewState extends State<ConfigView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _inputController = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    _inputController.text = Provider.of<ConnectionModel>(context, listen: false).getUrl();
  }

  void submit() async {
    if (_formKey.currentState!.validate()) {
      try {
        Provider.of<ConnectionModel>(context, listen: false).setUri(Uri.parse(_inputController.text));
        showDialog(context: context, builder: (context) {
          return AlertDialog(
            title: Text("Sucesso"),
            content: Text("Alterações salvas com sucesso."),
            actions: [
              ElevatedButton(onPressed: () => Navigator.pop(context), child: Text("Ok"))
            ]
          );
        }).then((value) {
          GoRouter.of(context).pushReplacement(FEWRouter.chatView);
        });
      } catch (e) {
        showDialog(context: context, builder: (context) {
          return AlertDialog(
            title: Text("Erro"),
            content: Text("Erro ao salvar: ${e.toString()}"),
            actions: [
              ElevatedButton(onPressed: () => Navigator.pop(context), child: Text("Ok"))
            ]
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Echo Websocket Demo", style: TextStyle(color: Color(0xFFDDDDDD))),
        backgroundColor: const Color(0xFF132443),
        iconTheme: const IconThemeData(color: Color(0xFFDDDDDD)),
      ),
      drawer: Drawer(
        backgroundColor: const Color(0xFF252525),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              child: Text("Menu", style: TextStyle(color: Color(0xFFDDDDDD))),
            ),
            ListTile(
              title: const Text("Home", style: TextStyle(color: Color(0xFFDDDDDD))),
              onTap: () {
                GoRouter.of(context).pushReplacement(FEWRouter.chatView);
              },
            ),
            ListTile(
              title: const Text("Config", style: TextStyle(color: Color(0xFFDDDDDD))),
              onTap: () {
                GoRouter.of(context).pushReplacement(FEWRouter.configView);
              },
            )
          ],
        ),
      ),
      backgroundColor: const Color(0xFF252525),
      body: SafeArea(
        minimum: const EdgeInsets.fromLTRB(0, 0, 0, 8),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF132443),
                        borderRadius: BorderRadius.circular(100)
                      ),
                      child: Center(
                        child: TextFormField(
                          controller: _inputController,
                          style: const TextStyle(
                            color: Color(0xFFDDDDDD),
                          ),
                          onFieldSubmitted: (value) => submit(),
                          decoration: const InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                            hintText: "wss://echo.websocket.events",
                            hintStyle: TextStyle(
                              color: Color(0xFF909090)
                            ),
                            border: InputBorder.none,
                            labelText: "URL"
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Preencha este campo.";
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: submit,
                child: const Text("Salvar"))
            ],
          ),
        ),
      ),
    );
  }
}
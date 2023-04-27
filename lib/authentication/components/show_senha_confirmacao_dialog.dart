import 'package:flutter/material.dart';
import 'package:flutter_firebase_firestore_first/authentication/services/auth_service.dart';

showSenhaConfirmacaoDialog({
  required BuildContext context,
  required String email,
}) {
  showDialog(
    context: context,
    builder: (context) {
      TextEditingController senhaConfirmacaoController =
          TextEditingController();
      return AlertDialog(
        title: Text("Deseja remover a conta com o e-mail $email"),
        content: SizedBox(
          height: 175,
          child: Column(
            children: [
              const Text("Para confirmar a remoção da conta, insira sua senha"),
              TextFormField(
                controller: senhaConfirmacaoController,
                obscureText: true,
                decoration: const InputDecoration(
                  label: Text("Senha"),
                ),
              )
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {},
            child: const Text("Cancelar"),
          ),
          TextButton(
            onPressed: () async {
              await AuthService()
                  .removerConta(senha: senhaConfirmacaoController.text)
                  .then((String? erro) async {
                if (erro != null) {
                  Navigator.pop(context);
                  await AuthService().deslogar();
                }
              });
            },
            child: const Text("Excluir Conta"),
          ),
        ],
      );
    },
  );
}

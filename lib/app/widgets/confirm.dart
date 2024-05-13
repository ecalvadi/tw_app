import 'package:flutter/material.dart';

Future<T?> getDialogConfirm<T>(
    BuildContext context, String title, String question,
    {Function? funcSi, Function? funcNo}) {
  return showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      backgroundColor: Colors.white,
      title: Text(title,
          style: const TextStyle(
              fontWeight: FontWeight.w600, color: Colors.black)),
      content: Text(question,
          style: const TextStyle(
              fontWeight: FontWeight.w600, color: Colors.black)),
      actions: <Widget>[
        (funcNo != null)
            ? TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
                onPressed: () {
                  funcNo();
                },
                child: const Text('Cancelar'),
              )
            : const SizedBox(),
        const SizedBox(width: 10),
        TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          ),
          onPressed: () {
            if (funcSi != null)
              funcSi();
            else
              Navigator.of(context).pop(true);
          },
          child: const Text('Aceptar'),
        ),
      ],
    ),
  );
}

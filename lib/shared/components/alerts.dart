import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';

void confirmAlert(String text, BuildContext context, Function? callback, bool showCancelButtom) {
  CoolAlert.show(
      context: context,
      title: "Atenção:",
      type: CoolAlertType.confirm,
      text: text,
      confirmBtnText: !showCancelButtom ? 'OK' : 'Sim',
      cancelBtnText: showCancelButtom ? 'Não' : '',
      barrierDismissible: false,
      onConfirmBtnTap: () {
        if (callback != null) {
          callback();
        }
      });
}

void dismiss(BuildContext context){
  Navigator.pop(context);
}

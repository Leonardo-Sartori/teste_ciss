import 'package:flutter_easyloading/flutter_easyloading.dart';

void showSuccess({required String text}){
  EasyLoading.showSuccess(text, duration: const Duration(seconds: 5));
}

void showError(){
  EasyLoading.showError("Falaha ao realizar ação !", duration: const Duration(seconds: 5));
}
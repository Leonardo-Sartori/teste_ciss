import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:teste_ciss/data/models/user.dart';
import 'package:teste_ciss/presentation/blocs/post/post_bloc.dart';
import 'package:teste_ciss/presentation/pages/post/post_list_view.dart';
void main() {

  setUp(() async {
    await GetIt.I.reset();
    GetIt.I.registerFactory<PostBloc>(() => PostBloc());
  });

 testWidgets('Teste de exibição do FloatingActionButton', (WidgetTester tester) async {
    final postListView = PostListView(user: User(id: 0, name: "", username: "", email: ""),);
    await tester.pumpWidget(MaterialApp(home: postListView));
    final fabWidget = find.byType(FloatingActionButton);
    expect(fabWidget, findsOneWidget);
  });
}
 
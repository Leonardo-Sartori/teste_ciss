import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_ciss/core/injection/injection.dart';
import 'package:teste_ciss/data/models/post.dart';
import 'package:teste_ciss/data/models/user.dart';
import 'package:teste_ciss/presentation/blocs/post/post_bloc.dart';
import 'package:teste_ciss/presentation/blocs/post/post_event.dart';
import 'package:teste_ciss/presentation/blocs/post/post_state.dart';
import 'package:teste_ciss/presentation/pages/post/post_list_view.dart';
import 'package:teste_ciss/shared/components/app_textfield.dart';
import 'package:teste_ciss/shared/utils/navigator/nav.dart';

class PostFormPage extends StatefulWidget {
  final User user;
  final Post? post;

  const PostFormPage({Key? key, required this.user, this.post}) : super(key: key);

  @override
  PostFormPageState createState() => PostFormPageState();
}

class PostFormPageState extends State<PostFormPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _postBloc = getIt.get<PostBloc>();
  final TextEditingController _tTitle = TextEditingController();
  final TextEditingController _tBody = TextEditingController();

  Post post = Post(
      id: 0,
      title: "",
      body: "",
      user: User(id: 0, name: "", username: "", email: ""));

  @override
  void initState() {
    if(widget.post != null){
      post = widget.post!;
      _mapElements();
    }
    super.initState();
  }

  void _mapElements(){
    _tTitle.text = post.title;
    _tBody.text = post.body;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _postBloc,
      child: WillPopScope(
        onWillPop: () async {
          _goToListView();
          return true;
        },
        child: Scaffold(
          appBar: _appBar(),
          body: _body(),
        ),
      ),
    );
  }

  PreferredSize _appBar() {
    return PreferredSize(
      preferredSize: Size(MediaQuery.of(context).size.width, 50),
      child: AppBar(
        title: const Text("Post"),
        actions: [
          BlocBuilder<PostBloc, PostState>(
            builder: (context, state) {
              if (state is PostSavingSuccessState || state is PostErrorState) {
                return Container();
              }
              return IconButton(
                  onPressed: () => _onSave(post: post),
                  icon: const Icon(
                    Icons.check,
                    size: 30,
                  ));
            },
          )
        ],
      ),
    );
  }

  void _goToListView() {
    push(
        context,
        PostListView(
          user: widget.user,
        ),
        replace: true);
  }

  void _onSave({required Post post}) {
    bool formOk = formKey.currentState!.validate();

    if (!formOk) {
      return;
    }

    post.user = widget.user;
    _postBloc.add(PostSavingEvent(post: post));
  }

  Widget _body() {
    return BlocBuilder<PostBloc, PostState>(
      bloc: _postBloc,
      builder: (context, state) {
        if (state is PostLoadingState || state is PostSavingState) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is PostErrorState) {
          return const Center(
              child: Text("Ocorreu um erro ao salver o post !"));
        }

        if (state is PostSavingSuccessState) {
          return Center(
              child: Text("Salvo com sucesso: ${state.post.toString()}"));
        }

        return SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    AppTextfield(
                      "Título: *",
                      controller: _tTitle,
                      required: true,
                      TextCapitalization.sentences,
                      inputType: TextInputType.name,
                      onChanged: (value) => post.title = value,
                    ),
                    AppTextfield(
                      "Descrição: *",
                      controller: _tBody,
                      required: true,
                      TextCapitalization.sentences,
                      inputType: TextInputType.name,
                      maxLines: 3,
                      onChanged: (value) => post.body = value,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

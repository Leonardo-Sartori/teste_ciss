// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:io' as _i5;

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:teste_ciss/core/injection/injection.dart' as _i25;
import 'package:teste_ciss/data/datasources/album_datasource.dart' as _i19;
import 'package:teste_ciss/data/datasources/comment_datasource.dart' as _i22;
import 'package:teste_ciss/data/datasources/photo_datasource.dart' as _i8;
import 'package:teste_ciss/data/datasources/post_datasource.dart' as _i12;
import 'package:teste_ciss/data/datasources/user_datasource.dart' as _i16;
import 'package:teste_ciss/data/repositories/album/album_repository.dart'
    as _i20;
import 'package:teste_ciss/data/repositories/album/album_repository_impl.dart'
    as _i21;
import 'package:teste_ciss/data/repositories/comment/comment_repository.dart'
    as _i23;
import 'package:teste_ciss/data/repositories/comment/comment_repository_impl.dart'
    as _i24;
import 'package:teste_ciss/data/repositories/photo/photo_repository.dart'
    as _i9;
import 'package:teste_ciss/data/repositories/photo/photo_repository_impl.dart'
    as _i10;
import 'package:teste_ciss/data/repositories/post/post_repository.dart' as _i13;
import 'package:teste_ciss/data/repositories/post/post_repository_impl.dart'
    as _i14;
import 'package:teste_ciss/data/repositories/user/user_repository.dart' as _i17;
import 'package:teste_ciss/data/repositories/user/user_repository_impl.dart'
    as _i18;
import 'package:teste_ciss/data/services/json_placeholder_api/json_placeholder_api.dart'
    as _i6;
import 'package:teste_ciss/presentation/blocs/album/album_bloc.dart' as _i3;
import 'package:teste_ciss/presentation/blocs/comment/comment_bloc.dart' as _i4;
import 'package:teste_ciss/presentation/blocs/photo/photo_bloc.dart' as _i7;
import 'package:teste_ciss/presentation/blocs/post/post_bloc.dart' as _i11;
import 'package:teste_ciss/presentation/blocs/user/user_bloc.dart' as _i15;

extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.factory<_i3.AlbumBloc>(() => _i3.AlbumBloc());
    gh.factory<_i4.CommentBloc>(() => _i4.CommentBloc());
    gh.singleton<_i5.HttpClient>(registerModule.http);
    gh.singleton<_i6.JsonPlaceholderApi>(_i6.JsonPlaceholderApi());
    gh.factory<_i7.PhotoBloc>(() => _i7.PhotoBloc());
    gh.factory<_i8.PhotoDatasource>(() =>
        _i8.PhotoDatasource(jsonPlaceholderApi: gh<_i6.JsonPlaceholderApi>()));
    gh.factory<_i9.PhotoRepository>(() =>
        _i10.PhotoRepositoryImpl(photoDatasource: gh<_i8.PhotoDatasource>()));
    gh.factory<_i11.PostBloc>(() => _i11.PostBloc());
    gh.factory<_i12.PostDatasource>(() =>
        _i12.PostDatasource(jsonPlaceholderApi: gh<_i6.JsonPlaceholderApi>()));
    gh.factory<_i13.PostRepository>(() =>
        _i14.PostRepositoryImpl(postDatasource: gh<_i12.PostDatasource>()));
    gh.factory<_i15.UserBloc>(() => _i15.UserBloc());
    gh.factory<_i16.UserDatasource>(() =>
        _i16.UserDatasource(jsonPlaceholderApi: gh<_i6.JsonPlaceholderApi>()));
    gh.factory<_i17.UserRepository>(() =>
        _i18.UserRepositoryImpl(userDatasource: gh<_i16.UserDatasource>()));
    gh.factory<_i19.AlbumDatasource>(() =>
        _i19.AlbumDatasource(jsonPlaceholderApi: gh<_i6.JsonPlaceholderApi>()));
    gh.factory<_i20.AlbumRepository>(() =>
        _i21.AlbumRepositoryImpl(albumDatasource: gh<_i19.AlbumDatasource>()));
    gh.factory<_i22.CommentDatasource>(() => _i22.CommentDatasource(
        jsonPlaceholderApi: gh<_i6.JsonPlaceholderApi>()));
    gh.factory<_i23.CommentRepository>(() => _i24.CommentRepositoryImpl(
        commentDatasource: gh<_i22.CommentDatasource>()));
    return this;
  }
}

class _$RegisterModule extends _i25.RegisterModule {}

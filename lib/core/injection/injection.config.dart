// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:io' as _i4;

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:teste_ciss/core/injection/injection.dart' as _i21;
import 'package:teste_ciss/data/datasources/album_datasource.dart' as _i18;
import 'package:teste_ciss/data/datasources/photo_datasource.dart' as _i7;
import 'package:teste_ciss/data/datasources/post_datasource.dart' as _i11;
import 'package:teste_ciss/data/datasources/user_datasource.dart' as _i15;
import 'package:teste_ciss/data/repositories/album/album_repository.dart'
    as _i19;
import 'package:teste_ciss/data/repositories/album/album_repository_impl.dart'
    as _i20;
import 'package:teste_ciss/data/repositories/photo/photo_repository.dart'
    as _i8;
import 'package:teste_ciss/data/repositories/photo/photo_repository_impl.dart'
    as _i9;
import 'package:teste_ciss/data/repositories/post/post_repository.dart' as _i12;
import 'package:teste_ciss/data/repositories/post/post_repository_impl.dart'
    as _i13;
import 'package:teste_ciss/data/repositories/user/user_repository.dart' as _i16;
import 'package:teste_ciss/data/repositories/user/user_repository_impl.dart'
    as _i17;
import 'package:teste_ciss/data/services/json_placeholder_api/json_placeholder_api.dart'
    as _i5;
import 'package:teste_ciss/presentation/blocs/album/album_bloc.dart' as _i3;
import 'package:teste_ciss/presentation/blocs/photo/photo_bloc.dart' as _i6;
import 'package:teste_ciss/presentation/blocs/post/post_bloc.dart' as _i10;
import 'package:teste_ciss/presentation/blocs/user/user_bloc.dart' as _i14;

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
    gh.singleton<_i4.HttpClient>(registerModule.http);
    gh.singleton<_i5.JsonPlaceholderApi>(_i5.JsonPlaceholderApi());
    gh.factory<_i6.PhotoBloc>(() => _i6.PhotoBloc());
    gh.factory<_i7.PhotoDatasource>(() =>
        _i7.PhotoDatasource(jsonPlaceholderApi: gh<_i5.JsonPlaceholderApi>()));
    gh.factory<_i8.PhotoRepository>(() =>
        _i9.PhotoRepositoryImpl(photoDatasource: gh<_i7.PhotoDatasource>()));
    gh.factory<_i10.PostBloc>(() => _i10.PostBloc());
    gh.factory<_i11.PostDatasource>(() =>
        _i11.PostDatasource(jsonPlaceholderApi: gh<_i5.JsonPlaceholderApi>()));
    gh.factory<_i12.PostRepository>(() =>
        _i13.PostRepositoryImpl(postDatasource: gh<_i11.PostDatasource>()));
    gh.factory<_i14.UserBloc>(() => _i14.UserBloc());
    gh.factory<_i15.UserDatasource>(() =>
        _i15.UserDatasource(jsonPlaceholderApi: gh<_i5.JsonPlaceholderApi>()));
    gh.factory<_i16.UserRepository>(() =>
        _i17.UserRepositoryImpl(userDatasource: gh<_i15.UserDatasource>()));
    gh.factory<_i18.AlbumDatasource>(() =>
        _i18.AlbumDatasource(jsonPlaceholderApi: gh<_i5.JsonPlaceholderApi>()));
    gh.factory<_i19.AlbumRepository>(() =>
        _i20.AlbumRepositoryImpl(albumDatasource: gh<_i18.AlbumDatasource>()));
    return this;
  }
}

class _$RegisterModule extends _i21.RegisterModule {}

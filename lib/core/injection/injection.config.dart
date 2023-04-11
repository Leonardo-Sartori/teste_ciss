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
import 'package:teste_ciss/core/injection/injection.dart' as _i17;
import 'package:teste_ciss/data/datasources/album_datasource.dart' as _i14;
import 'package:teste_ciss/data/datasources/post_datasource.dart' as _i7;
import 'package:teste_ciss/data/datasources/user_datasource.dart' as _i11;
import 'package:teste_ciss/data/repositories/album/album_repository.dart'
    as _i15;
import 'package:teste_ciss/data/repositories/album/album_repository_impl.dart'
    as _i16;
import 'package:teste_ciss/data/repositories/post/post_repository.dart' as _i8;
import 'package:teste_ciss/data/repositories/post/post_repository_impl.dart'
    as _i9;
import 'package:teste_ciss/data/repositories/user/user_repository.dart' as _i12;
import 'package:teste_ciss/data/repositories/user/user_repository_impl.dart'
    as _i13;
import 'package:teste_ciss/data/services/json_placeholder_api/json_placeholder_api.dart'
    as _i5;
import 'package:teste_ciss/presentation/blocs/album/album_bloc.dart' as _i3;
import 'package:teste_ciss/presentation/blocs/post/post_bloc.dart' as _i6;
import 'package:teste_ciss/presentation/blocs/user/user_bloc.dart' as _i10;

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
    gh.factory<_i6.PostBloc>(() => _i6.PostBloc());
    gh.factory<_i7.PostDatasource>(() =>
        _i7.PostDatasource(jsonPlaceholderApi: gh<_i5.JsonPlaceholderApi>()));
    gh.factory<_i8.PostRepository>(
        () => _i9.PostRepositoryImpl(postDatasource: gh<_i7.PostDatasource>()));
    gh.factory<_i10.UserBloc>(() => _i10.UserBloc());
    gh.factory<_i11.UserDatasource>(() =>
        _i11.UserDatasource(jsonPlaceholderApi: gh<_i5.JsonPlaceholderApi>()));
    gh.factory<_i12.UserRepository>(() =>
        _i13.UserRepositoryImpl(userDatasource: gh<_i11.UserDatasource>()));
    gh.factory<_i14.AlbumDatasource>(() =>
        _i14.AlbumDatasource(jsonPlaceholderApi: gh<_i5.JsonPlaceholderApi>()));
    gh.factory<_i15.AlbumRepository>(() =>
        _i16.AlbumRepositoryImpl(albumDatasource: gh<_i14.AlbumDatasource>()));
    return this;
  }
}

class _$RegisterModule extends _i17.RegisterModule {}

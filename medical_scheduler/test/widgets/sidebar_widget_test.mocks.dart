import 'dart:async' as _i16;
import 'package:flutter/widgets.dart' as _i3;
import 'package:flutter_riverpod/flutter_riverpod.dart' as _i18;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i11;
import 'package:go_router/src/configuration.dart' as _i2;
import 'package:go_router/src/delegate.dart' as _i4;
import 'package:go_router/src/information_provider.dart' as _i5;
import 'package:go_router/src/match.dart' as _i15;
import 'package:go_router/src/parser.dart' as _i6;
import 'package:go_router/src/router.dart' as _i13;
import 'package:go_router/src/state.dart' as _i7;
import 'package:medical_scheduler/Application/Usecases/auth/login.dart' as _i8;
import 'package:medical_scheduler/Application/Usecases/auth/signUp.dart'
    as _i10;
import 'package:medical_scheduler/Application/Usecases/profile/user_profile.dart'
    as _i9;
import 'package:medical_scheduler/presentation/events/Auth/auth_events.dart'
    as _i19;
import 'package:medical_scheduler/presentation/Provider/notifiers/Auth/auth_view_model.dart'
    as _i17;
import 'package:medical_scheduler/presentation/Provider/states/Auth/auth_state.dart'
    as _i12;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i14;
import 'package:state_notifier/state_notifier.dart' as _i20;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: must_be_immutable
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeRouteConfiguration_0 extends _i1.SmartFake
    implements _i2.RouteConfiguration {
  _FakeRouteConfiguration_0(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeBackButtonDispatcher_1 extends _i1.SmartFake
    implements _i3.BackButtonDispatcher {
  _FakeBackButtonDispatcher_1(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeGoRouterDelegate_2 extends _i1.SmartFake
    implements _i4.GoRouterDelegate {
  _FakeGoRouterDelegate_2(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeGoRouteInformationProvider_3 extends _i1.SmartFake
    implements _i5.GoRouteInformationProvider {
  _FakeGoRouteInformationProvider_3(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeGoRouteInformationParser_4 extends _i1.SmartFake
    implements _i6.GoRouteInformationParser {
  _FakeGoRouteInformationParser_4(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeGoRouterState_5 extends _i1.SmartFake implements _i7.GoRouterState {
  _FakeGoRouterState_5(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeLoginUseCase_6 extends _i1.SmartFake implements _i8.LoginUseCase {
  _FakeLoginUseCase_6(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeGetUserUseCase_7 extends _i1.SmartFake
    implements _i9.GetUserUseCase {
  _FakeGetUserUseCase_7(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeRegisterUseCase_8 extends _i1.SmartFake
    implements _i10.RegisterUseCase {
  _FakeRegisterUseCase_8(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeFlutterSecureStorage_9 extends _i1.SmartFake
    implements _i11.FlutterSecureStorage {
  _FakeFlutterSecureStorage_9(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeAuthUiState_10 extends _i1.SmartFake implements _i12.AuthUiState {
  _FakeAuthUiState_10(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

/// A class which mocks [GoRouter].
///
/// See the documentation for Mockito's code generation for more information.
class MockGoRouter extends _i1.Mock implements _i13.GoRouter {
  MockGoRouter() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.RouteConfiguration get configuration =>
      (super.noSuchMethod(
            Invocation.getter(#configuration),
            returnValue: _FakeRouteConfiguration_0(
              this,
              Invocation.getter(#configuration),
            ),
          )
          as _i2.RouteConfiguration);

  @override
  _i3.BackButtonDispatcher get backButtonDispatcher =>
      (super.noSuchMethod(
            Invocation.getter(#backButtonDispatcher),
            returnValue: _FakeBackButtonDispatcher_1(
              this,
              Invocation.getter(#backButtonDispatcher),
            ),
          )
          as _i3.BackButtonDispatcher);

  @override
  _i4.GoRouterDelegate get routerDelegate =>
      (super.noSuchMethod(
            Invocation.getter(#routerDelegate),
            returnValue: _FakeGoRouterDelegate_2(
              this,
              Invocation.getter(#routerDelegate),
            ),
          )
          as _i4.GoRouterDelegate);

  @override
  _i5.GoRouteInformationProvider get routeInformationProvider =>
      (super.noSuchMethod(
            Invocation.getter(#routeInformationProvider),
            returnValue: _FakeGoRouteInformationProvider_3(
              this,
              Invocation.getter(#routeInformationProvider),
            ),
          )
          as _i5.GoRouteInformationProvider);

  @override
  _i6.GoRouteInformationParser get routeInformationParser =>
      (super.noSuchMethod(
            Invocation.getter(#routeInformationParser),
            returnValue: _FakeGoRouteInformationParser_4(
              this,
              Invocation.getter(#routeInformationParser),
            ),
          )
          as _i6.GoRouteInformationParser);

  @override
  bool get overridePlatformDefaultLocation =>
      (super.noSuchMethod(
            Invocation.getter(#overridePlatformDefaultLocation),
            returnValue: false,
          )
          as bool);

  @override
  _i7.GoRouterState get state =>
      (super.noSuchMethod(
            Invocation.getter(#state),
            returnValue: _FakeGoRouterState_5(this, Invocation.getter(#state)),
          )
          as _i7.GoRouterState);

  @override
  set configuration(_i2.RouteConfiguration? _configuration) =>
      super.noSuchMethod(
        Invocation.setter(#configuration, _configuration),
        returnValueForMissingStub: null,
      );

  @override
  set routerDelegate(_i4.GoRouterDelegate? _routerDelegate) =>
      super.noSuchMethod(
        Invocation.setter(#routerDelegate, _routerDelegate),
        returnValueForMissingStub: null,
      );

  @override
  set routeInformationProvider(
    _i5.GoRouteInformationProvider? _routeInformationProvider,
  ) => super.noSuchMethod(
    Invocation.setter(#routeInformationProvider, _routeInformationProvider),
    returnValueForMissingStub: null,
  );

  @override
  set routeInformationParser(
    _i6.GoRouteInformationParser? _routeInformationParser,
  ) => super.noSuchMethod(
    Invocation.setter(#routeInformationParser, _routeInformationParser),
    returnValueForMissingStub: null,
  );

  @override
  bool canPop() =>
      (super.noSuchMethod(Invocation.method(#canPop, []), returnValue: false)
          as bool);

  @override
  String namedLocation(
    String? name, {
    Map<String, String>? pathParameters = const {},
    Map<String, dynamic>? queryParameters = const {},
    String? fragment,
  }) =>
      (super.noSuchMethod(
            Invocation.method(
              #namedLocation,
              [name],
              {
                #pathParameters: pathParameters,
                #queryParameters: queryParameters,
                #fragment: fragment,
              },
            ),
            returnValue: _i14.dummyValue<String>(
              this,
              Invocation.method(
                #namedLocation,
                [name],
                {
                  #pathParameters: pathParameters,
                  #queryParameters: queryParameters,
                  #fragment: fragment,
                },
              ),
            ),
          )
          as String);

  @override
  void go(String? location, {Object? extra}) => super.noSuchMethod(
    Invocation.method(#go, [location], {#extra: extra}),
    returnValueForMissingStub: null,
  );

  @override
  void restore(_i15.RouteMatchList? matchList) => super.noSuchMethod(
    Invocation.method(#restore, [matchList]),
    returnValueForMissingStub: null,
  );

  @override
  void goNamed(
    String? name, {
    Map<String, String>? pathParameters = const {},
    Map<String, dynamic>? queryParameters = const {},
    Object? extra,
    String? fragment,
  }) => super.noSuchMethod(
    Invocation.method(
      #goNamed,
      [name],
      {
        #pathParameters: pathParameters,
        #queryParameters: queryParameters,
        #extra: extra,
        #fragment: fragment,
      },
    ),
    returnValueForMissingStub: null,
  );

  @override
  _i16.Future<T?> push<T extends Object?>(String? location, {Object? extra}) =>
      (super.noSuchMethod(
            Invocation.method(#push, [location], {#extra: extra}),
            returnValue: _i16.Future<T?>.value(),
          )
          as _i16.Future<T?>);

  @override
  _i16.Future<T?> pushNamed<T extends Object?>(
    String? name, {
    Map<String, String>? pathParameters = const {},
    Map<String, dynamic>? queryParameters = const {},
    Object? extra,
  }) =>
      (super.noSuchMethod(
            Invocation.method(
              #pushNamed,
              [name],
              {
                #pathParameters: pathParameters,
                #queryParameters: queryParameters,
                #extra: extra,
              },
            ),
            returnValue: _i16.Future<T?>.value(),
          )
          as _i16.Future<T?>);

  @override
  _i16.Future<T?> pushReplacement<T extends Object?>(
    String? location, {
    Object? extra,
  }) =>
      (super.noSuchMethod(
            Invocation.method(#pushReplacement, [location], {#extra: extra}),
            returnValue: _i16.Future<T?>.value(),
          )
          as _i16.Future<T?>);

  @override
  _i16.Future<T?> pushReplacementNamed<T extends Object?>(
    String? name, {
    Map<String, String>? pathParameters = const {},
    Map<String, dynamic>? queryParameters = const {},
    Object? extra,
  }) =>
      (super.noSuchMethod(
            Invocation.method(
              #pushReplacementNamed,
              [name],
              {
                #pathParameters: pathParameters,
                #queryParameters: queryParameters,
                #extra: extra,
              },
            ),
            returnValue: _i16.Future<T?>.value(),
          )
          as _i16.Future<T?>);

  @override
  _i16.Future<T?> replace<T>(String? location, {Object? extra}) =>
      (super.noSuchMethod(
            Invocation.method(#replace, [location], {#extra: extra}),
            returnValue: _i16.Future<T?>.value(),
          )
          as _i16.Future<T?>);

  @override
  _i16.Future<T?> replaceNamed<T>(
    String? name, {
    Map<String, String>? pathParameters = const {},
    Map<String, dynamic>? queryParameters = const {},
    Object? extra,
  }) =>
      (super.noSuchMethod(
            Invocation.method(
              #replaceNamed,
              [name],
              {
                #pathParameters: pathParameters,
                #queryParameters: queryParameters,
                #extra: extra,
              },
            ),
            returnValue: _i16.Future<T?>.value(),
          )
          as _i16.Future<T?>);

  @override
  void pop<T extends Object?>([T? result]) => super.noSuchMethod(
    Invocation.method(#pop, [result]),
    returnValueForMissingStub: null,
  );

  @override
  void refresh() => super.noSuchMethod(
    Invocation.method(#refresh, []),
    returnValueForMissingStub: null,
  );

  @override
  void dispose() => super.noSuchMethod(
    Invocation.method(#dispose, []),
    returnValueForMissingStub: null,
  );
}

/// A class which mocks [AuthViewModel].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthViewModel extends _i1.Mock implements _i17.AuthViewModel {
  MockAuthViewModel() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i8.LoginUseCase get loginUseCase =>
      (super.noSuchMethod(
            Invocation.getter(#loginUseCase),
            returnValue: _FakeLoginUseCase_6(
              this,
              Invocation.getter(#loginUseCase),
            ),
          )
          as _i8.LoginUseCase);

  @override
  _i9.GetUserUseCase get getUserUseCase =>
      (super.noSuchMethod(
            Invocation.getter(#getUserUseCase),
            returnValue: _FakeGetUserUseCase_7(
              this,
              Invocation.getter(#getUserUseCase),
            ),
          )
          as _i9.GetUserUseCase);

  @override
  _i10.RegisterUseCase get registerUseCase =>
      (super.noSuchMethod(
            Invocation.getter(#registerUseCase),
            returnValue: _FakeRegisterUseCase_8(
              this,
              Invocation.getter(#registerUseCase),
            ),
          )
          as _i10.RegisterUseCase);

  @override
  _i11.FlutterSecureStorage get storage =>
      (super.noSuchMethod(
            Invocation.getter(#storage),
            returnValue: _FakeFlutterSecureStorage_9(
              this,
              Invocation.getter(#storage),
            ),
          )
          as _i11.FlutterSecureStorage);

  @override
  bool get mounted =>
      (super.noSuchMethod(Invocation.getter(#mounted), returnValue: false)
          as bool);

  @override
  _i16.Stream<_i12.AuthUiState> get stream =>
      (super.noSuchMethod(
            Invocation.getter(#stream),
            returnValue: _i16.Stream<_i12.AuthUiState>.empty(),
          )
          as _i16.Stream<_i12.AuthUiState>);

  @override
  _i12.AuthUiState get state =>
      (super.noSuchMethod(
            Invocation.getter(#state),
            returnValue: _FakeAuthUiState_10(this, Invocation.getter(#state)),
          )
          as _i12.AuthUiState);

  @override
  _i12.AuthUiState get debugState =>
      (super.noSuchMethod(
            Invocation.getter(#debugState),
            returnValue: _FakeAuthUiState_10(
              this,
              Invocation.getter(#debugState),
            ),
          )
          as _i12.AuthUiState);

  @override
  bool get hasListeners =>
      (super.noSuchMethod(Invocation.getter(#hasListeners), returnValue: false)
          as bool);

  @override
  set onError(_i18.ErrorListener? _onError) => super.noSuchMethod(
    Invocation.setter(#onError, _onError),
    returnValueForMissingStub: null,
  );

  @override
  set state(_i12.AuthUiState? value) => super.noSuchMethod(
    Invocation.setter(#state, value),
    returnValueForMissingStub: null,
  );

  @override
  void onEvent(_i19.AuthEvent? event) => super.noSuchMethod(
    Invocation.method(#onEvent, [event]),
    returnValueForMissingStub: null,
  );

  @override
  _i16.Future<void> checkLoginStatus() =>
      (super.noSuchMethod(
            Invocation.method(#checkLoginStatus, []),
            returnValue: _i16.Future<void>.value(),
            returnValueForMissingStub: _i16.Future<void>.value(),
          )
          as _i16.Future<void>);

  @override
  _i16.Future<void> logout() =>
      (super.noSuchMethod(
            Invocation.method(#logout, []),
            returnValue: _i16.Future<void>.value(),
            returnValueForMissingStub: _i16.Future<void>.value(),
          )
          as _i16.Future<void>);

  @override
  bool updateShouldNotify(_i12.AuthUiState? old, _i12.AuthUiState? current) =>
      (super.noSuchMethod(
            Invocation.method(#updateShouldNotify, [old, current]),
            returnValue: false,
          )
          as bool);

  @override
  _i18.RemoveListener addListener(
    _i20.Listener<_i12.AuthUiState>? listener, {
    bool? fireImmediately = true,
  }) =>
      (super.noSuchMethod(
            Invocation.method(
              #addListener,
              [listener],
              {#fireImmediately: fireImmediately},
            ),
            returnValue: () {},
          )
          as _i18.RemoveListener);

  @override
  void dispose() => super.noSuchMethod(
    Invocation.method(#dispose, []),
    returnValueForMissingStub: null,
  );
}

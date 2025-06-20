import 'dart:async' as _i15;
import 'package:flutter/widgets.dart' as _i3;
import 'package:flutter_riverpod/flutter_riverpod.dart' as _i11;
import 'package:go_router/src/configuration.dart' as _i2;
import 'package:go_router/src/delegate.dart' as _i4;
import 'package:go_router/src/information_provider.dart' as _i5;
import 'package:go_router/src/match.dart' as _i14;
import 'package:go_router/src/parser.dart' as _i6;
import 'package:go_router/src/router.dart' as _i12;
import 'package:go_router/src/state.dart' as _i7;
import 'package:medical_scheduler/Application/Usecases/queue/getQueues.dart'
    as _i9;
import 'package:medical_scheduler/Application/Usecases/queue/update_queue.dart'
    as _i8;
import 'package:medical_scheduler/presentation/events/Doctor/doctor_queue_events.dart'
    as _i17;
import 'package:medical_scheduler/presentation/Provider/notifiers/Doctor/doctor_queue_view_model.dart'
    as _i16;
import 'package:medical_scheduler/presentation/Provider/states/Common/queue_state.dart'
    as _i10;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i13;
import 'package:state_notifier/state_notifier.dart' as _i18;

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

class _FakeUpdateQueue_6 extends _i1.SmartFake implements _i8.UpdateQueue {
  _FakeUpdateQueue_6(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeGetAllQueues_7 extends _i1.SmartFake implements _i9.GetAllQueues {
  _FakeGetAllQueues_7(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeQueueUiState_8 extends _i1.SmartFake implements _i10.QueueUiState {
  _FakeQueueUiState_8(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeProviderContainer_9 extends _i1.SmartFake
    implements _i11.ProviderContainer {
  _FakeProviderContainer_9(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeKeepAliveLink_10 extends _i1.SmartFake
    implements _i11.KeepAliveLink {
  _FakeKeepAliveLink_10(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeProviderSubscription_11<State1> extends _i1.SmartFake
    implements _i11.ProviderSubscription<State1> {
  _FakeProviderSubscription_11(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

/// A class which mocks [GoRouter].
///
/// See the documentation for Mockito's code generation for more information.
class MockGoRouter extends _i1.Mock implements _i12.GoRouter {
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
            returnValue: _i13.dummyValue<String>(
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
  void restore(_i14.RouteMatchList? matchList) => super.noSuchMethod(
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
  _i15.Future<T?> push<T extends Object?>(String? location, {Object? extra}) =>
      (super.noSuchMethod(
            Invocation.method(#push, [location], {#extra: extra}),
            returnValue: _i15.Future<T?>.value(),
          )
          as _i15.Future<T?>);

  @override
  _i15.Future<T?> pushNamed<T extends Object?>(
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
            returnValue: _i15.Future<T?>.value(),
          )
          as _i15.Future<T?>);

  @override
  _i15.Future<T?> pushReplacement<T extends Object?>(
    String? location, {
    Object? extra,
  }) =>
      (super.noSuchMethod(
            Invocation.method(#pushReplacement, [location], {#extra: extra}),
            returnValue: _i15.Future<T?>.value(),
          )
          as _i15.Future<T?>);

  @override
  _i15.Future<T?> pushReplacementNamed<T extends Object?>(
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
            returnValue: _i15.Future<T?>.value(),
          )
          as _i15.Future<T?>);

  @override
  _i15.Future<T?> replace<T>(String? location, {Object? extra}) =>
      (super.noSuchMethod(
            Invocation.method(#replace, [location], {#extra: extra}),
            returnValue: _i15.Future<T?>.value(),
          )
          as _i15.Future<T?>);

  @override
  _i15.Future<T?> replaceNamed<T>(
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
            returnValue: _i15.Future<T?>.value(),
          )
          as _i15.Future<T?>);

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

/// A class which mocks [DoctorQueueNotifier].
///
/// See the documentation for Mockito's code generation for more information.
class MockDoctorQueueNotifier extends _i1.Mock
    implements _i16.DoctorQueueNotifier {
  MockDoctorQueueNotifier() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i8.UpdateQueue get updateQueueUseCase =>
      (super.noSuchMethod(
            Invocation.getter(#updateQueueUseCase),
            returnValue: _FakeUpdateQueue_6(
              this,
              Invocation.getter(#updateQueueUseCase),
            ),
          )
          as _i8.UpdateQueue);

  @override
  _i9.GetAllQueues get getAllQueues =>
      (super.noSuchMethod(
            Invocation.getter(#getAllQueues),
            returnValue: _FakeGetAllQueues_7(
              this,
              Invocation.getter(#getAllQueues),
            ),
          )
          as _i9.GetAllQueues);

  @override
  bool get mounted =>
      (super.noSuchMethod(Invocation.getter(#mounted), returnValue: false)
          as bool);

  @override
  _i15.Stream<_i10.QueueUiState> get stream =>
      (super.noSuchMethod(
            Invocation.getter(#stream),
            returnValue: _i15.Stream<_i10.QueueUiState>.empty(),
          )
          as _i15.Stream<_i10.QueueUiState>);

  @override
  _i10.QueueUiState get state =>
      (super.noSuchMethod(
            Invocation.getter(#state),
            returnValue: _FakeQueueUiState_8(this, Invocation.getter(#state)),
          )
          as _i10.QueueUiState);

  @override
  _i10.QueueUiState get debugState =>
      (super.noSuchMethod(
            Invocation.getter(#debugState),
            returnValue: _FakeQueueUiState_8(
              this,
              Invocation.getter(#debugState),
            ),
          )
          as _i10.QueueUiState);

  @override
  bool get hasListeners =>
      (super.noSuchMethod(Invocation.getter(#hasListeners), returnValue: false)
          as bool);

  @override
  set onError(_i11.ErrorListener? _onError) => super.noSuchMethod(
    Invocation.setter(#onError, _onError),
    returnValueForMissingStub: null,
  );

  @override
  set state(_i10.QueueUiState? value) => super.noSuchMethod(
    Invocation.setter(#state, value),
    returnValueForMissingStub: null,
  );

  @override
  _i15.Future<void> mapEventToState(_i17.DoctorQueueEvent? event) =>
      (super.noSuchMethod(
            Invocation.method(#mapEventToState, [event]),
            returnValue: _i15.Future<void>.value(),
            returnValueForMissingStub: _i15.Future<void>.value(),
          )
          as _i15.Future<void>);

  @override
  _i15.Future<void> filterQueues(String? query) =>
      (super.noSuchMethod(
            Invocation.method(#filterQueues, [query]),
            returnValue: _i15.Future<void>.value(),
            returnValueForMissingStub: _i15.Future<void>.value(),
          )
          as _i15.Future<void>);

  @override
  bool updateShouldNotify(_i10.QueueUiState? old, _i10.QueueUiState? current) =>
      (super.noSuchMethod(
            Invocation.method(#updateShouldNotify, [old, current]),
            returnValue: false,
          )
          as bool);

  @override
  _i11.RemoveListener addListener(
    _i18.Listener<_i10.QueueUiState>? listener, {
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
          as _i11.RemoveListener);

  @override
  void dispose() => super.noSuchMethod(
    Invocation.method(#dispose, []),
    returnValueForMissingStub: null,
  );
}

/// A class which mocks [ProviderRef].
///
/// See the documentation for Mockito's code generation for more information.
class MockProviderRef<State> extends _i1.Mock
    implements _i11.ProviderRef<State> {
  MockProviderRef() {
    _i1.throwOnMissingStub(this);
  }

  @override
  State get state =>
      (super.noSuchMethod(
            Invocation.getter(#state),
            returnValue: _i13.dummyValue<State>(
              this,
              Invocation.getter(#state),
            ),
          )
          as State);

  @override
  set state(State? newState) => super.noSuchMethod(
    Invocation.setter(#state, newState),
    returnValueForMissingStub: null,
  );

  @override
  _i11.ProviderContainer get container =>
      (super.noSuchMethod(
            Invocation.getter(#container),
            returnValue: _FakeProviderContainer_9(
              this,
              Invocation.getter(#container),
            ),
          )
          as _i11.ProviderContainer);

  @override
  T refresh<T>(_i11.Refreshable<T>? provider) =>
      (super.noSuchMethod(
            Invocation.method(#refresh, [provider]),
            returnValue: _i13.dummyValue<T>(
              this,
              Invocation.method(#refresh, [provider]),
            ),
          )
          as T);

  @override
  void invalidate(_i11.ProviderOrFamily? provider) => super.noSuchMethod(
    Invocation.method(#invalidate, [provider]),
    returnValueForMissingStub: null,
  );

  @override
  void notifyListeners() => super.noSuchMethod(
    Invocation.method(#notifyListeners, []),
    returnValueForMissingStub: null,
  );

  @override
  void listenSelf(
    void Function(State?, State)? listener, {
    void Function(Object, StackTrace)? onError,
  }) => super.noSuchMethod(
    Invocation.method(#listenSelf, [listener], {#onError: onError}),
    returnValueForMissingStub: null,
  );

  @override
  void invalidateSelf() => super.noSuchMethod(
    Invocation.method(#invalidateSelf, []),
    returnValueForMissingStub: null,
  );

  @override
  void onAddListener(void Function()? cb) => super.noSuchMethod(
    Invocation.method(#onAddListener, [cb]),
    returnValueForMissingStub: null,
  );

  @override
  void onRemoveListener(void Function()? cb) => super.noSuchMethod(
    Invocation.method(#onRemoveListener, [cb]),
    returnValueForMissingStub: null,
  );

  @override
  void onResume(void Function()? cb) => super.noSuchMethod(
    Invocation.method(#onResume, [cb]),
    returnValueForMissingStub: null,
  );

  @override
  void onCancel(void Function()? cb) => super.noSuchMethod(
    Invocation.method(#onCancel, [cb]),
    returnValueForMissingStub: null,
  );

  @override
  void onDispose(void Function()? cb) => super.noSuchMethod(
    Invocation.method(#onDispose, [cb]),
    returnValueForMissingStub: null,
  );

  @override
  T read<T>(_i11.ProviderListenable<T>? provider) =>
      (super.noSuchMethod(
            Invocation.method(#read, [provider]),
            returnValue: _i13.dummyValue<T>(
              this,
              Invocation.method(#read, [provider]),
            ),
          )
          as T);

  @override
  bool exists(_i11.ProviderBase<Object?>? provider) =>
      (super.noSuchMethod(
            Invocation.method(#exists, [provider]),
            returnValue: false,
          )
          as bool);

  @override
  T watch<T>(_i11.ProviderListenable<T>? provider) =>
      (super.noSuchMethod(
            Invocation.method(#watch, [provider]),
            returnValue: _i13.dummyValue<T>(
              this,
              Invocation.method(#watch, [provider]),
            ),
          )
          as T);

  @override
  _i11.KeepAliveLink keepAlive() =>
      (super.noSuchMethod(
            Invocation.method(#keepAlive, []),
            returnValue: _FakeKeepAliveLink_10(
              this,
              Invocation.method(#keepAlive, []),
            ),
          )
          as _i11.KeepAliveLink);

  @override
  _i11.ProviderSubscription<T> listen<T>(
    _i11.ProviderListenable<T>? provider,
    void Function(T?, T)? listener, {
    void Function(Object, StackTrace)? onError,
    bool? fireImmediately,
  }) =>
      (super.noSuchMethod(
            Invocation.method(
              #listen,
              [provider, listener],
              {#onError: onError, #fireImmediately: fireImmediately},
            ),
            returnValue: _FakeProviderSubscription_11<T>(
              this,
              Invocation.method(
                #listen,
                [provider, listener],
                {#onError: onError, #fireImmediately: fireImmediately},
              ),
            ),
          )
          as _i11.ProviderSubscription<T>);
}

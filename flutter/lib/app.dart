import 'package:customer_zimkey/data/provider/checkout_provider.dart';
import 'package:customer_zimkey/data/provider/services_provider.dart';
import 'package:customer_zimkey/ui/services/widgets/3_build_payment/bloc/checkout_bloc/checkout_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_services/connectivity/bloc/connectivity_bloc.dart';
import 'app_services/connectivity/connectivity_service.dart';
import 'data/cubit/theme_cubit.dart';
import 'data/provider/address_provider.dart';
import 'data/provider/schedule_provider.dart';
import 'navigation/route_generator.dart';
import 'ui/services/cubit/calculate_service_cost_cubit.dart';
import 'ui/services/cubit/overview_data_cubit.dart';
import 'ui/services/widgets/3_build_payment/bloc/summary_bloc/summary_bloc.dart';

class App extends StatelessWidget {
  /// {@macro app}
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => ConnectivityService()),
        RepositoryProvider(create: (context) => ServicesProvider()),
        RepositoryProvider(create: (context) => ScheduleProvider()),
        RepositoryProvider(create: (context) => AddressProvider()),
        RepositoryProvider(create: (context) => CheckoutProvider()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => ThemeCubit()),
          BlocProvider(create: (_) => OverviewDataCubit()),
          BlocProvider(create: (_) => CalculatedServiceCostCubit()),
          BlocProvider(
              create: (context) =>
                  ConnectivityBloc(connectivityService: RepositoryProvider.of<ConnectivityService>(context))),
          BlocProvider(
              create: (context) => CheckoutBloc(checkoutProvider: RepositoryProvider.of<CheckoutProvider>(context))),
          BlocProvider(
              create: (context) => SummaryBloc(checkoutProvider: RepositoryProvider.of<CheckoutProvider>(context))),
        ],
        child: const AppView(),
      ),
    );
  }
}

/// A [StatelessWidget] that:
/// * reacts to state changes in the [ThemeCubit]
/// and updates the theme of the [MaterialApp].
/// * renders the initial route.
class AppView extends StatelessWidget {
  /// {@macro app_view}
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeData>(
      builder: (_, theme) {
        return MaterialApp(
          theme: theme,
          builder: (context, child) {
            return MediaQuery(
              // Set the default textScaleFactor to 1.0 for the whole subtree.
              data: MediaQuery.of(context)
                  .copyWith(textScaleFactor: MediaQuery.of(context).size.shortestSide < 600 ? 0.85 : 1.5),
              child: child!,
            );
          },
          initialRoute: RouteGenerator.splashScreen,
          onGenerateRoute: RouteGenerator.generateRoute,
        );
      },
    );
  }
}

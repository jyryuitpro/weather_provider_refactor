import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:weather_provider_refactor/pages/home_page.dart';
import 'package:weather_provider_refactor/providers/temp_settings_provider.dart';
import 'package:weather_provider_refactor/providers/theme_provider.dart';
import 'package:weather_provider_refactor/providers/weather_provider.dart';
import 'package:weather_provider_refactor/repositories/weather_repository.dart';
import 'package:weather_provider_refactor/services/weather_api_services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<WeatherRepository>(
          create: (context) {
            final WeatherApiservices weatherApiServices =
                WeatherApiservices(httpClient: http.Client());
            return WeatherRepository(weatherApiservices: weatherApiServices);
          },
        ),
        ChangeNotifierProvider<WeatherProvider>(
          create: (context) => WeatherProvider(
            weatherRepository: context.read<WeatherRepository>(),
          ),
        ),
        ChangeNotifierProvider<TempSettingsProvider>(
          create: (context) => TempSettingsProvider(),
        ),
        ProxyProvider<WeatherProvider, ThemeProvider>(
          update: (
            BuildContext context,
            WeatherProvider weatherProvider,
            ThemeProvider? _,
          ) =>
              ThemeProvider(weatherProvider: weatherProvider),
        ),
      ],
      builder: (context, _) => MaterialApp(
        title: 'Weather App',
        debugShowCheckedModeBanner: false,
        theme: context.watch<ThemeProvider>().state.appTheme == AppTheme.light
            ? ThemeData.light()
            : ThemeData.dark(),
        home: HomePage(),
      ),
    );
  }
}

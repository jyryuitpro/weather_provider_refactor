import 'package:equatable/equatable.dart';
import 'package:weather_provider_refactor/constants/constants.dart';
import 'package:weather_provider_refactor/providers/weather_provider.dart';

enum AppTheme {
  light,
  dark,
}

class ThemeState extends Equatable {
  final AppTheme appTheme;

  ThemeState({
    this.appTheme = AppTheme.light,
  });

  factory ThemeState.initial() {
    return ThemeState();
  }

  @override
  List<Object?> get props => [appTheme];

  @override
  bool get stringify => true;

  ThemeState copyWith({
    AppTheme? appTheme,
  }) {
    return ThemeState(
      appTheme: appTheme ?? this.appTheme,
    );
  }
}

class ThemeProvider {
  final WeatherProvider weatherProvider;

  ThemeProvider({
    required this.weatherProvider,
  });

  ThemeState get state {
    if (weatherProvider.state.weather.theTemp > kWarmOrNot) {
      return ThemeState();
    } else {
      return ThemeState(appTheme: AppTheme.dark);
    }
  }
}
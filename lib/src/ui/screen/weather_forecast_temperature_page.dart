import 'package:feather/src/models/internal/chart_data.dart';
import 'package:feather/src/models/internal/point.dart';
import 'package:feather/src/models/internal/weather_forecast_holder.dart';
import 'package:feather/src/resources/application_localization.dart';
import 'package:feather/src/resources/config/assets.dart';
import 'package:feather/src/resources/weather_helper.dart';
import 'package:feather/src/ui/screen/base/weather_forecast_base_page.dart';
import 'package:feather/src/ui/widget/widget_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WeatherForecastTemperaturePage extends WeatherForecastBasePage {
  WeatherForecastTemperaturePage(
      WeatherForecastHolder holder, double width, double height)
      : super(holder: holder, width: width, height: height);

  @override
  Widget getBottomRowWidget(BuildContext context) {
    List<Point> points = getChartData().points;
    List<Widget> widgets = new List();
    if (points.length > 2) {
      double padding = points[1].x - points[0].x - 30;
      widgets.add(WidgetHelper.buildPadding(top: 5));
      for (int index = 0; index < points.length; index++) {
        widgets.add(Image.asset(
            WeatherHelper.getWeatherIcon(
                holder.forecastList[index].overallWeatherData[0].id),
            width: 30,
            height: 30));
        widgets.add(WidgetHelper.buildPadding(left: padding));
      }
      widgets.removeLast();
    }

    return Row(
        key: Key("weather_forecast_temperature_page_bottom_row"),
        mainAxisAlignment: MainAxisAlignment.center,
        children: widgets);
  }

  @override
  ChartData getChartData() {
    return holder.setupChartData(ChartDataType.temperature, width, height);
  }

  @override
  String getIcon() {
    return Assets.iconThermometer;
  }

  @override
  RichText getPageSubtitleWidget(BuildContext context) {
    return RichText(
        key: Key("weather_forecast_temperature_page_subtitle"),
        textDirection: TextDirection.ltr,
        text: TextSpan(children: [
          TextSpan(text: 'min ', style: Theme.of(context).textTheme.body2),
          TextSpan(
              text:
                  "${WeatherHelper.formatTemperature(temperature: holder.minTemperature, positions: 1, round: false)}",
              style: Theme.of(context).textTheme.subtitle),
          TextSpan(text: '   max ', style: Theme.of(context).textTheme.body2),
          TextSpan(
              text:
                  "${WeatherHelper.formatTemperature(temperature: holder.maxTemperature, positions: 1, round: false)}",
              style: Theme.of(context).textTheme.subtitle)
        ]));
  }

  @override
  String getTitleText(BuildContext context) {
    return ApplicationLocalization.of(context).getText("temperature");
  }
}

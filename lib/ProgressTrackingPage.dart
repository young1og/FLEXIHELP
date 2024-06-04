import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ProgressTrackingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Создание данных для графика
    final List<charts.Series<LinearSales, int>> seriesList = _createSampleData();

    return Scaffold(
      appBar: AppBar(
        title: Text('Progress Tracking'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.lightBlueAccent,
              Colors.lightBlue,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Your Progress Over Time',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.0),
              Container(
                height: 300,
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8.0,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: charts.LineChart(seriesList, animate: true),
              ),
              SizedBox(height: 16.0),
              Text(
                'Analysis',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Here you can see how your progress has changed over time. The data represented here helps you understand your growth and identify areas for improvement.',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DetailedReportPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                ),
                child: Text(
                  'View Detailed Report',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Функция для создания данных
  List<charts.Series<LinearSales, int>> _createSampleData() {
    final data = [
      LinearSales(0, 3),
      LinearSales(0, 7),
      LinearSales(1, 21),
      LinearSales(2, 50),
      LinearSales(3, 75),
      LinearSales(4, 104),
    ];

    return [
      charts.Series<LinearSales, int>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}

// Класс для представления данных
class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}

// Создание новой страницы DetailedReportPage
class DetailedReportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Данные для столбчатого графика
    final barSeries = _createBarData();

    // Данные для кругового графика
    final pieSeries = _createPieData();

    return Scaffold(
      appBar: AppBar(
        title: Text('Detailed Report'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.lightBlueAccent,
              Colors.lightBlue,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: ListView(
            children: [
              Text(
                'Detailed Report',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.0),
              Container(
                height: 300,
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8.0,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: charts.BarChart(barSeries, animate: true),
              ),
              SizedBox(height: 16.0),
              Container(
                height: 300,
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8.0,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: charts.PieChart(
                  pieSeries,
                  animate: true,
                  defaultRenderer: charts.ArcRendererConfig(
                    arcWidth: 60,
                    arcRendererDecorators: [charts.ArcLabelDecorator()],
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'This page contains detailed analysis and additional data visualizations to provide deeper insights into your progress.',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Функция для создания данных для столбчатого графика
  List<charts.Series<OrdinalSales, String>> _createBarData() {
    final data = [
      OrdinalSales('Medicine A', 5),
      OrdinalSales('Medicine B', 25),
      OrdinalSales('Medicine C', 100),
      OrdinalSales('Medicine D', 75),
    ];

    return [
      charts.Series<OrdinalSales, String>(
        id: 'Medications',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (OrdinalSales sales, _) => sales.medicine,
        measureFn: (OrdinalSales sales, _) => sales.count,
        data: data,
      )
    ];
  }

  // Функция для создания данных для кругового графика
  List<charts.Series<PieData, String>> _createPieData() {
    final data = [
      PieData('Used', 75),
      PieData('Missed', 25),
    ];

    return [
      charts.Series<PieData, String>(
        id: 'Compliance',
        colorFn: (PieData data, _) {
          switch (data.label) {
            case 'Used':
              return charts.MaterialPalette.blue.shadeDefault;
            case 'Missed':
              return charts.MaterialPalette.red.shadeDefault;
            default:
              return charts.MaterialPalette.gray.shadeDefault;
          }
        },
        domainFn: (PieData data, _) => data.label,
        measureFn: (PieData data, _) => data.value,
        data: data,
        labelAccessorFn: (PieData row, _) => '${row.label}: ${row.value}%',
      )
    ];
  }
}

// Класс для представления данных для столбчатого графика
class OrdinalSales {
  final String medicine;
  final int count;

  OrdinalSales(this.medicine, this.count);
}

// Класс для представления данных для кругового графика
class PieData {
  final String label;
  final int value;

  PieData(this.label, this.value);
}
List<charts.Series<PieData, String>> _createPieData() {
  final data = [
    PieData('Used', 75),
    PieData('Missed', 25),
  ];

  return [
    charts.Series<PieData, String>(
      id: 'Compliance',
      colorFn: (PieData data, _) {
        switch (data.label) {
          case 'Used':
            return charts.MaterialPalette.blue.shadeDefault;
          case 'Missed':
            return charts.MaterialPalette.red.shadeDefault;
          default:
            return charts.MaterialPalette.gray.shadeDefault;
        }
      },
      domainFn: (PieData data, _) => data.label,
      measureFn: (PieData data, _) => data.value,
      data: data,
      labelAccessorFn: (PieData row, _) => '${row.label}: ${row.value}%',
    )
  ];
}

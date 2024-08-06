import 'package:flutter/material.dart';

const Color primaryColor = Color(0xFF1E88E5);
const Color secondaryColor = Color(0xFF64B5F6);
const Color backgroundColor = Color(0xFF2196F3);

const TextStyle cityTextStyle = TextStyle(
  fontSize: 28,
  fontWeight: FontWeight.bold,
  color: Colors.black87,
);

const TextStyle temperatureTextStyle = TextStyle(
  fontSize: 48,
  fontWeight: FontWeight.bold,
  color: Colors.blueAccent,
);

const TextStyle descriptionTextStyle = TextStyle(
  fontSize: 24,
  color: Colors.black54,
);

const TextStyle detailTextStyle = TextStyle(
  fontSize: 18,
  color: Colors.black54,
);

const TextStyle forecastTitleTextStyle = TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.bold,
  color: Colors.black87,
);

const TextStyle forecastDateTextStyle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
  color: Colors.black87,
);

const TextStyle forecastTempTextStyle = TextStyle(
  fontSize: 18,
  color: Colors.black54,
);

const TextStyle weatherTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 20,
);

const TextStyle detailLabelTextStyle = TextStyle(
  color: Colors.white70,
  fontSize: 14,
);

const TextStyle detailValueTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 16,
  fontWeight: FontWeight.bold,
);

final InputDecoration inputDecoration = InputDecoration(
  labelText: 'City Name',
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.0),
  ),
  suffixIcon: const Icon(Icons.search),
);

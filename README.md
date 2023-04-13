<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

# Calculate distances, durations & Get shortest route/leg between two points with Google_Maps Directions API

## Features

- Calculate distance (corresponding to shortest route distance evaluation) between two points.
- Get shortest route between two points.
- Get shortest leg between two points.
- Sort points (destinations) by distance from uniq origin.

## Getting started

- Point : Object with latitude and longitude.
- Route : Path on foot, motorcycle, car between two points.

## Usage

You need to have a valid Google Maps Routes API Key.

```dart
const String googleAPIKey = "GOOGLE_API_KEY";

//You can init the Package with this API_Key so you don't have to pass it as an argument to it's methods.

GoogleMapsDistance.init(googleAPIKey: googleAPIKey);
```

### Distance

```dart
import "package:google_maps_directions/google_maps_directions.dart" as gmp;

DistanceValue distanceBetween = await gmp.distance(9.2460524, 1.2144565, 6.1271617, 1.2345417, googleAPIKey : googleAPIKey); //gmp.distance(9.2460524, 1.2144565, 6.1271617, 1.2345417) or without passing the API_KEY if the plugin is already initialized with it's value.

int meters = distanceBetween.meters // await gmp.distanceInMeters(9.2460524, 1.2144565, 6.1271617, 1.2345417, googleAPIKey : googleAPIKey);

String textInKmOrMeters = distanceBetween.text // await gmp.distanceText(9.2460524, 1.2144565, 6.1271617, 1.2345417, googleAPIKey : googleAPIKey);
```

### Duration

```dart
import "package:google_maps_directions/google_maps_directions.dart" as gmp;

DurationValue durationBetween = await gmp.duration(9.2460524, 1.2144565, 6.1271617, 1.2345417, googleAPIKey : googleAPIKey);

int seconds = durationBetween.seconds//await gmp.durationInSeconds(9.2460524, 1.2144565, 6.1271617, 1.2345417, googleAPIKey : googleAPIKey);

String durationInMinutesOrHours = gmp.durationBetween.text // await gmp.durationText(9.2460524, 1.2144565, 6.1271617, 1.2345417, googleAPIKey : googleAPIKey);
```

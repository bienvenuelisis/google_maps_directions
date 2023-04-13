# Calculez les distances, les durées et obtenez l'itinéraire/l'étape le plus court entre deux points avec l'API Google_Maps Directions

## Fonctionnalités

- Calculer la distance (correspondant à l'évaluation de la distance de l'itinéraire le plus court) entre deux points.
- Obtenez l'itinéraire le plus court entre deux points.
- Obtenez la route la plus courte entre deux points.
- Trier les points (destinations) par distance depuis un point de départ.

## Initialisation

- Point : Objet avec latitude et longitude.
- Route : Itinéraire, chemin à pied, moto, voiture entre deux points.

## Utilisation

Vous devez disposer d'une clé API Google Maps Routes valide.

```dart
const String googleAPIKey = "GOOGLE_API_KEY";

//Vous pouvez initialiser le package avec cette API_Key afin de ne pas avoir à le transmettre en tant qu'argument à ses méthodes.

GoogleMapsDirections.init(googleAPIKey: googleAPIKey);
```

### Distance

```dart
import "package:google_maps_directions/google_maps_directions.dart" as gmd;

DistanceValue distanceBetween = await gmd.distance(9.2460524, 1.2144565, 6.1271617, 1.2345417, googleAPIKey : googleAPIKey); //gmd.distance(9.2460524, 1.2144565, 6.1271617, 1.2345417) ou sans passer l'API_KEY si le plugin est déjà initialisé avec sa valeur.

int meters = distanceBetween.meters // await gmd.distanceInMeters(9.2460524, 1.2144565, 6.1271617, 1.2345417, googleAPIKey : googleAPIKey);

String textInKmOrMeters = distanceBetween.text // await gmd.distanceText(9.2460524, 1.2144565, 6.1271617, 1.2345417, googleAPIKey : googleAPIKey);
```

### Duration

```dart
import "package:google_maps_directions/google_maps_directions.dart" as gmd;

DurationValue durationBetween = await gmd.duration(9.2460524, 1.2144565, 6.1271617, 1.2345417, googleAPIKey : googleAPIKey);

int seconds = durationBetween.seconds//await gmd.durationInSeconds(9.2460524, 1.2144565, 6.1271617, 1.2345417, googleAPIKey : googleAPIKey);

String durationInMinutesOrHours = gmd.durationBetween.text // await gmd.durationText(9.2460524, 1.2144565, 6.1271617, 1.2345417, googleAPIKey : googleAPIKey);
```

# Firebase Data Flow - Full Result Screen

## Overview

This document explains how data flows from Firebase Firestore to the Full Result Screen.

## Data Flow Diagram

```
┌─────────────────────────────────────────────────────────────────┐
│                         User Completes Quiz                      │
│                     (Gets Character: e.g., "Ping")               │
└──────────────────────────────┬──────────────────────────────────┘
                               │
                               ▼
┌─────────────────────────────────────────────────────────────────┐
│                    Full Result Screen Loads                      │
│                         initState() called                       │
└──────────────────────────────┬──────────────────────────────────┘
                               │
                               ▼
┌─────────────────────────────────────────────────────────────────┐
│                    _fetchFirebaseData() called                   │
│                                                                   │
│  1. Map character name to subcollection name                     │
│     "Ping" → "ping"                                              │
│     "Chang-Noi" → "changnoi"                                     │
│     "Pla-Kad" → "plakad"                                         │
│                                                                   │
│  2. Fetch from Firebase Firestore (concurrent)                   │
└──────────────────────────────┬──────────────────────────────────┘
                               │
                               ▼
          ┌────────────────────┼────────────────────┐
          │                    │                    │
          ▼                    ▼                    ▼
┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐
│   LOCATIONS     │  │   FOOD MATCHES  │  │  FESTIVAL FITS  │
│                 │  │                 │  │                 │
│ Collection:     │  │ Collection:     │  │ Collection:     │
│   content       │  │   content       │  │   content       │
│                 │  │                 │  │                 │
│ Document:       │  │ Document:       │  │ Document:       │
│   locations     │  │   foodMatches   │  │   festivalFits  │
│                 │  │                 │  │                 │
│ Subcollection:  │  │ Subcollection:  │  │ Subcollection:  │
│   ping          │  │   ping          │  │   ping          │
│                 │  │                 │  │                 │
│ Limit: 5 docs   │  │ All docs        │  │ All docs        │
└────────┬────────┘  └────────┬────────┘  └────────┬────────┘
         │                    │                    │
         └────────────────────┼────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                     Data Stored in State                         │
│                                                                   │
│   _locations: List<Map<String, dynamic>>  (max 5 items)         │
│   _foods: List<Map<String, dynamic>>                            │
│   _festivals: List<Map<String, dynamic>>                        │
│   _isLoadingData: false                                          │
└──────────────────────────────┬──────────────────────────────────┘
                               │
                               ▼
┌─────────────────────────────────────────────────────────────────┐
│                      setState() triggers rebuild                 │
└──────────────────────────────┬──────────────────────────────────┘
                               │
                               ▼
┌─────────────────────────────────────────────────────────────────┐
│                         UI Renders                               │
│                                                                   │
│  For each section:                                               │
│    if (_isLoadingData)                                           │
│      → Show CircularProgressIndicator                            │
│    else if (data.isEmpty)                                        │
│      → Show "No recommendations available"                       │
│    else                                                           │
│      → Render cards with Firebase data                           │
│        - Images load from imageUrl                               │
│        - Map links use googleMapLink or fallback search          │
└─────────────────────────────────────────────────────────────────┘
```

## Key Constraints

### Locations Limit
```dart
await firestore
    .collection('content')
    .doc('locations')
    .collection(characterSubcollection)
    .limit(5)  // ← RESTRICTS TO 5 LOCATIONS MAXIMUM
    .get();
```

### No Limit on Food & Festivals
```dart
// Food - fetches all documents
await firestore
    .collection('content')
    .doc('foodMatches')
    .collection(characterSubcollection)
    .get();  // No limit

// Festivals - fetches all documents  
await firestore
    .collection('content')
    .doc('festivalFits')
    .collection(characterSubcollection)
    .get();  // No limit
```

## Character Name Mapping

| App Character Name | Firebase Subcollection |
|-------------------|------------------------|
| `Chai`            | `chai`                 |
| `Chang-Noi`       | `changnoi`             |
| `Mali`            | `mali`                 |
| `Ping`            | `ping`                 |
| `Pla-Kad`         | `plakad`               |

## Example Firebase Query

For character "Ping":

```dart
// Locations (limited to 5)
firestore
  .collection('content')
  .doc('locations')
  .collection('ping')
  .limit(5)
  .get()

// Food (all items)
firestore
  .collection('content')
  .doc('foodMatches')
  .collection('ping')
  .get()

// Festivals (all items)
firestore
  .collection('content')
  .doc('festivalFits')
  .collection('ping')
  .get()
```

## Error Handling

- If Firebase fetch fails, catches error and logs to console
- Sets `_isLoadingData = false` even on error
- Shows "No recommendations available" if data is empty
- Image errors show fallback icons
- Google Maps link errors show snackbar message

## Performance Notes

1. **Concurrent Fetching**: All three collections are fetched in parallel using `await` statements, not sequentially
2. **Limit Applied**: Only locations are limited to 5 to improve performance
3. **Image Loading**: Images use `loadingBuilder` for progressive loading
4. **State Management**: Single `setState()` call after all data is fetched

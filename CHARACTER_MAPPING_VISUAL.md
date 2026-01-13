# Character Cards Reference

Based on the images shown, here's how the app's character names map to Firebase backend IDs:

## Character Mapping

### 1. Chai the Chilled Buffalo → **Chill**
- **App Name:** `Chai`
- **Backend ID:** `Chill`
- **Title:** "The Mindful Wanderer"
- **Firebase Path Example:** `UnitedKingdom/Chill/content/...`

### 2. Chang-Noi the Jumbo Elephant → **Culture**
- **App Name:** `Chang-Noi`
- **Backend ID:** `Culture`
- **Title:** "The Culture Keeper"
- **Firebase Path Example:** `UnitedKingdom/Culture/content/...`

### 3. Mali the Chic Cat → **Chic**
- **App Name:** `Mali`
- **Backend ID:** `Chic`
- **Title:** "The Aesthetic Explorer"
- **Firebase Path Example:** `UnitedKingdom/Chic/content/...`

### 4. Ping the Playful Dugong → **Adventure**
- **App Name:** `Ping`
- **Backend ID:** `Adventure`
- **Title:** "The Adventure Seeker"
- **Firebase Path Example:** `UnitedKingdom/Adventure/content/...`

### 5. Pla-Kad the Elegant Betta Fish → **Luxury**
- **App Name:** `Pla-Kad`
- **Backend ID:** `Luxury`
- **Title:** "The Luxury Connoisseur"
- **Firebase Path Example:** `UnitedKingdom/Luxury/content/...`

## Visual Reference

```
┌─────────────┬──────────────┬─────────────┬──────────────────┐
│  Character  │   App Name   │  Backend ID │   Personality    │
├─────────────┼──────────────┼─────────────┼──────────────────┤
│   Buffalo   │    Chai      │    Chill    │   Mindful        │
│   Elephant  │  Chang-Noi   │   Culture   │   Traditional    │
│     Cat     │    Mali      │    Chic     │   Aesthetic      │
│   Dugong    │    Ping      │  Adventure  │   Thrill-seeker  │
│ Betta Fish  │   Pla-Kad    │   Luxury    │   Sophisticated  │
└─────────────┴──────────────┴─────────────┴──────────────────┘
```

## In Your Firebase Console

When you navigate to Firestore, you'll see documents named:
- `Chill` (for Chai)
- `Culture` (for Chang-Noi)
- `Chic` (for Mali)
- `Adventure` (for Ping)
- `Luxury` (for Pla-Kad)

NOT:
- ~~`Chai`~~
- ~~`Chang-Noi`~~
- ~~`Mali`~~
- ~~`Ping`~~
- ~~`Pla-Kad`~~

## Code Handles the Mapping

The app automatically converts:
```dart
User gets "Ping" → App looks for "Adventure" in Firebase
User gets "Mali" → App looks for "Chic" in Firebase
User gets "Chai" → App looks for "Chill" in Firebase
... and so on
```

You don't need to change anything in Firebase - the code handles the translation!

---

**Remember:** The character cards in the app show the Thai names (Chai, Mali, Ping, etc.), but Firebase uses the English personality types (Chill, Chic, Adventure, etc.).

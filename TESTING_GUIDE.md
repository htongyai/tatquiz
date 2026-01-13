# Testing Guide for Firebase Integration

## Prerequisites

Before testing, ensure:

1. ✅ Firebase project is set up and connected
2. ✅ Firestore database is created
3. ✅ Data is populated in the correct structure (see `FIREBASE_DATA_STRUCTURE.md`)
4. ✅ Firebase Storage has images uploaded (optional but recommended)
5. ✅ `cloud_firestore` package is installed (`flutter pub get` has been run)

## Testing Steps

### 1. Basic Compilation Test

```bash
cd /Users/htongyai/Desktop/tat_quiz
flutter analyze
```

Should show only warnings (no errors).

### 2. Run the App

```bash
flutter run
```

Or for web:
```bash
flutter run -d chrome
```

### 3. Test Flow

1. **Start the quiz** from the home screen
2. **Answer all questions** to get a character result
3. **View the result screen** 
4. **Click "EXPLORE YOUR TRAVEL GUIDE"** button to go to Full Result Screen
5. **Observe the loading indicators** while Firebase data fetches
6. **Verify the data appears** in three sections:
   - Food Match (should show all foods from Firebase)
   - Thai Events (should show all festivals from Firebase)
   - Top Spots (should show **maximum 5 locations** from Firebase)

### 4. Test Each Character

Repeat the test flow for all 5 characters:
- [ ] **Chai** (Mindful Wanderer)
- [ ] **Chang-Noi** (Culture Keeper)
- [ ] **Mali** (Aesthetic Explorer)
- [ ] **Ping** (Adventure Seeker)
- [ ] **Pla-Kad** (Luxury Connoisseur)

### 5. Test Edge Cases

#### Empty Data
1. Remove all documents from one character's subcollection
2. Complete quiz and get that character
3. Should see: "No [type] recommendations available"

#### Missing Images
1. Set `imageUrl` to an invalid URL or empty string
2. Should show fallback icons (restaurant icon for food, event icon for festivals, place icon for locations)

#### Missing Optional Fields
1. Remove `festivalPeriod` from a festival document
2. Remove `googleMapLink` from a location document
3. App should handle gracefully (skip showing these fields)

#### Network Issues
1. Turn off internet/Firebase connection
2. App should show empty state after loading stops

### 6. Test Map Links

For each location in Top Spots:
1. Click **"View Map"** button
2. Should open Google Maps in external browser/app
3. If `googleMapLink` is provided, should use direct link
4. Otherwise, should search for location name + province

### 7. Visual Verification

Check that:
- [ ] Loading indicators appear while fetching
- [ ] Images load correctly from Firebase Storage
- [ ] Text is properly formatted and readable
- [ ] Cards have proper spacing and styling
- [ ] Scroll works smoothly through all sections
- [ ] Only 5 locations show (not more)

## Debugging

### Check Firebase Console

1. Open Firebase Console: https://console.firebase.google.com/
2. Navigate to your project
3. Go to Firestore Database
4. Verify collections exist:
   - `content/locations/{character}/`
   - `content/foodMatches/{character}/`
   - `content/festivalFits/{character}/`

### Check Console Logs

Look for these log messages:

**Success:**
```
Loaded X locations, Y foods, Z festivals
```

**Error:**
```
Error fetching Firebase data: [error details]
```

### Common Issues

#### Issue: "No recommendations available" shows immediately
**Cause:** Firebase data not properly structured
**Fix:** Check collection/document/subcollection names match exactly

#### Issue: Images not loading
**Cause:** Invalid `imageUrl` or Storage permissions
**Fix:** Verify Firebase Storage rules allow read access

#### Issue: Wrong data showing for character
**Cause:** Character name mapping issue
**Fix:** Verify character name matches exactly:
- "Chai" → `chai`
- "Chang-Noi" → `changnoi`
- "Mali" → `mali`
- "Ping" → `ping`
- "Pla-Kad" → `plakad`

#### Issue: More than 5 locations showing
**Cause:** Limit not applied correctly
**Fix:** This should not happen with current code. Check if `.limit(5)` is in the query.

## Performance Testing

1. **Load Time:** From opening Full Result Screen to data appearing
   - Expected: 1-3 seconds depending on network
   
2. **Image Load Time:** From card appearing to image fully loaded
   - Expected: 1-5 seconds per image depending on size and network

3. **Scroll Performance:** Smooth scrolling through all content
   - Expected: 60 FPS, no lag

## Acceptance Criteria

✅ All tests pass
✅ No compilation errors
✅ Data loads correctly for all characters
✅ Exactly 5 (or fewer) locations show per character
✅ Images load or show fallback icons
✅ Map links work correctly
✅ Empty states handle missing data
✅ Loading indicators show appropriately

## Rollback Plan

If issues occur, the old hardcoded methods are still in the code (just unused). To revert:

1. Change the build method to use old methods:
   - `_buildFoodCard()` instead of `_buildFoodCardFromFirebase()`
   - `_buildEventCard()` instead of `_buildEventCardFromFirebase()`
   - `_buildSpotCard()` instead of `_buildSpotCardFromFirebase()`
   
2. Replace the conditional rendering with:
   ```dart
   ..._getCharacterFoods(widget.characterName).map((food) {
     // old code
   })
   ```

But with proper Firebase setup, this should not be necessary!

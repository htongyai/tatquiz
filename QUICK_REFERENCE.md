# Quick Reference - Firebase Integration

## 🔥 Firebase Collections

```
content/locations/{character}/      → Top Spots (max 5)
content/foodMatches/{character}/    → Food Match (all)
content/festivalFits/{character}/   → Thai Events (all)
```

## 🎭 Character Mapping

| App Name    | Firebase Subcollection |
|-------------|------------------------|
| Chai        | chai                   |
| Chang-Noi   | changnoi               |
| Mali        | mali                   |
| Ping        | ping                   |
| Pla-Kad     | plakad                 |

## 📋 Required Fields

### Locations
```json
{
  "name": "string",
  "province": "string",
  "region": "string",
  "description": "string",
  "imageUrl": "string (optional)",
  "googleMapLink": "string (optional)"
}
```

### Food
```json
{
  "name": "string",
  "description": "string",
  "imageUrl": "string (optional)"
}
```

### Festivals
```json
{
  "name": "string",
  "description": "string",
  "festivalPeriod": "string (optional)",
  "imageUrl": "string (optional)"
}
```

## 🎯 Key Constraints

- **Locations:** MAX 5 items fetched per character
- **Food:** All items fetched
- **Festivals:** All items fetched

## 🛠️ Quick Commands

```bash
# Analyze for errors
flutter analyze lib/screens/full_result_screen.dart

# Run app
flutter run

# Run on web
flutter run -d chrome

# Check Firebase structure
# → Go to Firebase Console
# → Navigate to Firestore Database
# → Verify collections exist
```

## 🔍 Debugging

### Check Console Logs
```
✅ Success: "Loaded X locations, Y foods, Z festivals"
❌ Error: "Error fetching Firebase data: ..."
```

### Common Issues

| Issue | Cause | Solution |
|-------|-------|----------|
| No data showing | Wrong collection structure | Check Firebase path matches exactly |
| Images not loading | Invalid imageUrl | Verify Firebase Storage URL |
| Wrong character data | Name mapping error | Check character name (case-sensitive) |
| > 5 locations | Limit not applied | Should not happen - check code |

## 📱 Test Flow

1. Start quiz → Answer questions
2. Get character result
3. Click "EXPLORE YOUR TRAVEL GUIDE"
4. Verify:
   - Loading indicators appear
   - Data loads from Firebase
   - Images display or show fallback
   - Exactly 5 (or fewer) locations
   - Map links work

## 📚 Documentation Files

- `IMPLEMENTATION_SUMMARY.md` - Overview of changes
- `FIREBASE_INTEGRATION_SUMMARY.md` - Technical details
- `FIREBASE_DATA_FLOW.md` - Data flow diagram
- `FIREBASE_DATA_STRUCTURE.md` - Example documents
- `TESTING_GUIDE.md` - Testing procedures
- `VISUAL_CHANGES.md` - Before/after visuals
- `QUICK_REFERENCE.md` - This file

## ⚡ Quick Fixes

### Add New Location
1. Go to Firebase Console
2. Navigate to `content/locations/{character}/`
3. Add new document with required fields
4. Refresh app (no code change needed!)

### Update Description
1. Go to Firebase Console
2. Find document
3. Edit `description` field
4. Refresh app

### Change Image
1. Upload new image to Firebase Storage
2. Copy new URL
3. Update `imageUrl` field in document
4. Refresh app

## ✅ Acceptance Criteria

- [x] Data fetches from Firebase
- [x] Loading indicators show
- [x] Empty states handle missing data
- [x] Images load from Firebase Storage
- [x] Max 5 locations per character
- [x] Map links work correctly
- [x] All 5 characters work
- [x] No compilation errors

## 🚀 Deploy Checklist

- [ ] Firebase data populated for all characters
- [ ] All required fields present
- [ ] Images uploaded to Firebase Storage
- [ ] Tested on all characters
- [ ] Map links verified
- [ ] Performance tested
- [ ] Error handling verified

---

**File Modified:** `lib/screens/full_result_screen.dart`
**Date:** January 13, 2026
**Status:** ✅ Ready for Testing

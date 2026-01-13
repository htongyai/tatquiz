# Challenge Flow Documentation

## Overview

The Challenge Flow is a secondary quiz feature that allows users to test their knowledge about Thailand after completing the main personality quiz. This flow consists of three screens: an intro screen, a quiz screen with True/False questions, and a score summary screen.

## Architecture

The challenge flow is completely separated from the main quiz flow and organized in its own directory structure:

```
lib/
├── models/
│   └── challenge_data.dart          # Challenge questions and data
└── screens/
    └── challenge/
        ├── challenge_intro_screen.dart    # Welcome/intro screen
        ├── challenge_quiz_screen.dart      # True/False quiz screen
        ├── challenge_score_screen.dart    # Score summary screen
        └── README.md                      # This file
```

## Data Flow

### Entry Point

The challenge flow is accessed from the **Result Screen** (`result_screen.dart`). The trophy icon in the top right corner navigates to the challenge intro screen.

```dart
// In result_screen.dart
GestureDetector(
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChallengeIntroScreen(
          characterName: characterName,  // Pass character from personality quiz
        ),
      ),
    );
  },
  child: Container(/* Trophy icon */),
)
```

### Parameter Passing

The **character name** from the personality quiz result is passed through all challenge screens:

1. **Result Screen** → **Challenge Intro Screen**: `characterName`
2. **Challenge Intro Screen** → **Challenge Quiz Screen**: `characterName`
3. **Challenge Quiz Screen** → **Challenge Score Screen**: `characterName`, `score`, `totalQuestions`

## Components

### 1. Challenge Data Model (`lib/models/challenge_data.dart`)

**Purpose**: Contains all challenge quiz questions organized by character.

**Key Functions**:
- `getChallengeQuestions(String character)`: Returns 5 True/False questions for the specified character
- `getChallengeBackgroundColor(String character)`: Returns the background color for challenge screens

**Character-Specific Questions**:
- Each character (Mali, Chang-Noi, Ping, Chai, Pla-Kad) has a unique set of 5 questions
- Currently contains mock questions - **replace with actual content when available**

**Example Usage**:
```dart
final questions = getChallengeQuestions('Mali');
final backgroundColor = getChallengeBackgroundColor('Mali');
```

### 2. Challenge Intro Screen (`challenge_intro_screen.dart`)

**Purpose**: Welcomes users and introduces the challenge quiz.

**Features**:
- Trophy icon (placeholder - replace with actual asset when provided)
- Welcome message: "How Well Do You Know Thailand?"
- Description text
- "Start Challenge" button

**Design Notes**:
- Uses character-specific background color
- Background image placeholder (TODO: replace with actual asset)
- Matches design patterns from main quiz screens (padding, constraints, button styles)

**Navigation**:
- On "Start Challenge" tap → Navigates to `ChallengeQuizScreen`

### 3. Challenge Quiz Screen (`challenge_quiz_screen.dart`)

**Purpose**: Displays True/False questions for the challenge quiz.

**Features**:
- Progress indicator (train image with dots, matching main quiz design)
- Question text (using Google Fonts Courgette, matching main quiz)
- Two answer buttons: **True** and **False**
- Auto-advance to next question after selection (500ms delay)
- Tracks correct answers
- Character-specific background color

**Design Alignment**:
- Uses same train progress indicator as main quiz
- Same text styling (GoogleFonts.courgette, fontSize: 32)
- Same max width constraint (400px)
- Same padding and spacing (horizontal: 20, vertical: 2)
- Button styling matches main quiz (rounded corners, colors, shadows)

**Answer Buttons**:
- **True button**: Blue background (`Color(0xFF00477A)`) when unselected, orange when selected
- **False button**: Light beige background with blue border when unselected, orange when selected
- Buttons are disabled after selection to prevent multiple answers

**Navigation**:
- After last question → Navigates to `ChallengeScoreScreen` with score data

### 4. Challenge Score Screen (`challenge_score_screen.dart`)

**Purpose**: Displays final score after completing the challenge quiz.

**Features**:
- White card container with rounded corners
- Character name and subtitle
- Score text: "Your Score X/5"
- Circular progress gauge showing percentage
- Score message in red box (different messages based on percentage)
- Hashtags text
- Share button (placeholder - implement functionality later)
- "Back to My Result" button

**Score Messages**:
- 80%+: "Thailand Expert! You really know your stuff!..."
- 60-79%: "Well done! You have good knowledge..."
- <60%: "Good try! There's always more to discover..."

**Design Alignment**:
- White card matches design pattern from image
- Circular progress gauge with percentage in center
- Red message box matches color scheme
- Button styling matches other screens

**Navigation**:
- "Back to My Result" → Pops back to the first route (result screen)

## Character Customization

### Background Colors

Each character has a unique background color used across all challenge screens:

- **Mali**: `#F5A623` (Orange/Yellow)
- **Chang-Noi**: `#8B0000` (Dark Red)
- **Ping**: `#00A3A3` (Turquoise/Teal)
- **Chai**: `#2E7D32` (Green)
- **Pla-Kad**: `#1E3A5F` (Blue)

### Question Sets

Each character has 5 unique True/False questions. Currently, these are mock questions and should be replaced with actual content.

## Integration Guide

### For Developers

1. **Import the challenge screens**:
```dart
import 'screens/challenge/challenge_intro_screen.dart';
```

2. **Navigate from Result Screen**:
```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => ChallengeIntroScreen(
      characterName: characterName,  // Required parameter
    ),
  ),
);
```

3. **Replace Mock Data**:
   - Edit `lib/models/challenge_data.dart`
   - Replace mock questions with actual content
   - Update background colors if needed

4. **Add Background Images** (when available):
   - Uncomment TODO sections in each screen
   - Add images to `assets/` folder
   - Update image paths:
     - Intro: `assets/challenge_intro_$characterName.jpg`
     - Quiz: `assets/challenge_Q${questionNumber}_$characterName.jpg`
     - Score: `assets/challenge_score_$characterName.jpg`

5. **Implement Share Functionality**:
   - Update `challenge_score_screen.dart`
   - Replace TODO comment in share button `onPressed` handler

## Design Specifications

### Spacing & Padding
- Max width constraint: `400px` (matches main quiz)
- Horizontal padding: `20px` (matches main quiz)
- Vertical padding: `24-40px` depending on screen
- Button height: `56px` (matches main quiz)

### Typography
- Question text: Google Fonts Courgette, `32px`, `fontWeight: 400`
- Title text: Google Fonts Courgette, `28-36px`
- Body text: System font, `14-16px`
- Button text: System font, `18px`, `fontWeight: bold`

### Colors
- Primary button: `#EB521A` (Orange)
- True button (unselected): `#00477A` (Blue)
- False button (unselected): `#FFFBF5` (Light beige) with `#1E4A7A` border
- Selected button: `#EB8C1A` (Orange)
- Score message box: `#8B1538` (Dark red)
- Progress gauge: `#EB8C1A` (Orange)

### Border Radius
- Buttons: `28-30px`
- Cards: `24px`
- Small containers: `8-12px`

## Testing Checklist

- [ ] Challenge intro screen displays correctly for all characters
- [ ] Background colors match character
- [ ] Navigation from result screen works
- [ ] Quiz screen displays 5 questions
- [ ] True/False buttons work correctly
- [ ] Progress indicator updates correctly
- [ ] Score calculation is accurate
- [ ] Score screen displays correct percentage
- [ ] Score message changes based on percentage
- [ ] "Back to My Result" navigates correctly
- [ ] All screens maintain design consistency

## Future Enhancements

1. **Replace Mock Questions**: Add actual Thailand knowledge questions
2. **Add Background Images**: Replace color backgrounds with actual images
3. **Implement Share**: Add share functionality to score screen
4. **Add Animations**: Consider adding transition animations
5. **Localization**: Add multi-language support (currently English only)
6. **Analytics**: Track challenge completion rates
7. **Rewards**: Implement reward system for high scores

## Notes

- All challenge screens are designed to be independent and reusable
- The character parameter is the only required data to start the flow
- Background images are optional (currently using solid colors)
- Mock questions should be replaced before production release
- Design patterns match the main quiz for consistency


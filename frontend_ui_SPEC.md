# Specification: Comprehensive Enterprise Flutter Production Pipeline

## 1. Architectural Core: Strict Clean Architecture & OOP
- **Layer Separation:** Every feature module must maintain strict isolated boundaries between Data, Domain, and Presentation layers. Cross-layer communication must happen via abstraction interfaces using OOP principles.
- **Simplest Code Principle:** Keep layout trees flat. Avoid complex nesting. If a sub-layout or widget takes more than 40 lines of code, it MUST be extracted into its own separate class and Dart file.

## 2. Resource Management: Zero Hardcoding Rule
- All generated layout structures, styles, widgets, and screens MUST use properties derived solely from `lib/utils/theme_constants.dart`.
- **Enforced Styling Mapping:**
  - **Colors:** Use `AppColors.colorName` (e.g., `AppColors.primary`, `AppColors.background`).
  - **Dimensions / Spacing:** Use `AppDimension.sizeName` for all structural gaps, padding, and borders (e.g., `AppDimension.paddingMedium`).
  - **Assets:** Use `AppAssets.assetPath` for all visual resource paths (e.g., `AppAssets.logo`).

## 3. Comprehensive Feature Scan & Screen Scope
- **Full Directory Scope:** The Agent must parse the entire directory structure inside `frontend_structure.md` and generate code blueprints for **ALL features and screens** listed in the file.
- **Atomic Modular Class Rule:** Every sub-component (Buttons, Lists, Profile Cards, Timer Displays) must occupy its own separate Dart file inside the feature's `widgets/` folder. Giant inline widget functions are strictly forbidden.

## 4. State Management Standard: BLoC-Only
- **No Exceptions:** Use the standard **BLoC Pattern** (`package:flutter_bloc`) for ALL feature operations, reactive streams, and state states.
- **Countdown Implementation:** Streaming actions like a countdown timer must be handled entirely within the BLoC framework (e.g., a background Timer triggering a custom event to update the countdown state). 

## 5. Automation Execution Pipeline
- UI Layering: Sequence through `enhance-prompt` and parse structural frames via `stitch::generate-design`.
- Coding Blocks: Ensure that Phase 1 (UI/Widgets) is fully implemented and mapped to `theme_constants.dart` before writing Phase 2 (BLoCs) and connecting Phase 3 (Usecases).
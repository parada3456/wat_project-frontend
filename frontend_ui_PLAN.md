# Plan: Multi-Feature Flutter UI Generation via Stitch & Agent Skills
Objective: Parse 'frontend_structure.md' to scan ALL features and implement them using a strict, un-nested OOP Clean Architecture flow. ALL of phase must be align on frontend_structure.md

## Phase 1: UI Design & Presentation Implementation
- [ ] Scan `frontend_structure.md` entirely to index ALL features, screens, and widget folders.
- [ ] For EACH discovered screen:
    - [ ] Run `enhance-prompt` to ensure a clean, simplest, and un-nested layout description.
    - [ ] Call `stitch::generate-design` to spawn the visual layout node on Stitch Cloud.
    - [ ] Translate the design layout into atomic, simple, and separate Dart widget files inside the feature's local `widgets/` directory.
    - [ ] Enforce the Zero Hardcoding Rule: Only allow properties mapped from `lib/utils/theme_constants.dart` (`AppColors`, `AppDimension`, `AppAssets`).
    - [ ] Assemble the main Screen file as a flat layout container that calls these modular widgets.

## Phase 2: State Management (BLoC Layer)
- [ ] For EACH feature module, implement the core BLoC architecture (`Bloc`, `Event`, `State`).
- [ ] **[CRITICAL] Enforce BLoC-Only Rule:** Use standard Flutter BLoC with @freezed for ALL feature states and background processes and bloc file must be split to 3 file of event, bloc, state (e.g. profile_bloc, profile_state, profile_event).
- [ ] Build pure OOP state transitions, ensuring clear data structures for every loading, success, and failure scenario.

## Phase 3: Domain Logic (Usecases Layer)
- [ ] Build the core Domain layer for each feature module following strict Clean Architecture principles.
- [ ] Write pure OOP **Usecases** encapsulating individual business logic execution rules (e.g., `FetchUserDataUseCase`, `StartCountdownUseCase`).
- [ ] Connect the BLoC layer to call these Usecases through abstraction interfaces (Polymorphism) to decouple business logic from the Presentation layer.
# J1 Hub Flutter Clean Architecture Blueprint

This document serves as the absolute specification sheet for the automated multi-agent code generator (`agent-skills`). It maps our target 8 presentation feature folders to their corresponding business domains, abstract use cases, and reactive state components.

## 🧱 Global Implementation Rules
1. **Separation of Concerns:** Use cases must only depend on abstract repository interfaces via constructor injection. They must return an `Either<Failure, T>` using the `dartz` package.
2. **BLoC Pattern Requirements:** Every feature sub-folder must contain its own BLoC trio (`_bloc.dart`, `_event.dart`, `_state.dart`). States must strictly use explicit subclasses (`Initial`, `Loading`, `Success<T>`, `Failure`).
3. **UI Binding:** All presentation screens must inject their scoped BLoC using `BlocProvider` at the root and process view updates reactively via `BlocBuilder` and `BlocListener`.

---

## 🗺️ Domain to Feature Folder Mapping Matrix

### 1. Module: auth_profile
* **Target Presentation Sub-directories:**
  * `lib/presentation/auth_profile/login/`
  * `lib/presentation/auth_profile/profile/`
* **Use Cases:**
  * `RegisterUseCase` (Params: email, password, firstName, lastName -> Return: AuthTokens)
  * `LoginUseCase` (Params: email, password -> Return: AuthTokens)
  * `RefreshTokenUseCase` (Params: refreshToken -> Return: AuthTokens)
  * `LogoutUseCase` (Params: none -> Return: bool)
  * `ForgotPasswordUseCase` (Params: email -> Return: bool)
  * `ResetPasswordUseCase` (Params: token, newPassword -> Return: bool)
  * `GetProfileUseCase` (Params: none -> Return: UserProfile)
  * `UpdateProfileUseCase` (Params: firstName, lastName, bio, avatarUrl -> Return: UserProfile)
  * `GetBadgesUseCase` (Params: none -> Return: List<Badge>)
  * `GetCreditScoreHistoryUseCase` (Params: none -> Return: List<CreditRecord>)
  * `UpdateLocationUseCase` (Params: latitude, longitude -> Return: bool)
  * `DeleteAccountUseCase` (Params: currentPassword -> Return: bool)

### 2. Module: expense_sharing
* **Target Presentation Directory:** `lib/presentation/expense_sharing/`
* **Use Cases:**
  * `ListExpensesUseCase` (Params: none -> Return: List<Expense>)
  * `CreateExpenseUseCase` (Params: title, totalAmount, currency, memo, dueDate, splits -> Return: Expense)
  * `GetExpenseDetailUseCase` (Params: expenseId -> Return: ExpenseDetail)
  * `DeleteExpenseUseCase` (Params: expenseId -> Return: bool)
  * `ListPendingSplitsUseCase` (Params: none -> Return: List<ExpenseSplit>)
  * `PayExpenseSplitUseCase` (Params: splitId, receiptFile -> Return: bool)
  * `ApproveExpenseSplitPaymentUseCase` (Params: splitId -> Return: bool)

### 3. Module: job_market
* **Target Presentation Directory:** `lib/presentation/job_market/`
* **Use Cases:**
  * `ListJobsUseCase` (Params: agencyFilter -> Return: List<Job>)
  * `GetJobDetailUseCase` (Params: jobId -> Return: JobDetail)
  * `AddJobToCartUseCase` (Params: jobId -> Return: bool)
  * `ListCartItemsUseCase` (Params: none -> Return: List<CartItem>)
  * `RemoveJobFromCartUseCase` (Params: cartItemId -> Return: bool)
  * `CreateJobReviewUseCase` (Params: jobId, ratingStars, reviewText -> Return: Review)
  * `ListApplicationsUseCase` (Params: none -> Return: List<JobApplication>)

### 4. Module: mission_task
* **Target Presentation Directory:** `lib/presentation/mission_task/`
* **Use Cases:**
  * `ListAvailableMissionsUseCase` (Params: none -> Return: List<Mission>)
  * `GetMissionDetailUseCase` (Params: missionId -> Return: MissionDetail)
  * `SubmitMissionProofUseCase` (Params: missionId, proofFile -> Return: bool)
  * `ToggleTaskUseCase` (Params: taskId, isCompleted -> Return: bool)

### 5. Module: journey_gamification
* **Target Presentation Directory:** `lib/presentation/journey_gamification/`
* **Use Cases:**
  * `ListJourneyPhasesUseCase` (Params: none -> Return: List<JourneyPhase>)
  * `AdvancePhaseUseCase` (Params: none -> Return: PhaseTransitionResult)
  * `GetJourneyHistoryUseCase` (Params: none -> Return: List<JourneyRecord>)
  * `GetLeaderboardUseCase` (Params: scope, jobId -> Return: List<LeaderboardEntry>)

### 6. Module: social_radar
* **Target Presentation Directory:** `lib/presentation/social_radar/`
* **Use Cases:**
  * `SendFriendRequestUseCase` (Params: targetUserId -> Return: bool)
  * `ListPendingRequestsUseCase` (Params: none -> Return: List<FriendRequest>)
  * `RespondToFriendRequestUseCase` (Params: friendshipId, accept -> Return: bool)
  * `ListFriendsUseCase` (Params: none -> Return: List<UserSummary>)
  * `RemoveFriendUseCase` (Params: friendId -> Return: bool)
  * `GetRadarUsersUseCase` (Params: none -> Return: List<RadarUser>)

### 7. Module: notifications
* **Target Presentation Directory:** `lib/presentation/notifications/`
* **Use Cases:**
  * `ListNotificationsUseCase` (Params: none -> Return: List<NotificationItem>)
  * `MarkNotificationReadUseCase` (Params: notificationId -> Return: bool)
  * `MarkAllNotificationsReadUseCase` (Params: none -> Return: bool)
  * `DeleteNotificationUseCase` (Params: notificationId -> Return: bool)

### 8. Module: home
* **Target Presentation Directory:** `lib/presentation/home/`
* **Use Cases:** (Aggregates state overview pipelines from core feature providers to render landing dashboards).
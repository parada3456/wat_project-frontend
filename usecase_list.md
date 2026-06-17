1. Auth Domain
- RegisterUseCase: Handles new user registration.
- LoginUseCase: Authenticates existing users and saves JWT access/refresh tokens.
- RefreshTokenUseCase: Silently requests a new access token using a refresh token when the current token expires.
- LogoutUseCase: Revokes user session and clears local credentials.
- ForgotPasswordUseCase
- ResetPasswordUseCase
2. User Profile Domain
- GetProfileUseCase: Retrieves profile data for the currently authenticated user.
- UpdateProfileUseCase: Updates user profile fields (names, bio, avatar URL).
- GetBadgesUseCase: Fetches a list of gamified badges unlocked by the user.
- GetCreditScoreHistoryUseCase: Lists history records tracking changes to the user's local app credit score.
- UpdateLocationUseCase
- DeleteAccountUseCase
3. Missions & Tasks Domain
- ListAvailableMissionsUseCase: Fetches available gamified missions for the user.
- GetMissionDetailUseCase: Gets a specific mission's detailed tracking metrics and its sub-tasks.
- SubmitMissionProofUseCase: Uploads a file (image/document) to request verification for completing a mission.
- ToggleTaskUseCase: Updates a sub-task's completion checkbox status (true/false).
4. Journey & Gamification Domain
- ListJourneyPhasesUseCase: Fetches standard milestones/phase templates for the J1 trajectory.
- AdvancePhaseUseCase: Triggers a state validation check to progress the user to the next major journey phase.
- GetJourneyHistoryUseCase: Fetches logs of user's past milestones and historic phase record switches.
- GetLeaderboardUseCase: Fetches ranking leaderboard data (global scope or specific job ID filter).
5. Friends & Radar Domain
- SendFriendRequestUseCase: Sends a friendship invitation to another user's ID.
- ListPendingRequestsUseCase: Pulls inbound, unaccepted friend requests.
- RespondToFriendRequestUseCase: Accepts or rejects an open inbound invitation record.
- ListFriendsUseCase: Retrieves the user's active, completed friend lists.
- RemoveFriendUseCase: Unfriends/deletes a connection by friendship or user ID.
- GetRadarUsersUseCase: Resolves and scans nearby users/friends sharing geolocation coordinates.
6. Expenses Domain
- ListExpensesUseCase: Fetches group expense transactions involving the current user.
- CreateExpenseUseCase: Creates a split-expense bill among roommates/friends with specific allocations.
- GetExpenseDetailUseCase: Fetches exact ledger details and split status matrices for a single expense transaction.
- DeleteExpenseUseCase: Removes an expense created by the current user.
- ListPendingSplitsUseCase: Isolates list items of exact ledger split debts the user owes money for.
- PayExpenseSplitUseCase: Submits a file attachment receipt proving a debtor split payout.
- ApproveExpenseSplitPaymentUseCase: Used by creators to confirm receipt uploads and mark a split debt as resolved.
7. Notifications Domain
- ListNotificationsUseCase: Resolves active user notification feeds.
- MarkNotificationReadUseCase: Updates a target notification item status flag to read.
- MarkAllNotificationsReadUseCase: Updates all existing incoming notifications to read status.
- DeleteNotificationUseCase: Explicitly clears out or wipes a target notification entry.
8. Jobs & Wishlist Cart Domain
- ListJobsUseCase: Fetches employer/job boards with optional filters like agency.
- GetJobDetailUseCase: Pulls detailed job cards including housing options, reviews, and aggregated metric insights.
- AddJobToCartUseCase: Adds a target job item option to the user's wishlist cart folder.
- ListCartItemsUseCase: Renders item sets saved inside the user's local saved/wishlisted job cart container.
- RemoveJobFromCartUseCase: Drops a targeted index or item record out of the cart array.
- CreateJobReviewUseCase: Publishes a structured text and numerical star rating feedback record for an assignment.
- ListApplicationsUseCase
# Over All wat_project_frontend structure
lib
├── core
├── data
├── di
├── domain
├── presentation
├── routes
└── utils
1. core layer 
    lib/core/
    ├── network/
    │   ├── dio_client.dart             # ตัวจัดการ Http Client หลักของแอป
    │   └── jwt_interceptor.dart        # ดักจับ Token ล่วงลับ เพื่อส่ง Request ไป Refresh Token อัตโนมัติ
    ├── errors/
    │   ├── exceptions.dart             # คลาสดักจับข้อยกเว้น เช่น ServerException, CacheException
    │   └── failures.dart               # แปลง Exception ออกมาเป็น Object สำหรับ UI เช่น ServerFailure, NetworkFailure
    └── theme/
        ├── app_colors.dart             # รหัสสีหลักของระบบ (เช่น สีสถานะเงินค้างจ่าย สีคะแนนเครดิต)
        └── app_theme.dart              # จัดการฟอนต์สไตล์และรูปร่างของปุ่ม/การ์ดทั้งหมด
2. domain layer
    lib/domain/
    ├── models/                       # แปลงตารางใน ER Diagram มาเป็น Pure Dart Objects
    │   ├── user_model.dart            # ข้อมูลหลัก [USER] (id, email, current_phase_id, points) 
    │   ├── profile_model.dart         # ข้อมูลเสริม [PROFILE] (bio, avatar_url, radar_visibility, coordinates) [cite: 3]
    │   ├── friendship_model.dart      # ความสัมพันธ์ [FRIENDSHIP] (user_id_1, user_id_2, status) [cite: 3, 4]
    │   ├── journey_phase_model.dart   # ด่านการเดินทาง [JOURNEY_PHASE] (phase_number, title, desc) [cite: 4, 5]
    │   ├── user_phase_history_model.dart # ประวัติการผ่านด่าน [USER_PHASE_HISTORY] (points_earned, completed_at) [cite: 5, 6]
    │   ├── mission_model.dart         # ข้อมูลภารกิจหลัก [MISSION] (base_points, is_mandatory, verification_type) [cite: 6, 7, 8]
    │   ├── user_mission_model.dart    # สถานะทำภารกิจ [USER_MISSION] (status, proof_url, bonus_points) [cite: 8, 9, 10]
    │   ├── task_model.dart            # งานย่อยภายในภารกิจ [TASK] (title, description) [cite: 11, 12]
    │   ├── user_task_model.dart       # บันทึกเช็ก Task รายบุคคล [USER_TASK] (is_completed, completed_at) [cite: 12, 13]
    │   ├── point_ledger_model.dart    # ประวัติคะแนนเข้าออก [POINT_LEDGER] (source_type, delta, balance_after) [cite: 13, 14]
    │   ├── badge_model.dart           # ตราสัญลักษณ์รางวัล [BADGE] (title, icon_url, trigger_type) [cite: 14, 15, 16]
    │   ├── user_badge_model.dart      # ประวัติการรับตราสัญลักษณ์ [USER_BADGE] (earned_at) [cite: 16]
    │   ├── credit_score_model.dart    # คะแนนความประพฤติทางการเงิน [CREDIT_SCORE] (current_score) [cite: 16, 17]
    │   ├── expense_transaction_model.dart # บิลค่าใช้จ่ายหลัก [EXPENSE_TRANSACTION] (paid_by, total_amount, due_date) [cite: 17, 18]
    │   ├── expense_split_model.dart   # รายการคนร่วมหารบิล [EXPENSE_SPLIT] (owe_amount, payment_status, payslip_url) [cite: 18, 19, 20]
    │   ├── job_posting_model.dart     # รายละเอียดงาน [JOB_POSTING] (employer_title, position, salary_range) [cite: 21, 22]
    │   ├── job_housing_model.dart     # ข้อมูลบ้านพักพนักงาน [JOB_HOUSING] (weekly_rate, deposit, transportation) [cite: 23, 24]
    │   ├── user_cart_model.dart       # รายการบันทึกงาน [USER_CART] (job_id, status) [cite: 24, 25, 26]
    │   ├── job_overall_rating_model.dart # คะแนนสรุปรีวิวรวม [JOB_OVERALL_RATING] (overall_rate, housing_rate, review_count) [cite: 26, 27]
    │   └── job_review_model.dart      # ข้อความรีวิวของผู้ใช้ [JOB_REVIEW] (rating_stars, review_text, tips) [cite: 27, 28, 29]
    │
    ├── repositories/                   # สัญญาการทำงาน (Abstract Interfaces)
    │   ├── auth_profile_repository.dart
    │   ├── missions_tasks_repository.dart
    │   ├── journey_gamification_repository.dart
    │   ├── social_radar_repository.dart
    │   ├── expense_sharing_repository.dart
    │   ├── notifications_repository.dart
    │   └── job_market_repository.dart
    │
    └── usecases/                       # คลาสคำสั่งการทำงานทางธุรกิจเดี่ยวๆ (Single Service)
        ├── auth_profile/
        │   ├── register_user.dart
        │   ├── login_user.dart
        │   ├── logout_user.dart
        │   ├── refresh_session.dart
        │   ├── get_user_profile.dart
        │   ├── update_user_profile.dart
        │   ├── update_user_settings.dart
        │   └── deactivate_account.dart
        ├── missions_tasks/
        │   ├── get_available_missions.dart
        │   ├── get_mission_with_tasks.dart
        │   ├── check_verification_status.dart
        │   ├── toggle_task_completion.dart
        │   └── submit_mission_proof.dart
        ├── journey_gamification/
        │   ├── get_journey_phases.dart
        │   ├── transition_next_phase.dart
        │   ├── get_journey_history.dart
        │   ├── get_leaderboard_rankings.dart
        │   ├── get_earned_badges.dart
        │   └── get_credit_score_logs.dart
        ├── social_radar/
        │   ├── send_friend_invitation.dart
        │   ├── get_pending_friend_requests.dart
        │   ├── respond_friend_request.dart
        │   ├── get_active_friends_list.dart
        │   ├── remove_friend_by_id.dart
        │   └── get_nearby_friends_coordinates.dart
        ├── expense_sharing/
        │   ├── get_expense_history_list.dart
        │   ├── create_expense_transaction.dart
        │   ├── get_single_expense_details.dart
        │   ├── delete_expense_by_owner.dart
        │   ├── get_pending_owed_expenses.dart
        │   ├── submit_payment_slip_image.dart
        │   └── approve_or_reject_split_payment.dart
        ├── notifications/
        │   ├── get_user_notifications_stream.dart
        │   ├── mark_notification_as_read.dart
        │   ├── mark_all_notifications_read.dart
        │   └── delete_single_notification.dart
        └── job_market/
            ├── search_and_filter_jobs.dart
            ├── get_job_profile_details.dart
            ├── save_or_update_job_in_cart.dart
            ├── get_saved_jobs_cart.dart
            ├── remove_job_from_cart.dart
            ├── get_all_job_reviews.dart
            └── submit_new_job_review.dart
3. data layer

    lib/data/
    ├── sources/
    │   ├── auth_profile_remote_data_source.dart        # ยิงเรียก Endpoint ตระกูล /api/v1/auth และ /user
    │   ├── missions_tasks_remote_data_source.dart      # ยิงเรียก Endpoint /api/v1/missions และ /tasks
    │   ├── journey_gamification_remote_data_source.dart# ยิงเรียก Endpoint /api/v1/journey และ /leaderboard
    │   ├── social_radar_remote_data_source.dart        # ยิงเรียก Endpoint /api/v1/friends และ /radar
    │   ├── expense_sharing_remote_data_source.dart     # ยิงเรียก Endpoint /api/v1/expenses
    │   ├── notifications_remote_data_source.dart       # ยิงเรียก Endpoint /api/v1/notifications
    │   ├── job_market_remote_data_source.dart          # ยิงเรียก Endpoint /api/v1/jobs, /cart และ /reviews
    │   └── local_storage_data_source.dart              # บันทึก JWT Token แฟลชพิกัดล่าสุดลงในตัวเครื่อง (Secure/Hive)
    │
    ├── entities/                         # คลาสจัดรูปข้อมูลสืบทอดจาก Entities + เมธอดจับคู่ JSON (Map)
    │   ├── user_entity.dart             
    │   ├── profile_entity.dart          
    │   ├── friendship_entity.dart       
    │   ├── journey_phase_entity.dart    
    │   ├── user_phase_history_entity.dart
    │   ├── mission_entity.dart          
    │   ├── user_mission_entity.dart     
    │   ├── task_entity.dart             
    │   ├── user_task_entity.dart        
    │   ├── point_ledger_entity.dart     
    │   ├── badge_entity.dart            
    │   ├── user_badge_entity.dart       
    │   ├── credit_score_entity.dart     
    │   ├── expense_transaction_entity.dart
    │   ├── expense_split_entity.dart    
    │   ├── job_posting_entity.dart      
    │   ├── job_housing_entity.dart      
    │   ├── user_cart_entity.dart        
    │   ├── job_overall_rating_entity.dart
    │   └── job_review_entity.dart       
    │
    └── repository_impl/                   # คลาสเชื่อมรอยต่อดักจับข้อผิดพลาดเน็ตเวิร์กก่อนส่งค่ากลับเป็น Entity สู่หน้าจอ
        ├── auth_profile_repository_impl.dart
        ├── missions_tasks_repository_impl.dart
        ├── journey_gamification_repository_impl.dart
        ├── social_radar_repository_impl.dart
        ├── expense_sharing_repository_impl.dart
        ├── notifications_repository_impl.dart
        └── job_market_repository_impl.dart
4. presentation layer
    lib/presentations/
    │
    ├── auth_profile/                   # --- Feature 1: Authentication & User Management ---
    │   ├── bloc/
    │   │   ├── auth_bloc.dart          # จัดการสถานะ Login/Logout และการคงอยู่ของ Token Session
    │   │   ├── profile_bloc.dart       # โหลด/แก้ไขข้อมูลส่วนตัวและดึงค่า Credit Score ล่าสุด [cite: 16, 17]
    │   │   └── user_settings_bloc.dart# จัดการเปิด/ปิด Privacy Toggle, การซ่อนตัวจากแผนที่เรดาร์
    │   ├── screens/
    │   │   ├── login_page.dart         # หน้าเข้าใช้งาน มีฟิลด์กรอก Email/Password และปุ่ม Sign In
    │   │   ├── register_page.dart      # หน้ากรอกข้อมูลผู้ใช้งานใหม่ สมัครบัญชีใช้งานครั้งแรก
    │   │   ├── profile_page.dart       # หน้าจอ My Profile สรุปข้อมูล รูปประจำตัว และ Widget คะแนน Credit [cite: 3, 17]
    │   │   ├── edit_profile_page.dart  # หน้าฟอร์มปรับเปลี่ยนข้อมูลชื่อ นามสกุล และคำอธิบายประวัติส่วนตัว (Bio) [cite: 3]
    │   │   └── user_settings_page.dart # หน้าจอปรับแต่ง Privacy ค่าเรดาร์ และปุ่มสีแดงลบทำลายบัญชี (Delete Account)
    │   └── widgets/
    │       ├── avatar_picker.dart      # วงกลมแสดงภาพโปรไฟล์ พร้อมปุ่มกดดึงแกลเลอรีรูปภาพมาเปลี่ยนใหม่ [cite: 3]
    │       ├── credit_score_badge.dart # ป้ายคะแนนทรงกลมสไตล์ Gauge Meter เปลี่ยนสีตามความน่าเชื่อถือของผู้ค้ำ [cite: 17]
    │       └── settings_toggle_tile.dart# แถวตั้งค่าแบบสวิตช์เปิด-ปิด เช่น สวิตช์การแสดงพิกัดบนแผนที่เรดาร์
    │
    ├── missions_tasks/             # --- Feature 2: Missions & Tasks ---
    │   ├── bloc/
    │   │   ├── missions_bloc.dart      # โหลดรายการภารกิจประจำ Phase และคำนวณจำนวนภารกิจที่ต้องทำ (Mandatory) [cite: 4, 7]
    │   │   ├── task_bloc.dart         # ดูสถานะอัปเดตและกดติ๊กเลือกเคลียร์ Task ย่อยในแบบเรียลไทม์ [cite: 12]
    │   │   └── proof_submission_bloc.dart# จัดการกระบวนการอัปโหลดไฟล์หลักฐานรูปถ่าย/กรอก URL ไปยืนยันตัวตน [cite: 8]
    │   ├── screens/
    │   │   ├── missions_dashboard_page.dart # หน้าหลักมิชชัน ประกอบด้วยแถบ Tab 2 ฝั่ง: My Mission และ Explore
    │   │   ├── mission_detail_page.dart # หน้ารวมรายละเอียดมิชชัน โครงสร้างรายการเช็กบ็อกซ์ และปุ่มกดส่ง Proof [cite: 8, 12]
    │   │   ├── mission_calendar_page.dart   # หน้าปฏิทินรวมวันสิ้นสุดกำหนดส่งของมิชชันเพื่อป้องกันไม่ให้เจอบทลงโทษ
    │   │   └── missions_search_page.dart    # หน้าสำหรับกดค้นหาและกรองแยกสถานะ เช่น ค้นหาเฉพาะข้อที่ "Overdue" [cite: 10]
    │   └── widgets/
    │       ├── missions_list.dart      # ส่วนจัดการลูป ListView ประกอบสร้างชุดกล่องข้อความภารกิจ
    │       ├── mission_card.dart       # กล่องการ์ดภารกิจเดี่ยว แสดงระดับโบนัสแต้มสะสม และวันที่สิ้นสุดกำหนดส่ง [cite: 10]
    │       ├── mission_calendar.dart   # ตัวกล่องตารางปฏิทินแสดงไอคอนมาร์กเกอร์งานที่ใกล้จะถึงวัน Deadline
    │       ├── task_checkbox_tile.dart # รายการแถวระบุ Task ย่อยพร้อมช่องสี่เหลี่ยมสามารถแตะเพื่อเปิดปิดสลับสถานะ [cite: 12]
    │       ├── proof_upload_form.dart  # บล็อกพื้นที่สำหรับกรอกลิงก์ส่งงานหรือกล่องกดเลือกไฟล์รูปหลักฐาน [cite: 8]
    │       └── verification_status_banner.dart # แถบแถบแบนเนอร์แสดงสีเตือนสถานะตรวจสอบ (เช่น รออนุมัติ/ผ่านแล้ว) [cite: 10, 20]
    │
    ├── journey_gamification/       # --- Feature 3: Journey & Gamification ---
    │   ├── bloc/
    │   │   ├── journey_bloc.dart       # เรียกหน้า Timeline ขั้นตอนปัจจุบัน ตรวจดูเงื่อนไขว่าครบเพื่อปลดล็อก Phase ไหม [cite: 4]
    │   │   ├── leaderboard_bloc.dart   # ประมวลผลอันดับ Rank รายชื่อผู้เล่นในเซิร์ฟเวอร์แบบรวมกลุ่มหรือแบ่ง Phase [cite: 4]
    │   │   ├── badges_bloc.dart       # ประมวลผลดึงกล่องไอคอนถ้วยรางวัลที่ผ่านเงื่อนไขมาแสดงใน GridView [cite: 14]
    │   │   └── credit_history_bloc.dart# ดึงข้อมูลการเคลื่อนไหวคะแนนเครดิตและการโดนลงโทษปรับจาก Point Ledger [cite: 13, 14]
    │   ├── screens/
    │   │   ├── journey_timeline_page.dart # หน้าผังแผนที่ส้นทางแสดง Phase ต่างๆ พร้อมปุ่ม Unlock ก้าวข้ามขั้นตอนถัดไป [cite: 4]
    │   │   ├── leaderboard_page.dart   # หน้าตาราง Rank ลำดับเหรียญทอง เงิน ทองแดง จัดลำดับเพื่อนๆ และคะแนนสะสม
    │   │   ├── badges_page.dart        # หน้าตู้โชว์ถ้วยเหรียญรางวัลเกียรติยศทั้งหมดที่สะสมสำเร็จ [cite: 14]
    │   │   └── credit_history_page.dart# หน้าจอรายละเอียดบันทึกความประพฤติทางการเงินและการได้รับแต้มพิเศษ [cite: 13, 14, 17]
    │   └── widgets/
    │       ├── phase_node_widget.dart  # ชุดปมแผนผังแสดงสถานะล็อก/ปลดล็อกของด่านการเดินทาง J1 [cite: 4]
    │       ├── leaderboard_row.dart    # แถวระบุลำดับภาพประจำตัว ชื่อผู้ใช้งาน และแสดงคะแนนสะสมของแต่ละคน
    │       ├── badge_grid_tile.dart    # กล่องสี่เหลี่ยมแสดงรูปภาพเหรียญรางวัล หากยังไม่ได้รับรูปจะเป็นสีเทาเงาดำ [cite: 14]
    │       └── credit_history_row.dart # รายการแถวแสดงยอดขยับของแต้ม (+ เพิ่มโบนัสเป็นสีเขียว / - หักเงินปรับเป็นสีแดง) [cite: 13, 14]
    │
    ├── social_radar/               # --- Feature 4: Social & Friends ---
    │   ├── bloc/
    │   │   ├── friends_bloc.dart       # จัดการโหลด ค้นหา และดำเนินการลบรายชื่อเพื่อนออกจากกลุ่มสัมพันธ์ [cite: 3, 4]
    │   │   ├── radar_bloc.dart         # รันตัวดึงค่าลองจิจูด ละติจูดของกลุ่มเพื่อนที่เปิดแชร์พิกัดแบบตามติด [cite: 3]
    │   │   └── friend_request_bloc.dart# ดักสถานะตรวจเช็กจำนวนและประมวลผลการกดยอมรับคำขอเพิ่มเพื่อน [cite: 3]
    │   ├── screens/
    │   │   ├── friends_list_page.dart  # หน้ารวมรายชื่อกลุ่มเพื่อนปัจจุบันทั้งหมด มีช่องค้นหารหัสผู้ใช้อื่นด้านบน [cite: 3]
    │   │   ├── friend_requests_page.dart # ศูนย์รวมรายการที่มีคนกดแอดแอปพลิเคชันเราส่งมา มีปุ่มให้เลือกจัดการ [cite: 3]
    │   │   └── radar_map_page.dart     # หน้าจอเรดาร์แสดงแผนที่ระบุพิกัดเพื่อนรอบๆ ตัวตามการตั้งค่าความปลอดภัย [cite: 3]
    │   └── widgets/
    │       ├── friend_card.dart        # กล่องแสดงข้อมูลเพื่อน ภาพอวาตาร์ และปุ่มถังขยะสำหรับลบเพื่อนออกจากรายชื่อ [cite: 3]
    │       ├── friend_request_action_tile.dart # รายการคำขอแอดเพื่อนพร้อมปุ่มจับคู่ สีเขียว (ยอมรับ) และสีเทา (ปฏิเสธ) [cite: 3]
    │       ├── radar_map_view.dart     # ตัวกรอบแผนที่หลักผสานระบบ Google Maps API แสดงพื้นที่โดยรอบ [cite: 3]
    │       └── radar_user_marker.dart  # ไอคอนมุดแสดงตำแหน่งเพื่อน โดยซ้อนทับภาพโปรไฟล์ย่อขนาดเล็กเอาไว้ด้านใน [cite: 3]
    │
    ├── expense_sharing/            # --- Feature 5: Expense Sharing ---
    │   ├── bloc/
    │   │   ├── expense_bloc.dart       # คุมหน้าประวัติบิลเงิน จัดโครงสร้างค่าใช้จ่ายรวม และคำนวณเงินค้าง [cite: 17, 18, 19]
    │   │   ├── split_payment_bloc.dart # รับส่งรูปใบเสร็จการโอน ตรวจสอบหลักฐาน และคำสั่งกดยอมรับ/ปฏิเสธสลิป [cite: 20]
    │   │   └── expense_ledger_bloc.dart# ดูแลสถานะรวมการเคลื่อนไหวของหนี้สินภายในบ้านพัก
    │   ├── screens/
    │   │   ├── expense_history_page.dart # หน้าแดชบอร์ดหลักแสดงยอดบิลส่วนกลาง และแถบกล่องสรุปหนี้ที่เราติดเพื่อนไว้ [cite: 17, 18, 19]
    │   │   ├── create_expense_page.dart # หน้าจอตั้งบิลหลัก ใส่ยอดรวม และระบุชื่อเพื่อนๆ ที่ร่วมหารค่าใช้จ่าย [cite: 17, 18, 19]
    │   │   ├── expense_details_page.dart # หน้ารายละเอียดข้อกำหนดการหารบิล รายการสลิปที่แนบ และสถานะตรวจสอบเงิน [cite: 19, 20]
    │   │   └── payment_submission_page.dart # หน้าสำหรับกดยืนยันการเคลียร์ยอดหนี้ มีช่องอัปโหลดสลิปจาก App ธนาคาร [cite: 19, 20]
    │   └── widgets/
    │       ├── expense_history_card.dart # การ์ดรายการบิล แสดงไอคอนประเภท (เช่น ค่าอาหาร) ยอดรวม และวันที่สร้างบิล [cite: 17, 18]
    │       ├── pending_owe_tile.dart     # แถบแจ้งยอดหนี้ค้างจ่ายสีส้มเตือนใจ หากใกล้หลุดวัน Deadline จะเปลี่ยนเป็นสีแดง [cite: 18, 20]
    │       ├── split_member_input_row.dart # แถวป้อนรายชื่อคนแชร์ค่าใช้จ่าย สามารถเลือกกรอกจำนวนเงินแบบระบุเจาะจงได้ [cite: 19]
    │       ├── payment_split_status_tile.dart # รายชื่อคนที่ต้องร่วมจ่ายพร้อมสัญลักษณ์สถานะ (เช่น แนบสลิปแล้ว/รออนุมัติ) [cite: 19, 20]
    │       └── payment_slip_uploader.dart # บล็อกพื้นที่สำหรับกดอัปโหลดและแสดงพรีวิวภาพหน้าสลิปก่อนส่ง [cite: 20]
    │
    ├── notifications/              # --- Feature 6: Notifications ---
    │   ├── bloc/
    │   │   └── notification_bloc.dart  # ดึงชุดสตรีมรายการแจ้งเตือนใหม่ และตรวจนับจำนวนเม็ดแจ้งเตือนที่ยังไม่ได้อ่าน
    │   ├── screens/
    │   │   └── notification_center_page.dart # หน้าหลักแจ้งเตือนรวบรวมเหตุการณ์ มีปุ่มกวาดล้างให้อ่านทั้งหมด (Read All)
    │   └── widgets/
    │       ├── notification_item_tile.dart # การ์ดกล่องข้อความแจ้งเตือนย่อย รองรับการลากสไลด์เพื่อสั่งลบการแจ้งเตือน
    │       └── empty_notifications_placeholder.dart # ภาพกราฟิกสวยงามแสดงเมื่อไม่มีกล่องข้อความแจ้งเตือนตกค้างอยู่
    │
    └── job_market/                 # --- Feature 7: Job Market & Reviews ---
        ├── bloc/
        │   ├── job_market_bloc.dart    # ดึงรายชื่องาน ฟิลเตอร์กรองประเภท ค้นหารายได้ และสถานที่ตั้งของนายจ้าง [cite: 21]
        │   ├── job_cart_bloc.dart      # ควบคุมจำนวนสถานะการเก็บงานไว้ในตะกร้าสะสม (Saved/Applied) [cite: 24, 25, 26]
        │   └── job_review_bloc.dart    # โหลดคอมเมนต์ความคิดเห็น และการเขียนส่งฟอร์มคะแนนรีวิวชุดใหม่ขึ้นระบบ [cite: 27, 28]
        ├── screens/
        │   ├── job_search_page.dart    # หน้าตลาดงาน ค้นหาตำแหน่งงาน มีระบบกรองค่าแรงขั้นต่ำและชื่อรัฐ [cite: 21, 22]
        │   ├── job_details_page.dart   # หน้ารวมข้อมูลตำแหน่งงาน สรุปบ้านพัก สิทธิพิเศษ และคะแนนดาวเฉลี่ยจากรุ่นพี่ [cite: 22, 23, 26]
        │   ├── job_cart_page.dart      # หน้าคลังเก็บรวบรวมงานที่เรากดเซฟเก็บไว้ดู หรือบันทึกสถานะยื่นใบสมัคร [cite: 24, 25, 26]
        │   └── write_review_page.dart  # หน้าฟอร์มให้คะแนนงานเป็นดาว (1-5) และกล่องพิมพ์ข้อความแนะนำสิทธิให้รุ่นน้อง [cite: 28, 29]
        └── widgets/
            ├── job_card.dart           # กล่องสรุปย่องาน แสดงโลโก้นายจ้าง เรทค่าจ้างต่อชั่วโมง และสัญลักษณ์โควตาว่าง [cite: 21, 22]
            ├── job_cart_item_tile.dart # รายการงานที่ถูกเซฟเก็บไว้ในตะกร้า พร้อมปุ่มไอคอนรูปถังขยะสำหรับลบออก [cite: 25, 26]
            ├── review_stars_row.dart   # ชุดไอคอนรูปดาวสำหรับการให้คะแนนสัมผัสลื่นไหล (เช่น ปรับแต่งสไลด์เพื่อเลือกดาว) [cite: 28]
            ├── job_review_comment_card.dart # กล่องแผงความเห็น แสดงข้อความรีวิว ทิปส์แนะนำ และคะแนนย่อยแต่ละด้าน [cite: 28, 29]
            └── review_input_field.dart # ฟิลด์พิมพ์ข้อความกรอกข้อมูลรีวิวขนาดใหญ่ รองรับข้อความยาวหลายบรรทัด [cite: 28]
---

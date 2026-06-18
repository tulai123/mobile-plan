# Bảng tổng tiến độ — Lại Minh Tú

- Bắt đầu: 2026-06-04 | Deadline: 2026-07-30
- Nền tảng: Android (ROG Phone 5s). iOS lý thuyết.

## Tiến độ 8 tuần

| Tuần | Deadline tuần | Chủ đề | Trạng thái | Kết quả bài KT |
|---|---|---|---|---|
| 1 | 2026-06-10 | Setup + Dart cơ bản | HOÀN THÀNH (xong sớm 1 ngày) | ĐẠT |
| 2 | 2026-06-17 | Flutter fundamentals + layout | HOÀN THÀNH (xong sớm 1 ngày) | ĐẠT |
| 3 | 2026-06-24 | Navigation + ListView | Đang làm (từ 2026-06-16) | — |
| 4 | 2026-07-01 | Gọi REST API + FutureBuilder | Chưa bắt đầu | — |
| 5 | 2026-07-08 | State management (Provider) | Chưa bắt đầu | — |
| 6 | 2026-07-15 | Form + login/logout + storage | Chưa bắt đầu | — |
| 7 | 2026-07-22 | API auth + CRUD đầy đủ | Chưa bắt đầu | — |
| 8 | 2026-07-30 | Capstone trên Android thật | Chưa bắt đầu | — |

## Mốc kiểm soát cứng
- [ ] Tuần 4: gọi được API thật, hiển thị dữ liệu
- [ ] Tuần 6: màn hình login hoạt động
- [ ] Tuần 8: capstone chạy trên ROG Phone 5s

## Ghi chú giáo sư
- 2026-06-04: Onboarding xong. Học viên nền Java tốt, mobile mới hoàn toàn. Máy Windows → chỉ Android.
- 2026-06-07: Tuần 1 — setup môi trường ĐẠT (flutter doctor sạch, chỉ cảnh báo VS Windows SDK vô hại). App counter chạy trên ROG Phone 5s thật, hot reload OK, học viên tự sửa text sang tiếng Việt (đọc hiểu code). Chi tiết: progress/week-01.md.
- 2026-06-08: Giao bài KT Tuần 1 (Dart CLI tính lương sau thuế, dùng Future.delayed + async/await → nộp artifacts/week-01/salary.dart). Học viên đang học Dart cơ bản (6 mục: biến/kiểu, hàm, OOP, collections, null safety, async/await). Đã hướng dẫn nguồn học (dart.dev coming-from + language tour + async-await, DartPad). CHỜ nộp bài, deadline tuần 2026-06-10.
- 2026-06-09: Bài KT Tuần 1 ĐẠT (nộp sớm 1 ngày). 3 bậc thuế đúng, async/await + Future.delayed đúng, class + List đúng. Chi tiết chấm: progress/week-01.md. Tuần 1 HOÀN THÀNH 100%. Sẵn sàng vào Tuần 2 (Flutter fundamentals + layout) — vùng khó vì nền UI/frontend của học viên yếu.
- 2026-06-10: KHỞI ĐỘNG Tuần 2. Giảng nền Widget tree + Stateless vs Stateful (lý thuyết), liên hệ Java. Giao bài warm-up đầu tiên (Container + Text căn giữa) để học viên tự build màn hình đầu tiên. Nhấn mạnh đây là vùng khó (layout/UI). Chi tiết: progress/week-02.md. CHỜ nộp bài warm-up.
- 2026-06-10: Bài warm-up Tuần 2 ĐẠT (verify trên ROG Phone 5s thật). Padding + màu nền + bo góc (phần nâng) đều đúng. Đã giảng color vs decoration. TREO: câu lý thuyết StatelessWidget học viên chưa trả lời. Tiếp theo: Column/Row + alignment. Bài KT tuần (profile tĩnh) chưa làm — đây mới quyết Đạt/Chưa đạt Tuần 2.
- 2026-06-16: Bài KT Tuần 2 (màn hình profile tĩnh) ĐẠT — nộp sớm 1 ngày. Verify artifacts/week-02/profile.dart + profile-on-device.png trên ROG Phone 5s thật, render sạch không overflow. VƯỢT yêu cầu: tách 4 widget con có param, Expanded dùng đúng 3 chỗ, BoxDecoration đúng cách. Tuần 2 (vùng khó UI/layout) HOÀN THÀNH 100% — học viên qua điểm vấp lo ngại nhất (alignment/overflow) gọn gàng. Chi tiết chấm: progress/week-02.md. Sẵn sàng vào Tuần 3 (Navigation + ListView).
- 2026-06-16: KHỞI ĐỘNG Tuần 3 (Navigation + ListView). Em chủ động mở sớm ngay sau KT Tuần 2 (nhịp nộp sớm 2 tuần liền). Giảng mở màn: Navigator = stack màn hình, push/pop, MaterialPageRoute (liên hệ call stack Java + startActivity/finish). Sắp lộ trình 7 buổi. Giao bài warm-up (2 màn hình + push/pop → artifacts/week-03/). Định nghĩa trước bài KT cuối tuần (mini-app danh bạ list→detail) + tiêu chí. Nhấn mạnh: list+navigation tuần 3 là khung cho MỐC CỨNG Tuần 4 (đổ data API vào). Chi tiết: progress/week-03.md. CHỜ nộp warm-up.

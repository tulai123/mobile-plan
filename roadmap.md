# Lộ trình học Flutter — Lại Minh Tú

- Bắt đầu: 2026-06-04 | Kết thúc dự kiến: 2026-07-30
- 8 tuần, 4 giờ/ngày
- Nền tảng thực hành: Android (ROG Phone 5s). iOS học lý thuyết, không build.
- Mỗi tuần build trên nền tuần trước. Cuối tuần nộp 1 mini-app.

| Tuần | Ngày | Chủ đề | Mini-app cuối tuần | Trạng thái |
|---|---|---|---|---|
| 1 | 2026-06-04 → 06-10 | Setup môi trường + Dart cơ bản: biến, kiểu, hàm, OOP, null safety, async/await | Dart CLI app tính toán có xử lý async + app Flutter mặc định chạy trên ROG Phone 5s | Đang làm |
| 2 | 2026-06-11 → 06-17 | Flutter fundamentals: Widget tree, Stateless/StatefulWidget, layout (Column, Row, Stack, Container) | Màn hình profile tĩnh hoàn chỉnh từ mockup | Chưa bắt đầu |
| 3 | 2026-06-18 → 06-24 | Navigation (GoRouter), truyền data giữa màn hình, ListView, asset/hình ảnh | Mini-app danh bạ tĩnh: list → detail | Chưa bắt đầu |
| 4 | 2026-06-25 → 07-01 | Gọi REST API (http/dio), JSON parsing, FutureBuilder, loading/error state | App hiển thị danh sách bài viết từ API thật, có loading + error handling | Chưa bắt đầu |
| 5 | 2026-07-02 → 07-08 | State management với Provider, tách logic khỏi UI, ChangeNotifier | App giỏ hàng đơn giản dùng Provider | Chưa bắt đầu |
| 6 | 2026-07-09 → 07-15 | Form + validation, TextFormField, SharedPreferences (local storage) | Màn hình login/logout: validate input, lưu session, redirect | Chưa bắt đầu |
| 7 | 2026-07-16 → 07-22 | API auth (Bearer token), CRUD đầy đủ (POST/PUT/DELETE), xử lý lỗi HTTP | Mini-app CRUD: login → list → thêm/sửa/xóa item qua API | Chưa bắt đầu |
| 8 | 2026-07-23 → 07-30 | Chạy/đánh bóng app trên Android thật, debug, hoàn thiện capstone. iOS: lý thuyết build + chuẩn bị | App capstone tự thiết kế chạy trên ROG Phone 5s | Chưa bắt đầu |

## Mốc kiểm soát cứng
- Tuần 4: phải gọi được API thật và hiển thị dữ liệu. Chưa đạt → review lại Dart/Flutter cơ bản tuần 3-4.
- Tuần 6: phải có màn hình login hoạt động. Chưa đạt → cân nhắc cắt tính năng tuần 7-8.
- Tuần 8: capstone phải chạy được trên ROG Phone 5s. Chưa đạt → đánh giá thẳng thắn mức hoàn thành.

## Phương án cắt giảm nếu tiến độ chậm
1. Rút tuần 7 còn chỉ làm POST (bỏ PUT/DELETE)
2. Rút tuần 5 còn setState thuần (bỏ Provider)
3. Hạ capstone xuống app 3 màn hình không có auth

## Ghi chú iOS
- Toàn khóa thực hành trên Android. Windows + không có Mac → không build/chạy iOS thật được.
- Tuần 8 dành thời gian học lý thuyết: khác biệt build iOS, cần Mac + Xcode + Apple Developer ($99/năm), cách deploy sau này.
- Khi nào công ty cấp máy Mac thì áp dụng kiến thức đã chuẩn bị.

## Đánh giá mỗi tuần
3 tiêu chí: (1) chạy không crash, (2) đúng yêu cầu chức năng, (3) code có cấu trúc rõ ràng.
Kết quả: Đạt / Cần cải thiện / Chưa đạt. Chưa đạt → 1-2 ngày sửa trước khi sang tuần mới.

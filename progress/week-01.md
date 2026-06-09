# Tuần 1 — Setup môi trường + Dart cơ bản

- Ngày: 2026-06-04 → 2026-06-10
- Trạng thái: HOÀN THÀNH — bài KT ĐẠT (chốt 2026-06-09)

## Mục tiêu tuần
1. Cài đặt và sẵn sàng môi trường Flutter trên Windows (smoke test `flutter doctor`).
2. Chạy được app Flutter mặc định trên ROG Phone 5s thật (cắm dây).
3. Nắm cú pháp Dart cơ bản: biến, kiểu dữ liệu, hàm, class/OOP, null safety, async/await — liên hệ với Java.

## Nội dung học
- Cài Flutter SDK, Android Studio, Android SDK, cấu hình PATH.
- Bật USB debugging trên ROG Phone 5s, kết nối máy thật.
- Dart syntax so với Java:
  - Biến: `var`, `final`, `const`, kiểu `int/double/String/bool/List/Map`
  - Hàm: cú pháp, named/optional parameters (khác Java)
  - OOP: class, constructor, named constructor, inheritance
  - Null safety: `?`, `!`, `late` (so với việc Java hay NPE)
  - async/await: `Future` ≈ `CompletableFuture` trong Java

## Bài thực hành (máy lab)
1. `flutter doctor` chạy không lỗi đỏ.
2. `flutter create` + `flutter run` app mặc định lên ROG Phone 5s thật.
3. Viết Dart CLI app tính toán có xử lý async (ví dụ: máy tính đơn giản hoặc fetch giả lập có Future + await).

## Artifact phải nộp (vào artifacts/week-01/)
- `flutter-doctor.txt` — output đầy đủ của `flutter doctor -v`
- `app-on-device.png` — screenshot app mặc định chạy trên ROG Phone 5s
- `*.dart` — file Dart CLI app tính toán async

## Tiêu chí chấm
- [x] Môi trường sẵn sàng (flutter doctor không lỗi đỏ chặn) — verified qua app chạy được trên máy thật
- [x] App mặc định chạy được trên máy thật — ROG Phone 5s, 2026-06-07
- [x] Hot reload hoạt động — sửa text sang tiếng Việt hiện lên đúng
- [x] Dart CLI app chạy đúng, có dùng async/await đúng cách — ĐẠT (Future.delayed + await trong loop, output khớp)
- [x] Code có cấu trúc, đặt tên biến/hàm rõ ràng — ĐẠT (class NhanVien, named params + required, tên biến rõ)

## Trạng thái các phần
- Setup môi trường: ĐÃ HOÀN THÀNH (2026-06-07)
- Chạy app trên máy thật (ROG Phone 5s): ĐÃ HOÀN THÀNH (2026-06-07)
- Hot reload: ĐÃ HOÀN THÀNH (2026-06-07, verified)
- Học Dart + bài CLI async: ĐÃ HOÀN THÀNH (nộp 2026-06-09, ĐẠT)

## Ghi chú giáo sư
- 2026-06-07: PASS phần "Môi trường + chạy máy thật + hot reload".
  - Bằng chứng: học viên nộp screenshot app-on-device trực tiếp qua chat (KHÔNG có file trong repo artifacts/week-01/; ghi nhận ảnh dán trong chat).
  - Trong ảnh: AppBar "Flutter Demo Home Page", DEBUG banner góc phải trên (đúng app debug build), status bar máy thật (8:03, pin 59%, 2 sóng SIM, wifi → đúng máy thật chứ không phải emulator), counter đếm tới 3 (tương tác OK).
  - Hot reload verified: dòng chữ đã được sửa sang tiếng Việt "Bạn đã bấm được bao nhiêu lần:" hiển thị đầy đủ dấu → hot reload đẩy code thay đổi lên máy thật thành công.
  - Học viên đã TỰ FIX được lỗi "Lost connection" trước đó rồi build lại thành công.
- Còn lại tuần 1: học Dart + làm bài Dart CLI app async.
- 2026-06-08: Phiên học Dart cơ bản.
  - Đã giao checklist 6 mục Dart (biến/kiểu, hàm + named params, OOP class/constructor, List/Map, null safety, async/await + Future), có đối chiếu Java, đánh dấu mục BẮT BUỘC cho bài CLI.
  - Đã hướng dẫn nguồn học: dart.dev/guides/language/coming-from (đọc trước), dart.dev/language, dart.dev/libraries/async/async-await (async — chỗ vấp nhất), dartpad.dev để gõ thử.
  - Đã GIAO ĐỀ bài KT Tuần 1: Dart CLI tính lương sau thuế, 3 bậc thuế (≤10tr: 0%; 10-20tr: 10%; >20tr: 20%), hàm `Future<double> tinhLuongSauThue()` có `Future.delayed(2s)` + `async/await`, dùng class `NhanVien`, ≥3 nhân viên. Nộp `artifacts/week-01/salary.dart` + output terminal.
  - Plan: 08/06 học mục 1-4, 09/06 dồn async (mục 5-6) + viết bài, tối 09/06 nộp review. CHỜ học viên nộp bài.
  - 2026-06-08 (sau khi học viên báo đọc xong 6 mục): làm QUIZ 6 câu kiểm tra Dart trước khi viết bài. Kết quả KHÁ-TỐT: đúng trọn C1 (final/const), C2 (named params + required), C4 (thứ tự async output), C6 (vì sao cần async + liên hệ CompletableFuture). Thiếu sắc ở C3 (giải thích `!` nhưng chưa nêu nguy hiểm: null → crash runtime) và C5 (đúng chẩn đoán thiếu await, nhưng chưa nêu hậu quả in "Instance of Future"). Đã giảng bù 2 điểm này. KẾT LUẬN: đủ kiến thức → CHO PHÉP viết salary.dart. Đang chờ nộp bài.
- 2026-06-09: CHẤM BÀI KT Tuần 1 → ĐẠT. Học viên nộp artifacts/week-01/salary.dart + salary-output.txt.
  - Tiêu chí 1 (chạy không crash): ĐẠT — output 3 dòng đúng định dạng.
  - Tiêu chí 2 (đúng chức năng): ĐẠT — 3 bậc thuế đúng. An 8tr→giữ nguyên (≤10tr, 0%), Bình 15tr→13.5tr (-10%), Cường 25tr→20tr (-20%). Output khớp logic.
  - Tiêu chí 3 (cấu trúc code): ĐẠT — class NhanVien với final fields + named constructor + required, Future<double> async đúng, await Future.delayed(2s), List<NhanVien> + for-in loop, await trong loop đúng cách.
  - Góp ý nhỏ (không trừ điểm): method tinhLuongSauThue(double gross) nhận gross qua tham số trong khi class đã có field this.luongGross → ở main phải gọi nv.tinhLuongSauThue(nv.luongGross) hơi thừa. Thiết kế OOP gọn hơn: method không cần tham số, dùng thẳng this.luongGross → gọi chỉ còn nv.tinhLuongSauThue(). Đã note để nhắc khi sang Flutter (tư duy đóng gói state trong object — liên quan StatefulWidget/Provider sau này).
  - KẾT LUẬN: Tuần 1 HOÀN THÀNH 100%. Học viên nền Java giúp tiếp thu Dart nhanh, async không vấp. Sẵn sàng vào Tuần 2 (Flutter fundamentals + layout) — đây mới là vùng khó với học viên vì nền frontend/UI yếu.

# Tuần 4 — Gọi REST API + JSON parsing + FutureBuilder (MỐC CỨNG)

- Ngày: 2026-06-22 (khởi động sớm) → 2026-07-01 (deadline tuần)
- Trạng thái: ĐANG LÀM — vừa khởi động.
- Bối cảnh: Tuần 1-3 ĐẠT hết, nộp sớm 3 tuần liên tiếp. Em đã vững Dart async/await (Tuần 1), Widget/layout (Tuần 2), Navigation + ListView.builder + truyền data qua constructor (Tuần 3). Tuần 4 chỉ THAY NGUỒN DỮ LIỆU: bỏ List tĩnh, lấy data thật từ API.
- ĐÂY LÀ MỐC KIỂM SOÁT CỨNG: cuối tuần phải gọi được API thật và hiển thị dữ liệu. Chưa đạt → review lại Dart/Flutter cơ bản tuần 3-4.

## Vì sao Tuần 4 nhẹ hơn vẻ ngoài (nối với nền đã có)
- async/await em đã làm ĐÚNG ở bài KT Tuần 1 (Future.delayed). Gọi API cũng chỉ là `await http.get(...)` trả về Future → giống hệt cơ chế đã quen. Future ≈ CompletableFuture trong Java.
- ListView.builder + ListTile em đã thạo Tuần 3. Tuần 4 đổ data động vào đúng khung đó.
- Câu lý thuyết Tuần 3 (khi nào BẮT BUỘC Stateful: trạng thái loading/loaded/error) chính là vấn đề trung tâm tuần này → FutureBuilder sinh ra để lo giúp 3 trạng thái đó.

## Mục tiêu tuần
1. Hiểu vòng đời 1 request HTTP: gửi GET → chờ → nhận response (status code + body JSON).
2. Dùng package `http` (gói cơ bản, không nhảy sang dio vội) — thêm vào pubspec.yaml, import, gọi `http.get`.
3. Parse JSON: từ String JSON → Map/List<Map> → list object Dart (factory `fromJson`). Liên hệ Java: giống map JSON sang POJO.
4. Hiển thị 3 TRẠNG THÁI bằng FutureBuilder: loading (CircularProgressIndicator), có data (ListView), lỗi (thông báo lỗi). Đây là điểm cốt lõi của tuần.
5. Output cuối tuần: app hiển thị danh sách bài viết (posts) từ API thật JSONPlaceholder, có loading state + error handling.

## API dùng cho cả tuần
- JSONPlaceholder: https://jsonplaceholder.typicode.com/posts (GET, trả List 100 post; mỗi post có userId, id, title, body). Không cần key, không cần auth — đúng để học GET + parse + hiển thị. Auth/token để dành Tuần 7.

## Khái niệm cốt lõi (giảng theo thứ tự, KHÔNG nhồi 1 lúc)
- Buổi 1: package http + pubspec.yaml (liên hệ pom.xml/build.gradle). GET 1 endpoint, in raw body + statusCode ra console. CHƯA parse, CHƯA UI.
- Buổi 2: JSON parsing. jsonDecode → List<dynamic> → map sang List<Post> qua factory Post.fromJson. Class Post (giống class Contact Tuần 3 nhưng đẻ ra từ JSON).
- Buổi 3: hàm `Future<List<Post>> fetchPosts()` — gói GET + parse + ném lỗi nếu statusCode != 200.
- Buổi 4: FutureBuilder — 3 nhánh connectionState/hasError/hasData. Đây là tuần hiểu Stateful/loading thật sự.
- Buổi 5: ráp vào khung danh bạ Tuần 3 (ListView.builder hiển thị List<Post>). Bấm item → Detail post (tái dùng truyền-data-qua-constructor Tuần 3).
- Buổi 6: xử lý lỗi tử tế (tắt mạng → hiện thông báo, không crash) + nút thử lại.
- Buổi 7: nộp bài KT.

## Liên hệ Java/nền cũ
- pubspec.yaml thêm dependency `http` ≈ thêm dependency vào pom.xml/build.gradle.
- `http.get(Uri.parse(url))` trả Future<Response> → `await` lấy kết quả. Giống gọi 1 hàm trả CompletableFuture rồi `.get()`.
- jsonDecode(response.body) → Map/List → map sang object qua factory fromJson ≈ Jackson/Gson map JSON sang POJO. Khác: làm tay, không annotation.
- FutureBuilder = widget tự lắng nghe 1 Future và rebuild UI theo trạng thái (waiting / done-có-data / done-có-lỗi). Không cần tự gọi setState cho 3 trạng thái này.

## Bài thực hành (máy lab) — giao dần

### Bài warm-up 1 (ĐÃ GIAO 2026-06-22): GET + in raw JSON
- Mục tiêu: kết nối được tới API thật, thấy response bằng mắt TRƯỚC khi parse.
- Yêu cầu:
  - Thêm `http` vào pubspec.yaml (chạy `flutter pub get` ở máy lab).
  - 1 màn hình có 1 nút "Tải dữ liệu". Bấm → gọi `http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'))`.
  - In ra console (`print`): `response.statusCode` và `response.body` (in tạm `response.body.substring(0, 300)` cho gọn).
  - CHƯA parse JSON, CHƯA hiển thị lên UI. Chỉ cần thấy status 200 + chuỗi JSON trong console.
- LƯU Ý KỸ THUẬT (sẽ hỏi/nhắc): app Android cần quyền Internet. Trên emulator/máy thật debug thường có sẵn, nhưng nếu gọi không được, kiểm tra AndroidManifest.xml có `<uses-permission android:name="android.permission.INTERNET"/>`.
- Artifact phải nộp (artifacts/week-04/):
  - `warmup-http.dart` — code màn hình + hàm gọi GET + print.
  - `warmup-console.png` (hoặc paste text console vào chat) — chụp/dán log console thấy statusCode 200 + đoạn đầu JSON.
- Câu lý thuyết kèm theo (TRẢ LỜI TÁCH 2 Ý RÕ RÀNG — em hay trả thiếu vế):
  - (a) Vì sao `http.get` phải `await`? Nếu KHÔNG await thì biến nhận được là gì?
  - (b) statusCode 200 nghĩa là gì? Kể thêm 2 status code khác và ý nghĩa (gợi ý: 404, 500).

## Bài KT cuối Tuần 4 — APP DANH SÁCH BÀI VIẾT TỪ API (định nghĩa trước để em biết đích)
Yêu cầu:
- class `Post` (ít nhất id, title, body) + factory `Post.fromJson(Map<String, dynamic> json)`.
- Hàm `Future<List<Post>> fetchPosts()`: gọi GET JSONPlaceholder /posts, parse sang List<Post>, ném Exception nếu statusCode != 200.
- Màn List dùng `FutureBuilder<List<Post>>`:
  - Đang tải → `CircularProgressIndicator` (loading state).
  - Có data → `ListView.builder` + `ListTile` hiển thị title (subtitle có thể là đoạn đầu body).
  - Lỗi → hiển thị thông báo lỗi rõ ràng (không crash, không màn trắng).
- Bấm 1 item → Detail hiển thị full title + body của post đó (tái dùng truyền-data-qua-constructor Tuần 3).
- Xử lý lỗi thật: tắt wifi/data rồi mở app → phải hiện thông báo lỗi, KHÔNG crash.

## Artifact phải nộp — BÀI KT (vào artifacts/week-04/)
- `posts_app.dart` (hoặc nhiều file .dart) — code app.
- `posts-loading.png` — chụp lúc đang loading (nếu kịp; nếu mạng nhanh quá có thể giả lập bằng delay).
- `posts-list.png` — màn list có data thật từ API, trên ROG Phone 5s.
- `posts-detail.png` — màn Detail 1 post bất kỳ (title + body khớp item bấm).
- `posts-error.png` — màn lỗi khi tắt mạng (bằng chứng error handling hoạt động).

## Tiêu chí chấm (cuối tuần)
- [ ] Gọi được API THẬT, hiển thị data thật (KHÔNG hardcode list giả) — đây là điều kiện MỐC CỨNG
- [ ] class Post + factory fromJson đúng, parse JSON không lỗi
- [ ] FutureBuilder xử lý đủ 3 trạng thái: loading / có data / lỗi
- [ ] Tắt mạng → hiện thông báo lỗi, không crash, không màn trắng
- [ ] Bấm item → Detail đúng post được chọn (truyền qua constructor)
- [ ] Code tách hàm fetch khỏi UI, đặt tên rõ (giữ chuẩn Tuần 2-3)

## Ghi chú giáo sư
- 2026-06-22: KHỞI ĐỘNG Tuần 4 ngay sau khi chốt ĐẠT Tuần 3 (em giữ nhịp nộp sớm, mở tuần sớm).
  - Nhấn mạnh đây là MỐC CỨNG đầu tiên của khóa: cuối tuần phải gọi được API thật + hiển thị data.
  - Trấn an đúng mức: tuần này nhẹ hơn vẻ ngoài vì 3 mảnh nền đã có (async/await T1, ListView.builder T3, FutureBuilder chỉ là widget bọc 3 trạng thái). Không phải học lại từ đầu.
  - Giảng mở màn: vòng đời request HTTP (GET → await → response statusCode + body), package http, pubspec.yaml (liên hệ pom.xml/build.gradle).
  - Chọn JSONPlaceholder /posts làm API học cả tuần (free, no-auth). Auth/token để Tuần 7.
  - Sắp lộ trình 7 buổi (GET raw → parse JSON → hàm fetch → FutureBuilder → ráp list/detail → error handling → KT).
  - Giao BÀI WARM-UP 1: GET 1 endpoint, in raw statusCode + body ra console (CHƯA parse, CHƯA UID). Mục tiêu: kết nối được API trước, thấy JSON bằng mắt.
  - Định nghĩa trước bài KT cuối tuần + tiêu chí để em biết đích.
  - Câu lý thuyết warm-up CỐ TÌNH tách 2 ý (a/b) rõ ràng — vì Tuần 3 em hay trả lời thiếu vế thứ hai của câu hỏi. Ép trả đủ cả 2 ý.
  - CHỜ em nộp warm-up (artifacts/week-04/).

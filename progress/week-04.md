# Tuần 4 — Gọi REST API + JSON parsing + FutureBuilder (MỐC CỨNG)

- Ngày: 2026-06-22 (khởi động sớm) → 2026-07-01 (deadline tuần)
- Trạng thái: ĐANG LÀM — Buổi 2 ĐẠT (2026-06-22), đang vào Buổi 3 (hàm fetchPosts).
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
- 2026-06-22 (review warm-up 1): Tú nộp `warmup-http.dart` + `warmup-console.png`.
  - CODE: ĐẠT. Tách hàm `_taiDuLieu()` async khỏi build, `await http.get(Uri.parse(...))`, in statusCode + preview body (cắt 300 ký tự an toàn bằng kiểm tra length). Import `as http` đúng. Giữ chuẩn tách hàm của Tuần 2-3.
  - BẰNG CHỨNG CONSOLE: ĐẠT. Ảnh log thấy rõ `statusCode: 200` (3 lần do bấm nút nhiều lần) + chuỗi JSON đầu (userId/id/title/body). Kết nối API thật thành công. App id com.example.testapi chạy trên thiết bị.
  - => WARM-UP 1 ĐẠT. Kết nối được API thật, thấy JSON bằng mắt. Mục tiêu warm-up hoàn thành.
  - CÒN NỢ: 2 câu lý thuyết (a) vì sao await + không await thì biến là gì; (b) statusCode 200 + 2 status khác. Em CHƯA trả lời — đã nhắc lại, chờ em trả đủ 2 ý trước khi tính trọn vẹn warm-up.
  - BƯỚC TIẾP: mở Buổi 2 — parse JSON sang class Post (factory fromJson). Chờ em trả 2 câu lý thuyết rồi đẩy Buổi 2.
- 2026-06-22 (chấm lý thuyết warm-up, đợt 1): Tú trả (b), CHƯA trả (a).
  - (b) phần "kể 2 status khác": ĐẠT — 404 Not Found (lỗi client, nhóm 4xx) + 502 Bad Gateway (lỗi server, nhóm 5xx). Chọn được 1 mã 4xx + 1 mã 5xx, đa dạng nhóm, tốt.
  - (b) phần "200 nghĩa là gì": SAI — em ghi "202 nghĩa là chạy thành công". Mã thành công trong console warm-up là 200 (OK), không phải 202. 202 (Accepted) = server đã NHẬN nhưng XỬ LÝ CHƯA XONG. Yêu cầu em xác nhận lại đúng là 200. Nghi gõ nhầm nhưng vẫn ép sửa rõ để không hiểu sai nhóm 2xx.
  - (a) CHƯA trả lời — đã nhắc lại nguyên văn. Chưa mở Buổi 2 cho tới khi em sửa 200 + trả xong (a).
- 2026-06-22 (chấm lý thuyết warm-up, đợt 2 + MỞ Buổi 2): Tú trả (a) — nguyên văn "http.get() bắt buộc phải await vì nó là hàm bất đồng bộ".
  - (a) vế đầu: ĐÚNG nhưng SƠ SÀI (chỉ nói "bất đồng bộ", chưa nói rõ trả về Future<Response>).
  - (a) vế hai (nếu bỏ await thì biến kiểu gì + dùng statusCode ngay được không): EM LẠI BỎ TRỐNG. Đây là lần thứ 4-5 trả thiếu vế thứ hai (Tuần 3 đã ghi nhận: back-vs-pop, Stateless-vs-Stateful). Tuần 4 đã CỐ TÌNH tách (a)/(b) để ép trả đủ, vậy mà trong (a) còn 2 ý nhỏ vẫn rơi 1. NHẮC THẲNG một lần nữa + cảnh báo hậu quả: vào KT chính (MỐC CỨNG) bỏ sót yêu cầu sẽ rớt tiêu chí oan. Yêu cầu kỹ năng: đọc xong 1 câu/yêu cầu thì ĐẾM số ý rồi trả đủ.
  - Thầy GIẢNG NỐT vế hai: bỏ await → response có kiểu Future<Response> (lời hứa chưa hoàn thành, chưa phải Response thật); KHÔNG dùng được response.statusCode ngay (Future<Response> không có getter statusCode, compiler báo lỗi); await = "mở gói" Future lấy Response thật. Liên hệ Java: http.get() ≈ CompletableFuture<Response>, await ≈ .get()/.join().
  - Mã thành công 200: em VẪN CHƯA xác nhận lại (đợt 1 ghi nhầm 202). Đã yêu cầu xác nhận gọn 1 câu.
  - QUYẾT ĐỊNH: vì là warm-up (không phải KT chính), sau khi giảng nốt phần thiếu → CHỐT phần lý thuyết warm-up coi như ĐỦ, không bắt làm lại. Nhưng đã cảnh báo rõ pattern "trả thiếu vế 2" để KT chính Tuần 4 không lặp lại; KT chính thầy sẽ KHÔNG giảng hộ phần thiếu.
  - MỞ BUỔI 2 (parse JSON → class Post): giao hướng dẫn cụ thể.
    - Tạo class Post (4 field userId/id/title/body) + factory Post.fromJson(Map<String,dynamic>). Đưa code khung có TODO (chỗ field body) cho em tự điền. Liên hệ class Contact Tuần 3.
    - Parse list: import dart:convert → jsonDecode(response.body) ra List<dynamic> → .map((item)=>Post.fromJson(item)).toList() ra List<Post>. Liên hệ Java: jsonDecode ≈ ObjectMapper, .map().toList() ≈ stream().map().collect(); fromJson tay ≈ Jackson/Gson nhưng không annotation.
    - Buổi 2 CHƯA cần UI — in console: số post = 100 + title post đầu.
    - Artifact nộp (artifacts/week-04/): post.dart (class Post + factory fromJson hoàn chỉnh) + bằng chứng console "Số post parse được: 100" + "Tiêu đề post đầu: ...".
    - Câu lý thuyết Buổi 2 (ép trả đủ từng ý): (1) vì sao factory thay vì constructor thường; (2) jsonDecode ở /posts trả kiểu gì + TẠI SAO (gợi ý nhìn dấu mở đầu body là [ hay {).
  - Nhắc rõ: mọi lệnh chạy ở máy lab d:\flutter, KHÔNG phải máy lớp học.
  - CHỜ em: (1) xác nhận 200, (2) trả 2 câu lý thuyết Buổi 2, (3) nộp post.dart + log parse 100 post.
- 2026-06-22 (Buổi 2, review log parse — đợt 1): Tú paste LOG CONSOLE từ MÁY THẬT (ASUS I005DA / ROG Phone 5s, project d:\api2).
  - Log: `statusCode: 200` + `Số post parse được: 100` + `Tiêu đề post đầu: sunt aut facere repellat provident occaecati excepturi optio reprehenderit`.
  - ĐÁNH GIÁ LOG: code parse JSON CHẠY ĐÚNG trên máy thật. statusCode 200 (em đã tự sửa được lỗi ghi nhầm 202 trước đó → coi như đã xác nhận 200 qua log thực tế). jsonDecode → List → map sang List<Post> ra đủ 100 phần tử, lấy được title post đầu chính xác (đúng nội dung post id=1 của JSONPlaceholder). Logic Buổi 2 thông.
  - NHƯNG CHƯA ĐỦ ĐỂ TÍNH ĐẠT BUỔI 2 — còn thiếu:
    1. FILE post.dart chưa nộp vào artifacts/week-04/ (Glob xác nhận thư mục mới chỉ có warmup-http.dart + warmup-console.png). Chưa đọc được code → chưa chấm được class Post + factory fromJson có đúng chuẩn không (mới chỉ thấy KẾT QUẢ chạy, chưa thấy CODE).
    2. 2 câu lý thuyết Buổi 2 chưa trả: (1) vì sao factory thay vì constructor thường; (2) jsonDecode ở /posts trả kiểu gì + TẠI SAO.
  - NHẮC LẠI điểm yếu cố hữu: câu (b)/(2) có 2 vế (kiểu gì + tại sao) — em hay rơi vế "tại sao". Ép trả đủ cả 2 vế lần này.
  - QUYẾT ĐỊNH: KHÔNG chấm ĐẠT Buổi 2 khi mới có log. Chờ post.dart + 2 câu lý thuyết rồi mới chốt.
- 2026-06-22 (Buổi 2, review FILE post.dart — đợt 2): Tú đã nộp `post.dart` vào artifacts/week-04/. Thầy đọc code và chấm.
  - CODE post.dart: ĐẠT, đúng chuẩn.
    - 4 field đủ + đúng kiểu: id(int), userId(int), title(String), body(String) — khớp schema JSONPlaceholder.
    - Constructor named + required, không sót field. Đúng kiểu Dart hiện đại.
    - factory Post.fromJson(Map<String, dynamic> json) đúng chữ ký, đọc đủ 4 field từ map. Đúng yêu cầu.
    - Class Post = phiên bản "đẻ ra từ JSON" của class Contact Tuần 3 → em chuyển tư duy POJO sang Dart đúng hướng.
  - LƯU Ý KỸ THUẬT (KHÔNG trừ điểm, đã nhắc): gán thẳng id: json['id'] không ép kiểu. JSONPlaceholder luôn trả int nên chạy ngon (log 100 post đã chứng minh). API thật khác có thể trả num/String-bọc-số → crash runtime. Phòng thủ: as int. Để dành Tuần 7 (API auth) giảng kỹ. Chỉ cần ghi nhớ lý do.
  - PARSE LIST: không nằm trong post.dart (file chỉ chứa class — tách file hợp lý). Logic jsonDecode + .map().toList() đã verify qua log máy thật đợt 1 (100 post + title post đầu chính xác). Coi như đã verify.
  - => PHẦN CODE BUỔI 2: ỔN (class Post + factory fromJson đúng + parse list verify qua log). 
  - CHƯA chốt ĐẠT trọn Buổi 2: vẫn nợ 2 câu lý thuyết Buổi 2 — em CHƯA trả câu nào.
    - (a) vì sao factory thay vì constructor thường.
    - (b) jsonDecode ở /posts trả KIỂU GÌ + TẠI SAO (2 vế — đúng chỗ em hay rơi vế "tại sao", đã lặp 4-5 lần). Đã nhắc kỹ năng: đọc xong đếm số ý, trả đủ.
  - TRẠNG THÁI: Buổi 2 = CODE xong, chờ 2 câu lý thuyết là CHỐT ĐẠT. Không giảng hộ phần lý thuyết (đã cảnh báo từ warm-up).
- 2026-06-22 (Buổi 2, chấm lý thuyết — đợt 3): Tú trả (a), BỎ LUÔN cả câu (b).
  - (a) nguyên văn: "Dùng factory vì dữ liệu nhận từ API là Map<String, dynamic> (JSON), cần chuyển đổi từ JSON sang object Post."
    - ĐÁNH GIÁ: ĐÚNG HƯỚNG nhưng CHƯA TRÚNG TRỌNG TÂM. Em mới nói CÔNG DỤNG (chuyển Map->Post để làm gì), chưa nói LÝ DO VÌ SAO PHẢI factory.
    - Thầy đã GIẢNG BỔ SUNG trọng tâm: factory constructor cho phép CHẠY LOGIC trước khi trả về object (đọc/ép kiểu từng field từ json, validate, xử lý null, trả instance cache) và không bắt buộc tạo instance mới mỗi lần / không nhất thiết gọi generative constructor. Constructor thường (generative) bắt buộc khởi tạo field trực tiếp, KHÔNG chạy được logic kiểu đọc json['id'] xử lý trước khi gán. Liên hệ Java/C#: static factory method / factory pattern.
  - (b) CHƯA TRẢ — em bỏ luôn cả câu. Đây KHÔNG còn là bỏ vế thứ hai trong 1 câu mà BỎ HẲN 1 câu. Đúng điểm yếu cố hữu (lần thứ 5-6 qua Tuần 3+4: back-vs-pop, Stateless-vs-Stateful, await vế 2, jsonDecode "tại sao"). Tuần 4 đã CỐ TÌNH tách (a)/(b) để ép trả đủ mà vẫn rơi cả câu.
    - Đã NHẮC NGHIÊM TÚC + cảnh báo hậu quả: KT chính (MỐC CỨNG) bỏ sót yêu cầu = rớt tiêu chí oan, KT chính KHÔNG giảng hộ phần thiếu. Kỹ năng yêu cầu: đọc xong ĐẾM số câu/ý rồi trả đủ.
    - KHÔNG giảng hộ (b) — chỉ gợi ý (nhìn ký tự mở đầu body là [ hay {), để em tự trả.
  - TRẠNG THÁI: CHƯA chốt ĐẠT Buổi 2. Code ổn, (a) đã giảng bổ sung trọng tâm, chờ DUY NHẤT câu (b) là chốt.
- 2026-06-22 (Buổi 2, chấm lý thuyết — đợt 4 → CHỐT ĐẠT BUỔI 2 + MỞ BUỔI 3): Tú trả (b), nguyên văn: "trả về kiểu: List<dynamic>. Vì API /posts trả về một JSON dạng mảng JSON array → Dart chuyển thành List".
  - (b) ĐÚNG và ĐỦ CẢ 2 VẾ: (1) kiểu = List<dynamic> đúng; (2) tại sao = vì body mở đầu bằng `[` (JSON array) nên jsonDecode trả List — đúng.
  - GHI NHẬN TÍCH CỰC: đây là LẦN ĐẦU em TỰ SỬA ĐƯỢC thói quen trả thiếu vế "tại sao" — điểm yếu cố hữu đã lặp 5-6 lần qua Tuần 3+4 (back-vs-pop, Stateless-vs-Stateful, await vế 2, jsonDecode "tại sao"). Lần này tự trả đủ 2 vế không cần thầy giảng hộ. Củng cố tích cực để giữ đà.
  - Bổ sung quy luật: endpoint /posts/1 (1 object, mở đầu `{`) → jsonDecode trả Map<String,dynamic>. Quy luật: `[`→List, `{`→Map.
  - => CHỐT BUỔI 2 ĐẠT: code post.dart đúng chuẩn + log máy thật đúng (200, 100 post, title post đầu chính xác) + 2 câu lý thuyết (a đã giảng bổ sung trọng tâm, b tự trả đủ 2 vế).
  - MỞ BUỔI 3 (gói lại thành hàm fetchPosts):
    - Đề: viết `Future<List<Post>> fetchPosts()` — gọi http.get → kiểm tra statusCode == 200, khác thì throw Exception → jsonDecode body thành List → .map() sang List<Post> → return.
    - Artifact nộp (artifacts/week-04/): api_service.dart (hoặc thêm vào post.dart) + log máy thật chứng minh fetchPosts() chạy được ("fetchPosts trả về N post" / title post đầu).
    - 2 câu lý thuyết Buổi 3 (ép tách bạch từng ý): (1) async/await là gì + vì sao fetchPosts PHẢI trả Future (liên hệ CompletableFuture Java); (2) vì sao nên throw Exception khi statusCode != 200 thay vì return list rỗng.
    - Nhắc em giữ đà thói quen ĐẾM số câu/ý trước khi trả (vừa làm tốt ở câu b).
    - Nhắc mọi lệnh chạy ở máy lab d:\flutter (project d:\api2), KHÔNG phải máy lớp học.
  - CHỜ em: nộp api_service.dart + log fetchPosts máy thật + 2 câu lý thuyết Buổi 3.

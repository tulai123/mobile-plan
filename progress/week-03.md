# Tuần 3 — Navigation + ListView

- Ngày: 2026-06-16 (khởi động sớm) → 2026-06-24 (deadline tuần)
- Trạng thái: ĐANG LÀM (khởi động 2026-06-16)
- Bối cảnh: Tuần 2 (vùng khó UI/layout) HOÀN THÀNH vượt mức. Em đã vững Column/Row/Container, tách widget, Expanded, BoxDecoration. Tuần 3 dùng lại toàn bộ nền đó để dựng nhiều màn hình.
- Mốc cứng gần nhất: TUẦN 4 phải gọi được API thật hiển thị dữ liệu. Tuần 3 là bước đệm bắt buộc (list + navigation) để Tuần 4 chỉ cần thay nguồn dữ liệu tĩnh bằng dữ liệu API.

## Mục tiêu tuần
1. Hiểu "màn hình / route trong Flutter là gì" — mỗi màn hình là 1 widget, Navigator quản lý theo dạng STACK.
2. Điều hướng push/pop: mở màn hình mới (push), quay lại (pop), hiểu vì sao có nút back tự động.
3. Dựng danh sách cuộn: ListView vs ListView.builder, ListTile — hiển thị List dữ liệu tĩnh.
4. Truyền data 2 chiều: truyền data sang màn Detail (qua constructor), và NHẬN kết quả trả về từ màn sau (await Navigator.push).
5. Output cuối tuần: mini-app DANH BẠ TĨNH — màn List (ListView danh sách contact) → bấm 1 item → màn Detail hiển thị chi tiết contact đó.

## Khái niệm cốt lõi (giảng theo thứ tự, KHÔNG nhồi 1 lúc)
- Buổi 1-2: Navigator stack + push/pop + MaterialPageRoute. Định hướng nhanh named routes / GoRouter (chưa nhồi sâu — Tuần 3 dùng MaterialPageRoute thuần cho dễ hình dung stack).
- Buổi 3-4: ListView + ListView.builder + ListTile. Vì sao .builder hiệu quả với danh sách dài (lazy build).
- Buổi 5: truyền data 2 chiều — sang Detail qua constructor; nhận kết quả về bằng `await Navigator.push(...)` + `Navigator.pop(context, value)`.
- Buổi 6: ráp mini-app danh bạ (List → Detail), dùng lại kỹ năng tách widget của Tuần 2.
- Buổi 7: nộp bài KT.

## Liên hệ Java/nền cũ
- Navigator = một STACK màn hình. push = đẩy màn mới lên đỉnh (giống push vào Stack, hoặc gọi 1 hàm mới → frame mới trên call stack). pop = bóc màn trên cùng ra, lộ lại màn dưới (giống return khỏi hàm → quay về caller).
- Với người từng làm Android thuần: push/pop ≈ startActivity / finish. Mỗi route ≈ 1 Activity, nhưng nhẹ hơn (chỉ là widget).
- Truyền data sang Detail = truyền tham số vào constructor của widget màn Detail (giống truyền argument vào hàm/constructor Java). KHÔNG cần biến global.
- Nhận kết quả trả về: `Navigator.push` trả về Future → `await` nó để lấy giá trị mà màn sau `pop(context, value)` gửi về. Đây chính là async/await em đã học Tuần 1 (Future ≈ CompletableFuture).
- ListView.builder ≈ vòng lặp tạo item nhưng LAZY: chỉ dựng item đang nhìn thấy, không dựng cả nghìn item cùng lúc → tiết kiệm bộ nhớ.

## Bài thực hành (máy lab) — giao dần
- Bài nhỏ 1 (WARM-UP, đã giao 2026-06-16): 2 màn hình.
  - Màn A (ScreenA): có 1 nút "Mở màn 2". Bấm → Navigator.push sang màn B.
  - Màn B (ScreenB): hiện chữ "Đây là màn 2" + 1 nút "Quay lại" gọi Navigator.pop (ngoài nút back mặc định của AppBar).
  - Mục tiêu: hình dung stack push/pop bằng tay, thấy nút back tự xuất hiện.
- Bài KT cuối tuần: xem mục dưới.

## Artifact phải nộp — WARM-UP (vào artifacts/week-03/)
- `warmup-nav.dart` — code đủ chạy: 2 màn hình A/B + 1 nút push + 1 nút pop. Có thể gộp trong 1 file.
- `warmup-screen-a.png` và `warmup-screen-b.png` — 2 screenshot trên ROG Phone 5s: 1 ảnh màn A, 1 ảnh màn B sau khi bấm push (thấy nút back ở AppBar).
- Trả lời ngắn trong chat: "Khi đang ở màn B mà bấm nút back, Navigator làm gì với stack?"

## Bài KT cuối Tuần 3 — MINI-APP DANH BẠ TĨNH (list → detail)
Yêu cầu:
- Có 1 danh sách `List<Contact>` tĩnh hardcode trong code (tối thiểu 5 contact). Contact là 1 class có ít nhất: tên, số điện thoại, email (em tự thêm field nếu muốn).
- Màn List: dùng `ListView.builder` + `ListTile` hiển thị từng contact (ít nhất tên + số điện thoại; nên có leading avatar/icon).
- Bấm 1 item → Navigator.push sang màn Detail, TRUYỀN đúng contact được chọn sang (qua constructor).
- Màn Detail: hiển thị đầy đủ thông tin contact được truyền sang. Có nút back hoạt động.
- (KHÔNG bắt buộc, điểm cộng): nút trả kết quả về List qua Navigator.pop(context, value) và List nhận được (vd đánh dấu "đã gọi") — đây là phần truyền data 2 chiều buổi 5.

## Artifact phải nộp — BÀI KT (vào artifacts/week-03/)
- `contacts_app.dart` (hoặc nhiều file .dart nếu em tách) — code mini-app danh bạ.
- `contacts-list.png` — screenshot màn List trên ROG Phone 5s.
- `contacts-detail.png` — screenshot màn Detail của 1 contact bất kỳ.

## Tiêu chí chấm (cuối tuần)
- [ ] Chạy không crash, danh sách cuộn mượt, bấm item mở được Detail
- [ ] Dùng đúng ListView.builder + ListTile (không phải Column nhồi tay)
- [ ] Truyền ĐÚNG contact được chọn sang Detail qua constructor (không dùng biến global, không truyền nhầm item)
- [ ] Có class Contact rõ ràng, dữ liệu tách khỏi UI gọn gàng
- [ ] Code tách widget hợp lý, đặt tên rõ (giữ chuẩn đã đạt ở Tuần 2)
- [ ] (Điểm cộng) Truyền data 2 chiều: nhận kết quả pop trả về

## Ghi chú giáo sư
- 2026-06-16: KHỞI ĐỘNG Tuần 3 (em chủ động mở sớm ngay sau khi KT Tuần 2 ĐẠT — giữ đúng nhịp nộp sớm 2 tuần liền).
  - Đặt mục tiêu tuần: Navigation (push/pop, MaterialPageRoute) + ListView/ListView.builder + ListTile + truyền data 2 chiều.
  - Giảng mở màn buổi 1: Navigator là STACK màn hình; push = đẩy màn mới lên đỉnh, pop = bóc ra quay lại. Liên hệ call stack Java + startActivity/finish của Android. Giới thiệu MaterialPageRoute; nhắc named routes/GoRouter ở mức định hướng (chưa dạy sâu — Tuần 3 dùng MaterialPageRoute thuần để em THẤY rõ cơ chế stack).
  - Sắp lộ trình 7 buổi (push/pop → ListView → truyền data 2 chiều → ráp danh bạ → nộp KT).
  - Giao bài WARM-UP: 2 màn hình, nút push + nút pop, nộp artifacts/week-03/ (2 file png + 1 dart + 1 câu trả lời lý thuyết về back/stack).
  - Định nghĩa trước bài KT cuối tuần (mini-app danh bạ list→detail) + tiêu chí chấm để em biết đích.
  - Nhấn mạnh liên kết với MỐC CỨNG TUẦN 4: ListView + navigation tuần này chính là khung mà Tuần 4 sẽ đổ dữ liệu API vào. Làm chắc tuần 3 → tuần 4 nhẹ.
  - CHỜ em nộp bài warm-up (artifacts/week-03/).
- 2026-06-17: Em hỏi nguồn học. Đã chỉ nguồn chính thống gắn theo từng buổi:
  - docs.flutter.dev Cookbook — Navigation: "Navigate to a new screen and back" (push/pop + MaterialPageRoute), "Send data to a new screen", "Return data from a screen". Lists: "Use lists", "Work with long lists" (ListView.builder), "Create a grid list" (đọc lướt).
  - api.flutter.dev — tra Navigator, MaterialPageRoute, ListView, ListView.builder, ListTile (dùng như từ điển, không học tuần tự).
  - YouTube kênh Flutter official — Widget of the Week (ListView/ListTile/Navigator). CẢNH BÁO: chỉ xem video 2021+ (sau null-safety mặc định), tránh tutorial cũ không compile.
  - DartPad (dartpad.dev) để thử nhanh không cần build.
  - Phương pháp ép: đọc cookbook → gõ tay lại → đổi 1 thứ để xem cái gì gãy. Không xem thụ động.
- 2026-06-17 (bổ sung): Em xin "link chính xác chỗ học" — không phải tên trang nữa mà ĐƯỜNG LINK URL cụ thể. Đã đưa danh sách URL chính thống (docs.flutter.dev cookbook + api.flutter.dev) kèm thứ tự đọc và gắn THẲNG từng link vào bài warm-up / bài KT:
  - WARM-UP (2 màn push/pop): docs.flutter.dev/cookbook/navigation/navigation-basics (đọc trước nhất). Tra API: api.flutter.dev Navigator, MaterialPageRoute.
  - BÀI KT (danh bạ list→detail): docs.flutter.dev/cookbook/lists/long-lists (ListView.builder) + docs.flutter.dev/ui/widgets/list (ListTile) + docs.flutter.dev/cookbook/navigation/passing-data (truyền contact sang Detail qua constructor). Điểm cộng 2 chiều: docs.flutter.dev/cookbook/navigation/returning-data.
  - Tra API từ điển: api.flutter.dev ListView, ListView.builder, ListTile.
  - Thử nhanh không build: dartpad.dev.
  - Đã nhấn lại phương pháp đọc chủ động (gõ tay lại, đổi 1 thứ xem gãy). CHỜ em nộp warm-up.

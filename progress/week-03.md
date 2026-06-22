# Tuần 3 — Navigation + ListView

- Ngày: 2026-06-16 (khởi động sớm) → 2026-06-24 (deadline tuần)
- Trạng thái: ĐẠT CẢ TUẦN (chốt 2026-06-22, sớm 2 ngày). BÀI KT ĐẠT + 2 câu lý thuyết đã trả lời và được bổ sung phần thiếu.
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
  - KẾT QUẢ 2026-06-19: ĐẠT.
- Bài nhỏ 2 (ListView.builder + ListTile, đã giao 2026-06-19): màn ListView.builder hiển thị List<String> tĩnh ~8 mục, ListTile có leading+title+subtitle. CHƯA cần navigation.
  - KẾT QUẢ 2026-06-19: ĐẠT (chi tiết ở Ghi chú giáo sư).
- Bài nhỏ 3 (LIST → DETAIL, truyền data, giao 2026-06-19): mảnh ghép cuối trước bài KT.
  - 1 class đơn giản (vd Mon { tên, mô tả }) hoặc dùng lại List<String>.
  - Màn List: ListView.builder + ListTile. Bấm 1 item → Navigator.push sang màn Detail, TRUYỀN item được chọn sang qua CONSTRUCTOR (DetailScreen(item: items[index])).
  - Màn Detail: nhận tham số qua constructor, hiển thị đúng item được bấm (không phải item cố định). Có nút back hoạt động.
  - Mục tiêu: ghép Navigation (bài 1) + ListView (bài 2) + truyền data qua constructor. Sau bài này em có đủ kỹ năng ráp mini-app danh bạ.
  - Artifact phải nộp (artifacts/week-03/): list-detail.dart + list-detail-list.png + list-detail-detail.png (chụp Detail của 1 item bất kỳ, phải khớp item đã bấm). Trên ROG Phone 5s.
  - KẾT QUẢ 2026-06-19: ĐẠT (chi tiết ở Ghi chú giáo sư).
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
- 2026-06-19: CHẤM WARM-UP Tuần 3 — ĐẠT. Verify qua artifact (control plane, không tự chạy flutter).
  - artifacts/week-03/warmup-nav.dart: push đúng (Navigator.push + MaterialPageRoute(builder: ...=> const ScreenB())); pop đúng (Navigator.pop(context) ở ScreenB). const dùng đúng chỗ (giữ thói quen tốt từ Tuần 2).
  - artifacts/week-03/warmup-screen-a.png: màn A, AppBar KHÔNG có back (route gốc) — đúng.
  - artifacts/week-03/warmup-screen-b.png: màn B, AppBar TỰ có back arrow (em không code) — đúng, em đã thấy cơ chế stack bằng mắt. Chụp trên ROG Phone 5s thật (status bar 8:35, pin 39%, gesture nav).
  - Lưu ý đã nhắc: warm-up chưa truyền data; bài KT sẽ biến const ScreenB() thành ContactDetailScreen(contact: ...) — cùng cơ chế push, thêm tham số constructor.
  - ĐÒI 2 câu lý thuyết (chưa cho qua hẳn tới khi em trả lời):
    1. (Warm-up T3) Bấm back AppBar ở màn B → Navigator làm gì với stack? Khác gì nút "Quay lại" tự code?
    2. (TREO TỪ TUẦN 2) Vì sao ScreenA/ScreenB là StatelessWidget? Khi nào màn hình BẮT BUỘC StatefulWidget?
  - BƯỚC TIẾP: chuyển sang buổi 3-4 — ListView / ListView.builder / ListTile (lazy build cho danh sách dài). Sau đó buổi 5 truyền data 2 chiều, buổi 6 ráp danh bạ, buổi 7 nộp KT.
  - Giao BÀI NHỎ 2 (cầu nối tới KT): dựng 1 màn ListView.builder + ListTile hiển thị List<String> tĩnh (~8 mục), CHƯA cần navigation/Detail. Mục tiêu: quen .builder + ListTile trước khi ráp list→detail.
- 2026-06-19: CHẤM BÀI NHỎ 2 (ListView.builder + ListTile) — ĐẠT. Verify artifacts/week-03/list-warmup.dart + list-warmup.png trên ROG Phone 5s thật (status bar 8:49, pin 47%, gesture nav).
  - ListView.builder ĐÚNG: không nhồi tay ListView(children:[...]).
  - itemCount: items.length — không hardcode số. Đúng.
  - itemBuilder lấy items[index] theo index — mỗi dòng dữ liệu khác nhau (Flutter/Dart/Java/C#/Python/JavaScript/PHP/C++), KHÔNG lặp 1 chuỗi. subtitle "Phần tử thứ ${index+1}" chứng tỏ em hiểu index. Đúng.
  - ListTile đủ leading (Icon person) + title (Text items[index]) + subtitle. Đủ 3 thành phần.
  - Chạy không crash, cuộn được, screenshot máy thật. List dữ liệu tách khỏi UI gọn (khai báo final items đầu build).
  - Giữ thói quen tốt từ Tuần 2: const dùng đúng chỗ (const Icon, const Text title AppBar).
  - Lưu ý kỹ thuật nhỏ (KHÔNG trừ điểm, để chuẩn bị bài KT): final items đang khai báo TRONG build() → sẽ tạo lại mỗi lần rebuild. Với danh bạ tĩnh nên nâng lên field/biến ngoài build (hoặc top-level). Sẽ áp dụng khi ráp List<Contact>.
  - BƯỚC TIẾP: buổi 5 — TRUYỀN DATA sang màn Detail (push kèm dữ liệu qua constructor, đọc dữ liệu ở Detail). Đây là mảnh ghép cuối trước khi ráp mini-app danh bạ list→detail (bài KT cuối tuần).
  - Giao BÀI NHỎ 3 (cầu nối cuối tới KT): list → detail với truyền data qua constructor. Chi tiết dưới mục "Bài thực hành".
  - 2 câu lý thuyết VẪN TREO (em chưa trả lời trong artifact/chat): (1) back AppBar vs pop tự code; (2) StatelessWidget vs StatefulWidget (treo từ Tuần 2). Đã nhắc lại, KHÔNG chặn tiến độ — nhưng phải trả lời trước khi chốt Đạt Tuần 3.
- 2026-06-19: CHẤM BÀI NHỎ 3 (LIST → DETAIL, truyền data qua constructor) — ĐẠT. Verify qua artifact (control plane, không tự chạy flutter).
  - artifacts/week-03/list-detail.dart: onTap → Navigator.push + MaterialPageRoute(builder: (context) => DetailScreen(item: items[index])) — TRUYỀN ĐÚNG items[index] theo item bấm, KHÔNG hardcode, KHÔNG dùng biến global. Đúng yêu cầu cốt lõi.
  - DetailScreen nhận data đúng cách: final String item; const DetailScreen({super.key, required this.item}). Field final + required this.item — chuẩn truyền tham số qua constructor (giống truyền argument vào constructor Java).
  - DetailScreen hiển thị "Bạn đã chọn: $item" theo đúng item truyền sang, không phải chuỗi cố định.
  - artifacts/week-03/list-detail-list.png: màn List trên ROG Phone 5s thật (status bar 9:44, pin 76%, gesture nav), 8 ListTile (icon sao + title + "Phần tử số N"), render sạch.
  - artifacts/week-03/list-detail-detail.png: màn Detail trên ROG Phone 5s thật (9:44, pin 76%), AppBar "Chi tiết" có back arrow tự động, hiển thị "Bạn đã chọn: Flutter" — KHỚP item đầu (Flutter) trong list. Bằng chứng truyền data đúng, không truyền nhầm. Chạy không crash trên máy thật.
  - LƯU Ý KỸ THUẬT TREO TỪ BÀI NHỎ 2 (chưa trừ điểm, nhưng PHẢI SỬA khi ráp danh bạ): final List<String> items vẫn đang khai báo TRONG build() → tạo lại mỗi lần rebuild. Bài KT phải đưa data RA NGOÀI build() (field của widget hoặc top-level const), không tạo lại mỗi rebuild.
  - BƯỚC TIẾP: em đã có đủ 3 mảnh ghép (Navigation + ListView.builder + truyền data qua constructor). Giao BÀI KT CUỐI TUẦN: mini-app danh bạ list→detail với class Contact (≥5 contact, mỗi contact ≥ tên + sđt + email). Đề + tiêu chí ở mục "Bài KT cuối Tuần 3".
  - 2 câu lý thuyết VẪN TREO (em chưa trả lời): (1) back AppBar vs pop tự code; (2) StatelessWidget vs StatefulWidget (treo từ Tuần 2). KHÔNG chặn làm bài KT, NHƯNG chặn việc chốt ĐẠT cả Tuần 3 — phải trả lời trước khi thầy chốt tuần.
- 2026-06-22: CHẤM BÀI KT CUỐI TUẦN — MINI-APP DANH BẠ (list→detail). KẾT QUẢ: ĐẠT (nộp sớm 2 ngày, deadline 06-24). Verify qua artifact (control plane, không tự chạy flutter).
  - Tiêu chí 1 (chạy không crash, cuộn mượt, bấm item mở Detail): ĐẠT. Verify contacts-list.png + contacts-detail.png trên ROG Phone 5s thật (status bar 3:20, pin 100%, gesture nav). List render 5 contact sạch, không overflow. Detail "Nguyen Van A / 0901234567 / a@gmail.com" KHỚP đúng contact đầu list → bằng chứng truyền data đúng.
  - Tiêu chí 2 (ListView.builder + ListTile, không Column nhồi tay): ĐẠT. ListView.builder + itemCount: contacts.length (không hardcode) + itemBuilder lấy contacts[index]. ListTile đủ leading (CircleAvatar chữ cái đầu tên) + title + subtitle.
  - Tiêu chí 3 (truyền ĐÚNG contact qua constructor, không global): ĐẠT. onTap → push ContactDetailScreen(contact: contact) với contact = contacts[index]. ContactDetailScreen: final Contact contact + const + required this.contact. Chuẩn.
  - Tiêu chí 4 (class Contact rõ ràng, data tách khỏi UI): ĐẠT. class Contact (name/phone/email, required, final). ĐÃ SỬA lưu ý treo từ bài nhỏ 2/3: List<Contact> contacts giờ là FIELD của ContactListScreen (dòng 34), KHÔNG còn khai báo trong build(). Em đã tiếp thu đúng góp ý.
  - Tiêu chí 5 (tách widget, đặt tên rõ): ĐẠT. 4 class tách rõ (MyApp / Contact / ContactListScreen / ContactDetailScreen), tên có nghĩa. const dùng đúng chỗ (Text AppBar, EdgeInsets, SizedBox, TextStyle). Giữ chuẩn Tuần 2.
  - Tiêu chí 6 (ĐIỂM CỘNG — truyền data 2 chiều pop trả về): KHÔNG làm. Không bắt buộc, không trừ điểm.
  - GÓP Ý KỸ THUẬT (không trừ điểm, để chuẩn bị Tuần 4):
    1. ContactListScreen có field (List contacts) nhưng constructor không const + không có const ở `home: ContactListScreen()`. Vì field là biến thường (không phải const), không const được — CHẤP NHẬN ở mức này. Khi lên Tuần 4 data đến từ API (động) thì điều này tự nhiên.
    2. `Contact contact = contacts[index];` trong itemBuilder nên là `final contact` (Dart suy luận kiểu) — thói quen tốt, không bắt buộc.
    3. CircleAvatar dùng contact.name[0] làm avatar — ổn. Lưu ý phòng thủ tương lai: nếu name rỗng sẽ crash (RangeError). Data tĩnh nên chưa sao; khi data từ API phải nghĩ tới null/empty.
  - 2 câu lý thuyết VẪN TREO: (1) back AppBar vs pop tự code; (2) StatelessWidget vs StatefulWidget (treo từ Tuần 2). Bài KT đã ĐẠT về kỹ năng, NHƯNG thầy CHƯA chốt ĐẠT cả Tuần 3 cho tới khi em trả lời 2 câu này. Đây là kiến thức nền cho Tuần 4-5 (FutureBuilder + setState/Provider).
  - BƯỚC TIẾP: chờ 2 câu lý thuyết → chốt ĐẠT Tuần 3 → khởi động Tuần 4 (gọi REST API + FutureBuilder + loading/error). Tuần 4 = MỐC CỨNG. App danh bạ này chính là khung: chỉ thay List<Contact> tĩnh bằng dữ liệu fetch từ API.
- 2026-06-22: CHẤM 2 CÂU LÝ THUYẾT TREO → CHỐT ĐẠT CẢ TUẦN 3.
  - Câu trả lời nguyên văn của em: "Khi mở màn Detail bằng Navigator.push(), màn Detail sẽ được đưa vào đầu stack của Navigator. Các màn đều dùng StatelessWidget vì giao diện chỉ hiển thị dữ liệu và không có trạng thái thay đổi trong quá trình chạy."
  - ĐÁNH GIÁ TRUNG THỰC: cả 2 câu mới trả lời được MỘT NỬA.
    - Câu 1: đúng phần push đẩy Detail lên đỉnh stack. NHƯNG câu hỏi là "bấm back AppBar làm gì với stack" và "khác gì pop tự code" — em CHƯA trả lời. Thầy đã giảng bổ sung: back AppBar = Navigator.pop() ngầm (Flutter tự gắn vào leading của AppBar khi route không phải route gốc); bóc route trên đỉnh stack, lộ lại route dưới. Về CƠ CHẾ STACK: back AppBar ≡ pop tự code, không khác. Khác ở chỗ CHỦ ĐỘNG: pop tự code thì mình kiểm soát thời điểm + truyền được giá trị về (pop(context, value)) + chạy logic trước khi rời màn; back AppBar là hành vi mặc định, không trả giá trị tùy biến.
    - Câu 2: đúng vế "vì sao Stateless được" (UI chỉ hiển thị data, không đổi lúc runtime). NHƯNG CHƯA trả lời vế "khi nào BẮT BUỘC StatefulWidget". Thầy đã bổ sung: bắt buộc Stateful khi widget có DỮ LIỆU NỘI BỘ THAY ĐỔI THEO THỜI GIAN và cần VẼ LẠI khi đổi — ô tick checkbox, biến đếm, TextField đang gõ, toggle, dữ liệu đang load (loading/loaded/error). Cơ chế: setState() báo Flutter rebuild. Nối thẳng Tuần 4: trạng thái loading→có data→lỗi của màn gọi API chính là ví dụ kinh điển BẮT BUỘC Stateful (hoặc FutureBuilder lo giúp).
  - QUYẾT ĐỊNH: trả lời chưa đầy đủ nhưng phần thiếu đã được giảng và em xác nhận hiểu được; kỹ năng code đã chứng minh qua bài KT ĐẠT. Không bắt làm lại — CHỐT ĐẠT Tuần 3. Lưu ý hồ sơ: em có xu hướng trả lời lý thuyết ngắn/thiếu vế thứ hai của câu hỏi → Tuần 4 thầy sẽ hỏi lý thuyết bằng câu tách bạch từng vế để ép em trả lời đủ.
  - Tuần 3 HOÀN THÀNH 100%. Mở Tuần 4 (progress/week-04.md).

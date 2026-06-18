# Tuần 2 — Flutter fundamentals + layout

- Ngày: 2026-06-11 → 2026-06-17
- Trạng thái: HOÀN THÀNH (bài KT profile ĐẠT ngày 2026-06-16)
- Lưu ý: VÙNG KHÓ với học viên — nền frontend/UI/layout yếu. Đi chậm, nhiều ví dụ trực quan.

## Mục tiêu tuần
1. Hiểu "everything is a Widget" — Widget tree là gì, cách Flutter dựng UI từ cây widget.
2. Phân biệt StatelessWidget vs StatefulWidget — khi nào dùng cái nào, vì sao cần setState.
3. Nắm layout cơ bản: Container, Column, Row, Stack — và các thuộc tính căn chỉnh (mainAxis/crossAxis, padding, margin).
4. Build được 1 màn hình tĩnh hoàn chỉnh từ mockup mà không crash overflow.

## Khái niệm cốt lõi (giảng theo thứ tự, không nhồi 1 lúc)
- Buổi 1-2: Widget tree + StatelessWidget. Container + Text + căn giữa.
- Buổi 3-4: Column / Row + alignment (mainAxisAlignment, crossAxisAlignment) + padding/margin/SizedBox.
- Buổi 5: StatefulWidget + setState (liên hệ lại app counter tuần 1).
- Buổi 6: Stack + overflow debugging + ráp màn hình profile.
- Buổi 7: nộp bài KT.

## Liên hệ Java/nền cũ
- Widget tree ≈ cây component UI. Mỗi widget là 1 object (giống new object trong Java) nhưng immutable.
- build() ≈ hàm render trả về mô tả UI, KHÔNG phải nơi đặt logic nặng.
- setState() ≈ báo framework "state đổi rồi, vẽ lại đi" — không gán biến trực tiếp lên UI như Java Swing.
- Nối tiếp góp ý tuần 1: đóng gói state trong object → đúng tinh thần StatefulWidget giữ state nội bộ.

## Bài thực hành (máy lab) — giao dần
- Bài nhỏ 1 (warm-up): màn hình 1 Container giữa màn hình có chữ + màu nền. Mục tiêu làm quen build().
- Bài KT cuối tuần: màn hình PROFILE tĩnh từ mockup (avatar tròn, tên, chức danh, 1 hàng 3 ô thống kê dùng Row, vài dòng thông tin dùng Column, 1-2 nút). Tĩnh hoàn toàn, chưa cần bấm có tác dụng.

## Artifact phải nộp (vào artifacts/week-02/)
- `*.dart` — file code màn hình profile
- `profile-on-device.png` — screenshot chạy trên ROG Phone 5s

## Tiêu chí chấm (cuối tuần)
- [x] Chạy không crash, không lỗi overflow vàng-đen
- [x] Đúng bố cục mockup (avatar, tên, hàng thống kê, thông tin)
- [x] Dùng đúng Column/Row/Container, có padding/spacing hợp lý
- [x] Code tách widget gọn, đặt tên rõ

## Ghi chú giáo sư
- 2026-06-10: Tổng kết Tuần 1 (HOÀN THÀNH 100%, bài KT ĐẠT sớm 1 ngày). Khởi động Tuần 2.
  - Đã giảng: khái niệm Widget tree + Stateless vs Stateful (lý thuyết nền), liên hệ Java.
  - Đã giao bài warm-up đầu tiên (Container + Text căn giữa) làm bằng chứng đã build được màn hình tự viết, không phải app counter mặc định.
  - Nhấn mạnh đây là vùng khó (UI/layout). Theo dõi sát mức vấp ở alignment/overflow.
  - CHỜ học viên nộp bài warm-up (artifacts/week-02/).
- 2026-06-10: CHẤM bài warm-up → ĐẠT. Verify qua artifacts/week-02/warmup-main.dart + warmup-on-device.png (chạy thật trên ROG Phone 5s, code khớp ảnh).
  - TODO 1 padding (EdgeInsets.all(24)): ĐẠT, dùng const đúng.
  - TODO 2 màu nền: ĐẠT.
  - TODO 3 bo góc (phần nâng): ĐẠT — BorderRadius.circular(16), làm được phần khó hơn yêu cầu.
  - Đã giảng color vs decoration: không dùng đồng thời color + decoration trên 1 Container (crash assert); cần bo góc/shadow/border thì dồn màu vào BoxDecoration. Học viên làm đúng cách.
  - Code style tốt: tách style Text, const đúng chỗ, tắt debug banner.
  - TREO: câu lý thuyết "vì sao MyApp là StatelessWidget" — học viên CHƯA trả lời trong artifact. Đã yêu cầu trả lời trong chat.
  - Đã dặn: bài KT cuối tuần (profile) sẽ yêu cầu TÁCH WIDGET CON.
  - Bước tiếp: buổi 3-4 Column/Row + alignment (điểm dễ vấp nhất với học viên).
- 2026-06-10: GỠ TREO câu lý thuyết — học viên trả lời "Stateless vì MyApp thường không thay đổi khi chạy, Stateful là năng động". → ĐẠT Ý CỐT LÕI (không đổi theo thời gian → Stateless), diễn đạt còn mơ hồ. Đã giảng lại chính xác: Stateless = không có state nội bộ đổi theo thời gian, UI chỉ phụ thuộc input (constructor params); Stateful = có state đổi qua setState → rebuild. Cho ví dụ đối lập tên tĩnh vs counter.
  - HOÀN TẤT warm-up + lý thuyết nền. Vào buổi 3-4: Column/Row + main/cross axis alignment. Đã giao bài Column/Row trên DartPad (không cần máy lab cho bài này, làm nhanh trên web).
- 2026-06-16: CHẤM bài KT cuối tuần (màn hình profile tĩnh) → ĐẠT. Verify qua artifacts/week-02/profile.dart + profile-on-device.png (chạy thật trên ROG Phone 5s, status bar 8:50, code khớp ảnh 100%, KHÔNG overflow vàng-đen, không màn đỏ).
  - Tiêu chí 1 (chạy không crash/overflow): ĐẠT. Screenshot sạch, layout co giãn đúng.
  - Tiêu chí 2 (đúng bố cục mockup): ĐẠT. Đủ avatar tròn, tên + chức danh phân biệt, hàng 3 ô thống kê, 3 dòng info, 2 nút.
  - Tiêu chí 3 (đúng Column/Row/Container + spacing): ĐẠT. SingleChildScrollView padding 16, SizedBox tách section đều, Row thống kê chia đều bằng Expanded + SizedBox(width:8).
  - Tiêu chí 4 (tách widget gọn, đặt tên rõ): ĐẠT — VƯỢT yêu cầu. Tách 4 widget con: ProfileHeader, StatCard (có param number/label), InfoRow (param icon/text), ProfileActions. Tên rõ, đúng nghĩa.
  - ĐIỂM XUẤT SẮC: (a) Expanded dùng đúng 3 chỗ — Row thống kê (chia đều), InfoRow (chống overflow text ngang), nút (chia đều). (b) BoxDecoration đúng cách: color nằm TRONG decoration, không phạm lỗi color + decoration đồng thời (đã giảng từ warm-up → đã ghi nhớ và áp dụng đúng). (c) const đặt hợp lý nhiều chỗ, tắt debugShowCheckedModeBanner.
  - GÓP Ý NÂNG CAO (không hạ điểm, để dành cho sau): (1) magic number spacing (16/24/12/8) rải rác → sau này gom thành hằng số/spacing scale cho nhất quán. (2) màu hardcode Colors.blue.shade50/grey → khi học Theme (sau tuần 5) nên lấy từ Theme.of(context) để dễ đổi dark mode. (3) StatCard có thể nhận thêm const cho TextStyle dùng chung. Đều là tối ưu trưởng thành, KHÔNG bắt buộc ở tuần 2.
  - KẾT LUẬN: Tuần 2 (vùng khó UI/layout) HOÀN THÀNH. Học viên qua được điểm vấp lo ngại nhất (alignment/overflow) gọn gàng. Sẵn sàng vào Tuần 3 (Navigation + ListView).

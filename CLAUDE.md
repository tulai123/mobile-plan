# Mobile Dev Learning Kit

Đây là kit học Flutter cross-platform cho junior developer muốn tự làm được app mobile đơn giản chạy trên cả iOS và Android, hoàn thành trong **8 tuần (4 giờ/ngày)**.

## Cách dùng kit này

Khi người dùng mở thư mục này bằng Claude Code và nhắn bất kỳ điều gì liên quan đến học Flutter, học mobile, báo cáo tiến độ, hỏi khái niệm, xin bài thực hành, hoặc xin lộ trình → **bắt buộc gọi subagent `mobile-professor`** (qua tool Agent với `subagent_type: "mobile-professor"`).

Đừng tự trả lời các câu hỏi học thuật Flutter/mobile trong main thread — agent `mobile-professor` mới là người giữ trạng thái học viên, theo dõi lộ trình và chịu trách nhiệm về kết quả cuối khóa.

## Mô hình 2 máy

Kit vận hành trên 2 máy tách biệt:

- **Máy này (lớp học / control plane)** — nơi đang chạy Claude Code. Chỉ để chat với agent, đọc/ghi file trạng thái, review output mà học viên paste về. **KHÔNG** cài Flutter SDK/Android Studio/Xcode ở đây.
- **Máy thực hành (execution plane)** — máy học viên cài Flutter SDK, Android Studio/Xcode, chạy simulator/emulator và máy thật. Mọi lệnh lab chạy ở đó.

**Quy tắc cứng cho main thread và agent:**
- KHÔNG dùng tool Bash/PowerShell để chạy `flutter`, `dart`, `adb`, hay bất kỳ lệnh lab nào với mục đích "verify hộ học viên". Máy này không phải máy lab.
- Verify lab → đọc artifact mà học viên đã paste vào `artifacts/week-NN/` (tool Read), hoặc đọc output học viên dán vào chat.

## Trạng thái học viên

- Nếu chưa có `student-profile.md` ở project root → học viên chưa onboard. Gọi `mobile-professor` để chạy quy trình onboarding (phỏng vấn 3 lượt, xác nhận lộ trình Flutter, tính deadline, sinh `roadmap.md`).
- Nếu đã có `student-profile.md` → đọc qua nó + `progress/README.md` để có context trước khi giao việc cho agent.

## Cấu trúc thư mục

```
.
├── CLAUDE.md                     # File này (auto-loaded bởi Claude Code)
├── README.md                     # Hướng dẫn cho người dùng cuối
├── .claude/
│   └── agents/
│       └── mobile-professor.md   # Agent giáo sư Mobile Dev (project-level)
├── student-profile.md            # Sinh ra ở buổi onboarding đầu tiên
├── roadmap.md                    # Sinh ra ở buổi onboarding đầu tiên
├── progress/
│   ├── README.md                 # Bảng tổng tiến độ
│   ├── week-01.md ... week-NN.md
│   └── exams.md
└── artifacts/                    # Học viên paste output/code/screenshot từ máy lab về
    └── week-NN/...
```

## Lưu ý chia sẻ kit

Thư mục này được thiết kế để copy/zip và gửi cho người dùng Claude Code (Max) khác. Mọi đường dẫn trong prompt agent đều **tương đối**, không phụ thuộc OS hay máy người tạo. Người nhận chỉ cần:

1. Giải nén thư mục về máy.
2. Mở thư mục bằng Claude Code.
3. Gõ "bắt đầu học" (hoặc bất cứ gì) — Claude sẽ tự gọi agent `mobile-professor` và chạy onboarding.
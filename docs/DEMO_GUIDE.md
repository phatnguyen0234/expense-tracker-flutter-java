# Demo Guide - Expense Tracker

## 📱 App Demo Walkthrough

### 1. Authentication Flow

**Splash Screen**
- App loads → Checks for saved token
- If no token → Show Login screen
- If token exists → Go to Home

**Login Screen**
```
📧 Email: test@example.com
🔒 Password: ••••••••
[   LOGIN   ]
Create account? [SIGN UP]
```

**Registration Screen**
```
📧 Email: newuser@example.com
🔒 Password: ••••••••
👤 Full Name: John Doe
[  REGISTER  ]
Already have account? [LOGIN]
```

**Home Screen (After Login)**
```
╔═══════════════════════════╗
║  💰 Expense Tracker      ║
║  ┌─────────────────────┐ ║
║  │ Chào mừng           │ ║
║  │ Quản lý tài chính   │ ║
║  └─────────────────────┘ ║
║                           ║
║  ┌──────────────────────┐ ║
║  │ ➕ Thêm giao dịch   │ ║
║  │ Ghi lại thu chi...  │ ║
║  └──────────────────────┘ ║
║                           ║
║  ┌──────────────────────┐ ║
║  │ 📊 Dashboard        │ ║
║  │ Xem thống kê...     │ ║
║  └──────────────────────┘ ║
║                           ║
║  ┌──────────────────────┐ ║
║  │ 🏷️ Danh mục        │ ║
║  │ Quản lý danh mục... │ ║
║  └──────────────────────┘ ║
║                           ║
║  [↩️ LOGOUT]              ║
╚═══════════════════════════╝
```

### 2. Transaction Management

**Add Transaction**
```
Press [+] button

Dialog: "Thêm giao dịch"
┌─────────────────────────────┐
│ Chọn danh mục: [Food   ▼]   │
│ Số tiền:       [50000    ]  │
│ Chi tiêu:      [CHI TIÊU ▼] │
│ Ngày:          [16/3/2026 📅]│
│ Giờ:           [22:53    🕐] │
│ Tiền mặt:      [CASH    ▼]   │
│ Ghi chú:       [Lunch   ]   │
│                 [        ]   │
│                 [        ]   │
├─────────────────────────────┤
│ [Cancel]  [Delete]  [Save]  │
└─────────────────────────────┘

✅ Transaction saved!
```

**Transaction List**
```
Filter: [Tháng ▼] [Chi tiêu ▼]

├─────────────────────────────┐
│ 🟢 Food                     │
│ Lunch                       │
│ 16/3/2026          -50000đ  │
├─────────────────────────────┤
│ 🟢 Transport                │
│ Gas                         │
│ 16/3/2026         -100000đ  │
├─────────────────────────────┤
│ 🔴 Salary                   │
│ Monthly salary              │
│ 15/3/2026        +4000000đ  │
└─────────────────────────────┘
```

### 3. Category Management

**Category List**
```
Filter: [Chi tiêu ▼]

├─────────────────────────────┐
│ 🏷️ Food                     │
│ Chi tiêu          [✎] [🗑] │
├─────────────────────────────┤
│ 🏷️ Transport                │
│ Chi tiêu          [✎] [🗑] │
├─────────────────────────────┤
│ 🏷️ Entertainment            │
│ Chi tiêu          [✎] [🗑] │
└─────────────────────────────┘

[+] Add Category
```

**Add Category**
```
Dialog: "Thêm danh mục"
┌──────────────────────┐
│ Tên: [Entertainment] │
│ Loại: [CHI TIÊU  ▼] │
├──────────────────────┤
│ [Cancel]   [Save]    │
└──────────────────────┘

✅ Category created!
```

### 4. Dashboard / Statistics

**Summary Cards**
```
┌──────────────┐ ┌──────────────┐
│ 💚 Thu nhập  │ │ ❤️ Chi tiêu  │
│ 4,000,000đ  │ │ 150,000đ    │
└──────────────┘ └──────────────┘

┌──────────────────────┐
│ 💙 Cân bằng         │
│ 3,850,000đ          │
└──────────────────────┘

Kéo xuống để refresh 🔄
```

**Category Breakdown**
```
Chi tiêu theo danh mục:

Food (50%)
████████████ 75,000đ

Transport (30%)
███████ 45,000đ

Entertainment (20%)
████ 30,000đ

---

Thu nhập theo danh mục:

Salary (100%)
████████████████ 4,000,000đ
```

### 5. Filter & Search

**Filter by Month**
```
[Tháng ▼]
 ├─ Tất cả
 ├─ Tháng 1
 ├─ Tháng 2
 ├─ Tháng 3  ✓ (Current)
 └─ ...
```

**Filter by Type**
```
[Loại ▼]
 ├─ Tất cả
 ├─ Thu nhập  ✓
 └─ Chi tiêu
```

### 6. Error Handling

**Network Error**
```
╔═════════════════════╗
│ ❌ Lỗi             │
│ Không thể kết nối   │
│ tới server. Vui    │
│ lòng kiểm tra kết  │
│ nối mạng.          │
╠═════════════════════╣
│        [OK]         │
╚═════════════════════╝
```

**Validation Error**
```
SnackBar (Red):
⚠️ Vui lòng chọn danh mục
[CLOSE]
```

**Success Message**
```
SnackBar (Green):
✅ Giao dịch đã được lưu!
```

**Logout Confirmation**
```
╔═════════════════════════════╗
│ Đăng xuất                   │
│ Bạn có chắc chắn muốn       │
│ đăng xuất?                  │
╠═════════════════════════════╣
│ [Hủy]         [Đăng xuất]   │
╚═════════════════════════════╝
```

### 7. Loading States

**Loading Spinner**
```
    🔄 Loading...
    
(Shows while fetching data)
```

**Empty States**
```
📥 Không có giao dịch

(Shows when list is empty)
```

---

## 🎬 Demo Scenarios

### Scenario 1: First Time User (2 min)
1. Open app → Login screen
2. Click "Sign Up" → Create account
3. Wait for confirmation → Go to Home
4. Click "Manage Categories" → Add 3 categories (Food, Transport, Entertainment)
5. Go back to Home
6. Click "Add Transaction" → Add 5 transactions
7. View Dashboard → Show stats

### Scenario 2: View & Filter (1 min)
1. Go to Transactions
2. Filter by month → See transactions for specific month
3. Filter by type → Show only expense
4. Show empty state when no matches
5. Clear filter → Show all again

### Scenario 3: Edit & Delete (1 min)
1. Go to Transactions
2. Click on transaction → Open edit dialog
3. Modify amount → Save (show success)
4. Click delete → Confirm → Remove
5. List refreshes automatically

### Scenario 4: Error Handling (1 min)
1. Go offline (or wait for timeout)
2. Try to load transactions → Show error
3. Click retry → Reload when connection back
4. Show network error gracefully

### Scenario 5: Complete Flow (3 min)
1. Register → Login
2. Create categories
3. Add 10+ transactions
4. View dashboard
5. Filter by month
6. Edit one transaction
7. Delete one category
8. Logout

---

## 📊 GIF Demo Points

### GIF 1: Authentication (5s)
- Splash → Login → Register → Home (5 screens transition)

### GIF 2: Add Transaction (10s)
- Home → Click + → Fill form → Pick date/time → Save → Success message

### GIF 3: Transaction List & Filter (10s)
- List transactions → Filter by month → Filter by type → See empty state → Clear filter

### GIF 4: Category Management (8s)
- Category list → Add new → Edit → Delete with confirmation → Success

### GIF 5: Dashboard & Stats (8s)
- Dashboard → Show summary cards → Scroll to see charts → Pull refresh

### GIF 6: Complete Workflow (30s)
- Full app flow: Register → Add categories → Add transactions → View dashboard → Filter → Edit → Delete

---

## 🚀 Ready for Production

✅ All screens fully functional
✅ Error handling implemented
✅ Loading states shown
✅ Empty states handled
✅ Smooth animations
✅ Modern UI with gradients
✅ Responsive design

---

**App is demo-ready! 🎉**


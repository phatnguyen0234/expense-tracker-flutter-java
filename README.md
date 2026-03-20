# 💰 Expense Tracker - Quản Lý Tài Chính Cá Nhân

![Flutter](https://img.shields.io/badge/Flutter-3.24.3-blue)
![Dart](https://img.shields.io/badge/Dart-3.5.3-blue)
![Spring Boot](https://img.shields.io/badge/Spring%20Boot-3.2.0-green)
![License](https://img.shields.io/badge/License-MIT-yellow)

Ứng dụng quản lý thu chi cá nhân với giao diện đẹp, tính năng đầy đủ, hỗ trợ thống kê chi tiêu theo danh mục.

## 🎯 Tính Năng

### ✅ Đã Hoàn Thành (MVP - Days 9-13)
- 🔐 **Authentication**: Đăng ký, đăng nhập với JWT
- 📱 **Transactions**: Thêm/sửa/xóa giao dịch
- 🏷️ **Categories**: Quản lý danh mục thu/chi
- 📅 **Filters**: Lọc theo tháng, loại (income/expense), danh mục
- 📊 **Dashboard**: Thống kê tổng thu/chi, cân bằng, biểu đồ theo danh mục
- 🎨 **Modern UI**: Gradient backgrounds, card layouts, smooth animations
- ⏰ **Date/Time Picker**: Chọn ngày giờ cụ thể cho giao dịch
- 💾 **CRUD Operations**: Đầy đủ tính năng quản lý dữ liệu

### 📌 Tính Năng Tương Lai (Optional)
- 📈 Budget Tracking & Alerts
- 📊 Advanced Charts (Bar, Line charts)
- 💾 Offline Sync (Hive)
- 📧 Email Reports
- 🔔 Push Notifications

## 🏗️ Kiến Trúc Dự Án

```
expense-tracker/
├── backend/
│   └── expense-backend/          # Spring Boot backend
│       ├── src/main/java/...
│       ├── pom.xml
│       └── docker-compose.yml
├── mobile/
│   └── (Flutter app)              # Flutter mobile app
│       ├── lib/
│       │   ├── main.dart
│       │   ├── screens/
│       │   ├── features/
│       │   └── core/
│       ├── pubspec.yaml
│       └── .env.example
└── docs/
    └── API_SPEC.md
```

## 📱 Giao Diện Ứng Dụng (Frontend - Day 14)

### Màn hình chính - Home Screen
Giao diện chính với header gradient xanh dương, các menu nhanh cho việc quản lý tài chính.

<img src="https://raw.githubusercontent.com/phatnguyen0234/expense-tracker-flutter-java/main/screenshots/01_home_screen.png" alt="Home Screen" width="300"/>

**Đặc điểm:**
- ✨ Gradient header (#5B7DFF → #3E5BDF)
- 🔐 Nút logout trong header
- 📌 3 menu nhanh: Thêm giao dịch, Dashboard, Danh mục
- 🎨 Modern card design với shadow

### Màn hình đăng nhập - Login
Form đăng nhập đơn giản với xác thực JWT.

<img src="https://raw.githubusercontent.com/phatnguyen0234/expense-tracker-flutter-java/main/screenshots/02_login_screen.png" alt="Login Screen" width="300"/>

**Đặc điểm:**
- ✉️ Nhập email
- 🔑 Nhập password
- 🔵 Nút login gradient
- 🔗 Kết nối REST API với backend

### Màn hình giao dịch - Transactions List
Danh sách tất cả giao dịch với bộ lọc.

<img src="https://raw.githubusercontent.com/phatnguyen0234/expense-tracker-flutter-java/main/screenshots/03_transactions_screen.png" alt="Transactions Screen" width="300"/>

**Đặc điểm:**
- 📊 Hiển thị tất cả giao dịch (thu/chi)
- 🔽 Lọc theo tháng
- 🏷️ Lọc theo loại (tất cả/thu nhập/chi tiêu)
- ➕ Nút thêm giao dịch (FAB)
- 🎯 Click để sửa/xóa giao dịch

### Màn hình thêm giao dịch - Add Transaction
Dialog thêm giao dịch chi tiết.

<img src="https://raw.githubusercontent.com/phatnguyen0234/expense-tracker-flutter-java/main/screenshots/04_add_transaction.png" alt="Add Transaction" width="300"/>

**Đặc điểm:**
- 💰 Nhập số tiền
- 🏷️ Chọn loại (Thu nhập/Chi tiêu)
- 📅 Chọn ngày (Date Picker)
- ⏰ Chọn giờ (Time Picker)
- 💬 Ghi chú chi tiêu
- 💾 Lưu/Hủy

### Màn hình dashboard - Statistics
Thống kê chi tiêu theo danh mục.

<img src="https://raw.githubusercontent.com/phatnguyen0234/expense-tracker-flutter-java/main/screenshots/05_dashboard_screen.png" alt="Dashboard Screen" width="300"/>

**Đặc điểm:**
- 💚 Thẻ thu nhập (xanh)
- ❤️ Thẻ chi tiêu (đỏ)
- 🔵 Thẻ cân bằng (xanh dương)
- 📊 Biểu đồ chi tiêu theo danh mục
- 💹 Biểu đồ thu nhập theo danh mục
- 📈 Phần trăm chi tiêu

### Màn hình quản lý danh mục - Categories
Quản lý các danh mục chi tiêu.

<img src="https://raw.githubusercontent.com/phatnguyen0234/expense-tracker-flutter-java/main/screenshots/06_categories_screen.png" alt="Categories Screen" width="300"/>

**Đặc điểm:**
- 📂 Danh sách danh mục
- 🏷️ Loại: Chi tiêu/Thu nhập
- ✏️ Nút chỉnh sửa
- 🗑️ Nút xóa
- ➕ Nút thêm danh mục mới

### Màn hình thêm danh mục - Add Category
Dialog thêm/sửa danh mục.

<img src="https://raw.githubusercontent.com/phatnguyen0234/expense-tracker-flutter-java/main/screenshots/07_add_category.png" alt="Add Category" width="300"/>

**Đặc điểm:**
- 📝 Nhập tên danh mục
- 🏷️ Chọn loại (Chi tiêu/Thu nhập)
- 💾 Lưu/Hủy

## 🎨 Design System

### Màu sắc
| Thành phần | Hex Code | Sử dụng |
|-----------|----------|--------|
| Primary | `#5B7DFF` | Header, Button, Active |
| Primary Dark | `#3E5BDF` | Gradient, Hover |
| Success | `#4CAF50` | Income, Positive |
| Error | `#F44336` | Expense, Delete |
| Background | `#F8F9FB` | App background |
| Surface | `#FFFFFF` | Cards, Dialog |

### Typography
- **Font**: Google Fonts - Inter
- **Headline**: 22px Bold
- **Title**: 18px SemiBold  
- **Body**: 14px Regular
- **Caption**: 12px Regular

## 🚀 Cài Đặt & Chạy

### Backend (Spring Boot)

**Yêu cầu:**
- Java 17+
- Docker & Docker Compose
- Maven

**Bước 1: Clone & setup**
```bash
cd backend/expense-backend
cp .env.example .env
```

**Bước 2: Chạy với Docker**
```bash
docker-compose up -d
```

Ứng dụng sẽ chạy tại `http://localhost:8080`

**Database:**
- PostgreSQL chạy trên port `5432`
- Username: `postgres` / Password: `123456`
- Database: `expense`

### Mobile (Flutter)

**Yêu cầu:**
- Flutter 3.24.3+
- Dart 3.5.3+

**Bước 1: Setup environment**
```bash
cd mobile
cp .env.example .env

# Edit .env với server URL của bạn
# API_BASE_URL=http://localhost:8080/api/v1
```

**Bước 2: Cài dependencies**
```bash
flutter pub get
```

**Bước 3: Chạy app**
```bash
# Web (localhost:8888)
flutter run -d chrome

# Android/iOS
flutter run
```

## 📱 Hướng Dẫn Sử Dụng

### 1. Đăng Ký & Đăng Nhập
- Tạo tài khoản mới với email & password
- Đăng nhập với thông tin đã đăng ký
- Token JWT tự động lưu trong Secure Storage

### 2. Quản Lý Giao Dịch
- **Thêm giao dịch**: Nhấn nút `+` → Chọn danh mục → Nhập số tiền → Chọn ngày/giờ → Lưu
- **Sửa giao dịch**: Nhấn vào giao dịch trong danh sách
- **Xóa giao dịch**: Nhấn nút Xóa trong dialog chỉnh sửa
- **Lọc**: Sử dụng dropdown tháng & loại

### 3. Quản Lý Danh Mục
- **Thêm danh mục**: Home → Manage Categories → `+`
- **Sửa danh mục**: Nhấn nút Edit
- **Xóa danh mục**: Nhấn nút Delete (xác nhận trước)
- **Lọc theo loại**: Chi tiêu / Thu nhập

### 4. Xem Thống Kê
- Home → Dashboard
- Xem tổng thu/chi & cân bằng
- Phân tích chi tiêu/thu nhập theo danh mục dưới dạng progress bar
- Pull-to-refresh để cập nhật

## 🔌 API Endpoints

### Authentication
```
POST   /auth/register              # Đăng ký
POST   /auth/login                 # Đăng nhập
GET    /auth/me                    # Thông tin user
```

### Categories
```
GET    /categories?type=EXPENSE    # Danh sách danh mục
POST   /categories                 # Tạo danh mục
PUT    /categories/{id}            # Cập nhật danh mục
DELETE /categories/{id}            # Xóa danh mục
```

### Transactions
```
GET    /transactions?month=2026-03&type=EXPENSE
POST   /transactions
PUT    /transactions/{id}
DELETE /transactions/{id}
```

### Statistics
```
GET    /stats/monthly?month=2026-03
GET    /stats/by-category?month=2026-03&type=EXPENSE
```

**Chi tiết**: Xem [API_SPEC.md](./docs/API_SPEC.md)

## 📊 Postman Collection

Sử dụng file Postman để test API:

1. Import file: `docs/Expense_Tracker.postman_collection.json` vào Postman
2. Thiết lập environment variables:
   ```json
   {
     "base_url": "http://localhost:8080/api/v1",
     "token": "{{token từ login response}}"
   }
   ```
3. Test các endpoints

## 📝 Thiết Kế Database

### Users Table
```sql
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  email VARCHAR(255) UNIQUE NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  full_name VARCHAR(255),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### Categories Table
```sql
CREATE TABLE categories (
  id SERIAL PRIMARY KEY,
  user_id INT REFERENCES users(id),
  name VARCHAR(100) NOT NULL,
  type VARCHAR(20) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### Transactions Table
```sql
CREATE TABLE transactions (
  id SERIAL PRIMARY KEY,
  user_id INT REFERENCES users(id),
  category_id INT REFERENCES categories(id),
  amount DECIMAL(18,2) NOT NULL,
  type VARCHAR(20) NOT NULL,
  txn_date TIMESTAMP NOT NULL,
  note TEXT,
  payment_method VARCHAR(50),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

## 🎨 Giao Diện & UX

### Color Scheme
- Primary: Blue (`#1976D2`)
- Success: Green (`#4CAF50`)
- Error: Red (`#F44336`)
- Warning: Orange (`#FF9800`)
- Backgrounds: Gradient (pastel colors)

### Screens
1. **Login/Register**: Form input với validation
2. **Home**: Menu cards hiển thị các chức năng chính
3. **Transactions**: List + filter + add/edit/delete
4. **Categories**: Management screen
5. **Dashboard**: Summary cards + statistics

## 🛠️ Tech Stack

### Backend
- **Framework**: Spring Boot 3.2.0
- **Database**: PostgreSQL 15
- **Authentication**: JWT (jjwt)
- **ORM**: Spring Data JPA + Hibernate
- **Server**: Tomcat
- **Container**: Docker

### Mobile
- **Framework**: Flutter 3.24.3
- **Language**: Dart 3.5.3
- **State Management**: setState (simple) / Provider (optional)
- **HTTP Client**: Dio 5.9.1
- **Storage**: flutter_secure_storage 10.0.0
- **Icons**: Material Icons

## 🧪 Testing

### Backend
```bash
cd backend/expense-backend
mvn test
```

### Mobile
```bash
cd mobile
flutter test
```

## 📦 Deployment

### Docker Deployment
```bash
# Build image
docker build -t expense-tracker-backend .

# Run container
docker run -p 8080:8080 --env-file .env expense-tracker-backend
```

### Docker Compose
```bash
docker-compose up -d
```

## ⚠️ Error Handling

Ứng dụng xử lý các lỗi sau:

| Error | Status | Xử lý |
|-------|--------|-------|
| Không xác thực | 401 | Redirect to login |
| Không có quyền | 403 | Show error dialog |
| Resource not found | 404 | Show empty state |
| Validation failed | 400 | Hiển thị lỗi field |
| Server error | 500 | Retry + error message |
| Network error | — | Show retry button |

## 🤝 Contribution

Hãy fork & tạo pull request để contribute!

## 📄 License

MIT License - xem [LICENSE](LICENSE)

## 👨‍💻 Author

Created by: **Phat** (Development Team)

---

## 📞 Support

Để báo lỗi hoặc đề xuất: Mở issue trên GitHub

## 🎓 Learning Path

Dự án này được xây dựng để học:
- ✅ Full-stack development (Flutter + Spring Boot)
- ✅ REST API design
- ✅ Database design
- ✅ Authentication & Security
- ✅ Modern UI/UX
- ✅ Docker & Deployment

---

**Happy coding! 🚀**


1) Phạm vi MVP 
MVP trong 2 tuần:
  Auth: Register / Login (JWT)
  Category (Loại chi tiêu): CRUD
  Transaction (Khoản thu/chi): CRUD
  Lọc: theo tháng, theo loại (expense/income), theo category
  Dashboard: tổng chi, tổng thu, số dư tháng + top category
  Xuất dữ liệu: (optional) CSV đơn giản
Optional:
  Budget theo tháng + cảnh báo vượt ngân sách
  Biểu đồ (pie theo category, bar theo ngày)
  Offline cache nhẹ (Hive)

2) Data model + ERD 
Bảng chính
Users
  id (UUID/Long)
  email (unique)
  password_hash
  full_name
  created_at

Categories
  id
  user_id (FK)
  name
  type: EXPENSE | INCOME

Transactions
  id
  user_id (FK)
  category_id (FK)
  amount (decimal)
  type: EXPENSE | INCOME
  txn_date (date/time)
  note (text)
  payment_method: CASH | BANK | EWALLET | OTHER 
  created_at, updated_at

Quan hệ
  User 1—N Category
  User 1—N Transaction
  Category 1—N Transaction


3) API spec (đủ để làm app)
Auth
  POST /api/v1/auth/register
  POST /api/v1/auth/login
  GET /api/v1/auth/me

Category
  GET /api/v1/categories?type=EXPENSE
  POST /api/v1/categories
  PUT /api/v1/categories/{id}
  DELETE /api/v1/categories/{id}

Transaction
  GET /api/v1/transactions?month=2025-12&type=EXPENSE&categoryId=&q=&page=0&size=20&sort=txnDate,desc
  POST /api/v1/transactions
  PUT /api/v1/transactions/{id}
  DELETE /api/v1/transactions/{id}

Dashboard / Statistics
  GET /api/v1/stats/monthly?month=2025-12                      trả về: totalIncome, totalExpense, balance
  GET /api/v1/stats/by-category?month=2025-12&type=EXPENSE     trả về list: {categoryId, categoryName, totalAmount, percent}

Response chuẩn hoá
  success: { "data": ..., "meta": ... }
  error: { "error": { "code": "...", "message": "...", "details": [...] } }

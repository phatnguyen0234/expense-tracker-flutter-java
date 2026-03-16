# API Specification - Expense Tracker

## Base URL

```
http://localhost:8080/api/v1
```

## Authentication

All endpoints (except `/auth/register` and `/auth/login`) require JWT token in header:

```
Authorization: Bearer <token>
```

## Response Format

### Success Response
```json
{
  "data": { /* response data */ },
  "meta": { /* pagination info if applicable */ },
  "message": "Success"
}
```

### Error Response
```json
{
  "error": {
    "code": "ERROR_CODE",
    "message": "Error description",
    "details": [ /* detailed errors if applicable */ ]
  }
}
```

## Status Codes

- `200 OK` - Request successful
- `201 Created` - Resource created
- `204 No Content` - Resource deleted
- `400 Bad Request` - Invalid input
- `401 Unauthorized` - Missing/invalid token
- `403 Forbidden` - No permission
- `404 Not Found` - Resource not found
- `409 Conflict` - Resource already exists
- `422 Unprocessable Entity` - Validation error
- `500 Internal Server Error` - Server error

---

## Endpoints

### Authentication

#### Register
```
POST /auth/register
Content-Type: application/json

{
  "email": "user@example.com",
  "password": "SecurePass123!",
  "fullName": "John Doe"
}

Response (201):
{
  "data": {
    "id": 1,
    "email": "user@example.com",
    "fullName": "John Doe"
  },
  "message": "Register successful"
}
```

#### Login
```
POST /auth/login
Content-Type: application/json

{
  "email": "user@example.com",
  "password": "SecurePass123!"
}

Response (200):
{
  "data": {
    "id": 1,
    "email": "user@example.com",
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
  },
  "message": "Login successful"
}
```

#### Get Current User
```
GET /auth/me
Authorization: Bearer <token>

Response (200):
{
  "data": {
    "id": 1,
    "email": "user@example.com",
    "fullName": "John Doe"
  }
}
```

---

### Categories

#### List Categories
```
GET /categories?type=EXPENSE
Authorization: Bearer <token>

Query Parameters:
  type (optional): INCOME | EXPENSE

Response (200):
{
  "data": [
    {
      "id": 1,
      "name": "Food",
      "type": "EXPENSE"
    },
    {
      "id": 2,
      "name": "Salary",
      "type": "INCOME"
    }
  ]
}
```

#### Create Category
```
POST /categories
Authorization: Bearer <token>
Content-Type: application/json

{
  "name": "Entertainment",
  "type": "EXPENSE"
}

Response (201):
{
  "data": {
    "id": 3,
    "name": "Entertainment",
    "type": "EXPENSE"
  }
}
```

#### Update Category
```
PUT /categories/{id}
Authorization: Bearer <token>
Content-Type: application/json

{
  "name": "Movies & Entertainment",
  "type": "EXPENSE"
}

Response (200):
{
  "data": {
    "id": 3,
    "name": "Movies & Entertainment",
    "type": "EXPENSE"
  }
}
```

#### Delete Category
```
DELETE /categories/{id}
Authorization: Bearer <token>

Response (204): No Content
```

---

### Transactions

#### List Transactions
```
GET /transactions?month=2026-03&type=EXPENSE&categoryId=1&page=0&size=20
Authorization: Bearer <token>

Query Parameters:
  month (optional): YYYY-MM format (e.g., 2026-03)
  type (optional): INCOME | EXPENSE
  categoryId (optional): Filter by category
  page (optional, default: 0): Page number
  size (optional, default: 20): Items per page

Response (200):
{
  "data": [
    {
      "id": 1,
      "categoryId": 1,
      "categoryName": "Food",
      "amount": 50000,
      "type": "EXPENSE",
      "txnDate": "2026-03-16T10:30:00",
      "note": "Lunch",
      "paymentMethod": "CASH"
    }
  ],
  "meta": {
    "total": 15,
    "page": 0,
    "size": 20
  }
}
```

#### Create Transaction
```
POST /transactions
Authorization: Bearer <token>
Content-Type: application/json

{
  "categoryId": 1,
  "amount": 50000,
  "type": "EXPENSE",
  "txnDate": "2026-03-16T10:30:00",
  "note": "Lunch with friends",
  "paymentMethod": "CASH"
}

Response (201):
{
  "data": {
    "id": 1,
    "categoryId": 1,
    "categoryName": "Food",
    "amount": 50000,
    "type": "EXPENSE",
    "txnDate": "2026-03-16T10:30:00",
    "note": "Lunch with friends",
    "paymentMethod": "CASH"
  }
}

Validation Rules:
  - amount > 0
  - categoryId must exist
  - type must be INCOME or EXPENSE
  - txnDate must be valid ISO 8601 datetime
  - paymentMethod: CASH, BANK, EWALLET, OTHER
```

#### Update Transaction
```
PUT /transactions/{id}
Authorization: Bearer <token>
Content-Type: application/json

{
  "categoryId": 1,
  "amount": 75000,
  "type": "EXPENSE",
  "txnDate": "2026-03-16T11:00:00",
  "note": "Updated lunch",
  "paymentMethod": "BANK"
}

Response (200):
{
  "data": { /* updated transaction */ }
}
```

#### Delete Transaction
```
DELETE /transactions/{id}
Authorization: Bearer <token>

Response (204): No Content
```

---

### Statistics

#### Monthly Summary
```
GET /stats/monthly?month=2026-03
Authorization: Bearer <token>

Query Parameters:
  month (optional): YYYY-MM format (defaults to current month)

Response (200):
{
  "data": {
    "month": "2026-03",
    "totalIncome": 10000000,
    "totalExpense": 2500000,
    "balance": 7500000
  }
}
```

#### By Category Breakdown
```
GET /stats/by-category?month=2026-03&type=EXPENSE
Authorization: Bearer <token>

Query Parameters:
  month (optional): YYYY-MM format
  type (optional): INCOME | EXPENSE

Response (200):
{
  "data": [
    {
      "categoryId": 1,
      "categoryName": "Food",
      "totalAmount": 500000,
      "percent": 20.0
    },
    {
      "categoryId": 4,
      "categoryName": "Transport",
      "totalAmount": 1000000,
      "percent": 40.0
    },
    {
      "categoryId": 5,
      "categoryName": "Utilities",
      "totalAmount": 1000000,
      "percent": 40.0
    }
  ]
}
```

---

## Data Types & Formats

### DateTime
ISO 8601 format with UTC timezone:
```
2026-03-16T10:30:00
2026-03-16T10:30:00Z
2026-03-16T10:30:00+07:00
```

### Money/Amount
- Type: Long/BigDecimal
- In VND (Vietnamese Dong)
- No decimal places in response
- Example: 50000 (50,000 VND)

### Transaction Types
- `INCOME` - Thu nhập
- `EXPENSE` - Chi tiêu

### Payment Methods
- `CASH` - Tiền mặt
- `BANK` - Ngân hàng
- `EWALLET` - Ví điện tử
- `OTHER` - Khác

### Category Types
- `INCOME` - Danh mục thu nhập
- `EXPENSE` - Danh mục chi tiêu

---

## Error Codes

| Code | HTTP | Description |
|------|------|-------------|
| VALIDATION_ERROR | 400 | Input validation failed |
| UNAUTHORIZED | 401 | Missing or invalid token |
| FORBIDDEN | 403 | No permission to access |
| NOT_FOUND | 404 | Resource not found |
| DUPLICATE_EMAIL | 409 | Email already registered |
| DUPLICATE_CATEGORY | 409 | Category name already exists |
| INVALID_AMOUNT | 400 | Amount must be positive |
| INTERNAL_ERROR | 500 | Server error |

---

## Rate Limiting

Currently no rate limiting. May be added in future versions.

## Pagination

For endpoints that support pagination:
- Default page size: 20
- Max page size: 100
- Pages are 0-indexed

```json
{
  "data": [ /* items */ ],
  "meta": {
    "total": 100,      // Total items
    "page": 0,         // Current page
    "size": 20         // Items per page
  }
}
```

---

## Examples

### Full Workflow Example

1. **Register**
```bash
curl -X POST http://localhost:8080/api/v1/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "email": "user@example.com",
    "password": "Pass@123",
    "fullName": "John Doe"
  }'
```

2. **Login**
```bash
curl -X POST http://localhost:8080/api/v1/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "user@example.com",
    "password": "Pass@123"
  }'
# Returns: { "data": { "token": "..." } }
```

3. **Create Category**
```bash
curl -X POST http://localhost:8080/api/v1/categories \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{ "name": "Food", "type": "EXPENSE" }'
```

4. **Add Transaction**
```bash
curl -X POST http://localhost:8080/api/v1/transactions \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{
    "categoryId": 1,
    "amount": 50000,
    "type": "EXPENSE",
    "txnDate": "2026-03-16T10:30:00",
    "note": "Lunch",
    "paymentMethod": "CASH"
  }'
```

5. **View Stats**
```bash
curl -X GET "http://localhost:8080/api/v1/stats/monthly?month=2026-03" \
  -H "Authorization: Bearer <token>"
```

---

## Version History

- **v1.0** (2026-03-16) - Initial release (MVP)
  - Auth, Categories, Transactions, Stats

---

For more details, see [POSTMAN_SWAGGER_GUIDE.md](./POSTMAN_SWAGGER_GUIDE.md)


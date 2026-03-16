# API Documentation - Postman & Swagger

## 1. Postman Setup

### Import Collection

1. **Download Postman**: https://www.postman.com/downloads/
2. **Import Collection**:
   - Tạo workspace mới: `Expense Tracker`
   - Click `Import` → Chọn `Postman_Collection.json`
   
### Environment Configuration

**Environment Variables** (tạo file `.json`):

```json
{
  "name": "Local Development",
  "values": [
    {
      "key": "base_url",
      "value": "http://localhost:8080/api/v1",
      "enabled": true
    },
    {
      "key": "token",
      "value": "",
      "enabled": true
    },
    {
      "key": "user_email",
      "value": "test@example.com",
      "enabled": true
    },
    {
      "key": "user_password",
      "value": "password123",
      "enabled": true
    }
  ]
}
```

### Auth Flow

**1. Register**
```
POST {{base_url}}/auth/register
Body (JSON):
{
  "email": "{{user_email}}",
  "password": "{{user_password}}",
  "fullName": "Test User"
}
```

**2. Login** (Automatic token extraction)
```
POST {{base_url}}/auth/login
Body (JSON):
{
  "email": "{{user_email}}",
  "password": "{{user_password}}"
}

Tests tab:
var responseData = pm.response.json();
pm.environment.set("token", responseData.data.token);
```

**3. Use Token** (Automatic header)
```
All requests include:
Headers:
  Authorization: Bearer {{token}}
```

## 2. Postman Collection Requests

### Authentication

#### Register
```
POST /auth/register
Body:
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
Body:
{
  "email": "user@example.com",
  "password": "SecurePass123!"
}

Response (200):
{
  "data": {
    "id": 1,
    "email": "user@example.com",
    "token": "eyJhbGc..."
  },
  "message": "Login successful"
}
```

#### Get Profile
```
GET /auth/me
Headers:
  Authorization: Bearer {{token}}

Response (200):
{
  "data": {
    "id": 1,
    "email": "user@example.com",
    "fullName": "John Doe"
  }
}
```

### Categories

#### List Categories
```
GET /categories?type=EXPENSE
Headers:
  Authorization: Bearer {{token}}

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
Headers:
  Authorization: Bearer {{token}}
Body (JSON):
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
PUT /categories/3
Headers:
  Authorization: Bearer {{token}}
Body (JSON):
{
  "name": "Movies",
  "type": "EXPENSE"
}

Response (200):
{
  "data": {
    "id": 3,
    "name": "Movies",
    "type": "EXPENSE"
  }
}
```

#### Delete Category
```
DELETE /categories/3
Headers:
  Authorization: Bearer {{token}}

Response (204): No content
```

### Transactions

#### List Transactions
```
GET /transactions?month=2026-03&type=EXPENSE
Headers:
  Authorization: Bearer {{token}}

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
    "total": 1,
    "page": 0
  }
}
```

#### Create Transaction
```
POST /transactions
Headers:
  Authorization: Bearer {{token}}
Body (JSON):
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
```

#### Update Transaction
```
PUT /transactions/1
Headers:
  Authorization: Bearer {{token}}
Body (JSON):
{
  "categoryId": 1,
  "amount": 75000,
  "type": "EXPENSE",
  "txnDate": "2026-03-16T10:30:00",
  "note": "Updated lunch",
  "paymentMethod": "BANK"
}

Response (200):
{
  "data": { ... }
}
```

#### Delete Transaction
```
DELETE /transactions/1
Headers:
  Authorization: Bearer {{token}}

Response (204): No content
```

### Statistics

#### Monthly Stats
```
GET /stats/monthly?month=2026-03
Headers:
  Authorization: Bearer {{token}}

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

#### By Category
```
GET /stats/by-category?month=2026-03&type=EXPENSE
Headers:
  Authorization: Bearer {{token}}

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
      "categoryId": 2,
      "categoryName": "Transport",
      "totalAmount": 1000000,
      "percent": 40.0
    }
  ]
}
```

## 3. Swagger/OpenAPI (If Implemented)

### Enable Swagger in Spring Boot

**Add Dependency** (pom.xml):
```xml
<dependency>
    <groupId>org.springdoc</groupId>
    <artifactId>springdoc-openapi-starter-webmvc-ui</artifactId>
    <version>2.0.2</version>
</dependency>
```

### Access Swagger UI
```
Local: http://localhost:8080/swagger-ui.html
API Docs: http://localhost:8080/v3/api-docs
```

### Swagger Annotations

```java
@RestController
@RequestMapping("/api/v1/transactions")
public class TransactionController {
  
  @GetMapping
  @Operation(summary = "Get all transactions", description = "Retrieve paginated transactions")
  @ApiResponse(responseCode = "200", description = "Success")
  @ApiResponse(responseCode = "401", description = "Unauthorized")
  public ResponseEntity<?> getTransactions(
    @RequestParam(required = false) String month,
    @RequestParam(required = false) String type
  ) {
    // ...
  }
}
```

## 4. Testing Workflow

### Step-by-Step Test

1. **Create account**
   - POST `/auth/register` → Save credentials

2. **Login**
   - POST `/auth/login` → Copy token to `{{token}}`

3. **Create categories**
   - POST `/categories` (Food) × 3-4 items

4. **Add transactions**
   - POST `/transactions` × 5-10 items

5. **Filter & view**
   - GET `/transactions?month=2026-03`
   - GET `/transactions?type=EXPENSE`

6. **View stats**
   - GET `/stats/monthly`
   - GET `/stats/by-category`

7. **Update & delete**
   - PUT `/transactions/1` (modify)
   - DELETE `/transactions/1` (remove)

## 5. Error Handling Tests

### Test Error Responses

| Endpoint | Input | Expected Status |
|----------|-------|-----------------|
| Register | Email taken | 409 Conflict |
| Login | Wrong password | 401 Unauthorized |
| Create Txn | No category | 400 Bad Request |
| Create Txn | Negative amount | 400 Bad Request |
| Get Txn | Invalid ID | 404 Not Found |
| Any | No token | 401 Unauthorized |
| Any | Invalid token | 401 Unauthorized |

---

## Notes

- ✅ All requests require `Authorization` header (except Register/Login)
- ✅ Token valid for 24 hours (can be configured)
- ✅ Dates in ISO 8601 format: `2026-03-16T10:30:00`
- ✅ Amounts in VND (no decimals in response)
- ✅ Use Postman Collections for easy sharing & collaboration


# 🚀 Setup Guide - Expense Tracker

Hướng dẫn chi tiết để setup project trên máy mới.

## Prerequisites

- **Java**: 17+
- **Node/npm**: (optional, for frontend)
- **Docker**: 20.10+
- **Docker Compose**: 1.29+
- **Flutter**: 3.24.3+
- **Dart**: 3.5.3+
- **Git**: 2.30+

---

## Backend Setup (Spring Boot + PostgreSQL)

### 1. Clone & Navigate
```bash
git clone https://github.com/phatnguyen0234/expense-tracker-flutter-java.git
cd expense-tracker/backend/expense-backend
```

### 2. Create Environment File
```bash
# Copy template
cp .env.example .env

# Edit with your values (or keep defaults for local dev)
# Default values in .env.example:
# - DB_HOST=localhost (or expense-db if using Docker)
# - DB_PORT=5432
# - DB_NAME=expense
# - DB_USERNAME=postgres
# - DB_PASSWORD=123456
```

### 3. Start with Docker Compose
```bash
# From backend/expense-backend directory
docker-compose up -d

# This will start:
# - PostgreSQL database on port 5432
# - Spring Boot app on port 8080
```

### 4. Check Status
```bash
# View logs
docker-compose logs -f

# Test API
curl http://localhost:8080/api/v1/auth/me
# Should return 401 (Unauthorized) - normal for unauthenticated request
```

### 5. (Alternative) Run without Docker
```bash
# Install dependencies
mvn clean install

# Create database manually (PostgreSQL must be running)
createdb -U postgres expense

# Run app
mvn spring-boot:run

# App will start on http://localhost:8080
```

---

## Mobile Setup (Flutter)

### 1. Clone & Navigate
```bash
git clone https://github.com/phatnguyen0234/expense-tracker-flutter-java.git
cd expense-tracker/mobile
```

### 2. Create Environment File
```bash
# Copy template
cp .env.example .env

# Edit with your server URL
# For local development:
# API_BASE_URL=http://localhost:8080/api/v1
# 
# For production:
# API_BASE_URL=https://your-api-domain/api/v1
```

### 3. Install Dependencies
```bash
flutter pub get
```

### 4. Run App

**Web (Recommended for testing)**
```bash
flutter run -d chrome

# App opens at http://localhost:8888
```

**Android**
```bash
flutter run -d android

# Requires Android emulator or physical device
```

**iOS**
```bash
flutter run -d ios

# Requires macOS and Xcode
```

---

## Database Setup (Manual)

If not using Docker Compose, setup PostgreSQL manually:

### 1. Create Database
```bash
psql -U postgres
CREATE DATABASE expense;
\c expense
```

### 2. Hibernate will auto-create tables
- On first run, Spring Data JPA creates all tables automatically
- Check `application.yml` for `spring.jpa.hibernate.ddl-auto=create`

### 3. Verify Connection
```bash
# From backend directory
mvn spring-boot:run

# Check logs for: "HHH000476: Hibernate-managed transactions (HMT) were not enabled"
# This is normal and can be ignored
```

---

## Troubleshooting

### ❌ "Connection refused" on port 5432
**Solution**: PostgreSQL not running
```bash
# Start PostgreSQL
docker-compose up -d

# Or manually if installed locally
pg_ctl start
```

### ❌ "Cannot connect to API" in Flutter app
**Solution**: Check .env file
```bash
# Make sure API_BASE_URL is correct
cat mobile/.env

# For Docker:
# API_BASE_URL=http://localhost:8080/api/v1

# For physical device connected to PC:
# API_BASE_URL=http://192.168.x.x:8080/api/v1  (your PC IP)
```

### ❌ "Port 8080 already in use"
**Solution**: Kill existing process
```bash
# Find process on port 8080
lsof -i :8080

# Kill it
kill -9 <PID>
```

### ❌ Flutter build errors
**Solution**: Clean and rebuild
```bash
flutter clean
flutter pub get
flutter run
```

---

## Development Workflow

### 1. Start Backend
```bash
cd backend/expense-backend
docker-compose up -d
```

### 2. Start Mobile
```bash
cd mobile
flutter run -d chrome
```

### 3. Test with Postman
```bash
# Import: docs/Expense_Tracker.postman_collection.json
# Setup environment with:
# - base_url: http://localhost:8080/api/v1
# - token: (from login response)
```

### 4. Check Logs

**Backend**
```bash
docker-compose logs -f app
```

**Mobile**
```bash
flutter logs
```

---

## Production Deployment

### Backend (Docker)
```bash
# Build image
docker build -t expense-tracker-backend:1.0 .

# Push to registry
docker push your-registry/expense-tracker-backend:1.0

# Deploy to server
docker run -d \
  -p 8080:8080 \
  -e DB_HOST=your-db-host \
  -e JWT_SECRET=your-secret \
  your-registry/expense-tracker-backend:1.0
```

### Mobile (APK/IPA)
```bash
# Build APK
flutter build apk --release

# Output: build/app/outputs/flutter-apk/app-release.apk

# Build iOS
flutter build ios --release
```

---

## Security Checklist

- [ ] Change `JWT_SECRET` in .env (min 32 chars)
- [ ] Change `DB_PASSWORD` 
- [ ] Change `CORS_ALLOWED_ORIGINS` for production
- [ ] Enable HTTPS
- [ ] Keep `.env` in .gitignore
- [ ] Never commit secrets
- [ ] Use strong database passwords
- [ ] Enable database backups
- [ ] Monitor API logs for attacks

---

## Common Commands

```bash
# Backend
mvn clean install              # Build backend
mvn test                       # Run tests
docker-compose up -d           # Start services
docker-compose down            # Stop services
docker-compose logs -f app     # View logs

# Mobile
flutter pub get                # Install dependencies
flutter run                    # Run app
flutter build apk --release    # Build APK
flutter clean                  # Clean build
flutter doctor                 # Check setup
```

---

## Support

- 📚 **Docs**: `/docs/API_SPEC.md`, `/docs/DEMO_GUIDE.md`
- 🐛 **Issues**: GitHub Issues
- 💬 **Q&A**: GitHub Discussions
- 📧 **Contact**: Check GitHub profile

---

**Happy coding! 🚀**


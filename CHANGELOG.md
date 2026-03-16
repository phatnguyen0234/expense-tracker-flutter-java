# Changelog - Expense Tracker

All notable changes to this project will be documented in this file.

## [1.0.0] - 2026-03-16 - MVP Release 🎉

### ✨ Features Added

#### Days 9-10: Authentication & Transaction Basics
- [x] JWT-based authentication (Register/Login)
- [x] Secure token storage
- [x] Transaction CRUD operations
- [x] Basic filtering by month & type
- [x] Pagination (removed in Day 13)
- [x] Back navigation buttons

#### Days 11-12: Categories & Linking
- [x] Category CRUD operations
- [x] Category type filtering (Income/Expense)
- [x] Linking transactions to categories
- [x] Dynamic category dropdown in add transaction
- [x] Category management screen with edit/delete

#### Day 13: Dashboard & Statistics
- [x] Summary cards (Income/Expense/Balance)
- [x] Category breakdown with progress bars
- [x] Monthly statistics calculation
- [x] Pull-to-refresh functionality
- [x] Loading indicators
- [x] Empty state handling

#### Day 14: Polish & Documentation
- [x] Comprehensive README.md
- [x] API specification with examples
- [x] Postman & Swagger integration guide
- [x] Error handler utility class
- [x] Demo guide with screenshots
- [x] .env.example files
- [x] Enhanced error states UI

### 🎨 UI/UX Improvements

- [x] Modern gradient backgrounds (blue, purple, orange)
- [x] Card-based layouts instead of lists
- [x] Rounded corners (12px) throughout
- [x] Shadow effects for depth
- [x] Color-coded transactions (green income, red expense)
- [x] Icon badges for visual distinction
- [x] Smooth animations & transitions
- [x] Responsive design

### 🔐 Security

- [x] JWT token-based authentication
- [x] Secure storage for tokens
- [x] CORS configuration
- [x] Input validation
- [x] Password hashing (bcrypt)

### 🛠️ Technical Improvements

- [x] Clean code architecture
- [x] Separation of concerns (services, models)
- [x] Error handling with user-friendly messages
- [x] Loading states for async operations
- [x] Empty state UI components
- [x] Null safety checks
- [x] DateTime picker integration
- [x] Form validation

### 📚 Documentation

- [x] Comprehensive README.md
- [x] API specification (API_SPEC.md)
- [x] Postman collection guide
- [x] Swagger/OpenAPI notes
- [x] Demo walkthrough guide
- [x] Environment configuration examples
- [x] Architecture overview

### 🐛 Bug Fixes & Improvements

- [x] Fixed CORS issues
- [x] Fixed date filter (year-based)
- [x] Improved error messages
- [x] Better null handling
- [x] Transaction time display
- [x] Category deletion confirmation
- [x] Logout confirmation dialog

### 📦 Dependencies

**Backend:**
- Spring Boot 3.2.0
- Spring Security
- JWT (jjwt)
- Spring Data JPA
- PostgreSQL 15
- Docker

**Mobile:**
- Flutter 3.24.3
- Dart 3.5.3
- Dio 5.9.1
- flutter_secure_storage 10.0.0
- Material Design 3

---

## [Future] - Planned Features

### Phase 2 (Optional)
- [ ] Budget tracking & alerts
- [ ] Advanced charts (Bar, Line)
- [ ] Offline sync (Hive)
- [ ] Email reports
- [ ] Push notifications
- [ ] Search transactions
- [ ] Recurring transactions
- [ ] Receipt scanning (OCR)

### Phase 3 (Nice to Have)
- [ ] Multi-currency support
- [ ] Shared wallets
- [ ] Data export (CSV, PDF)
- [ ] Analytics dashboard
- [ ] Goal tracking
- [ ] Bill reminders
- [ ] Mobile app notifications
- [ ] Web dashboard

---

## Deployment Status

✅ **Development**: Ready
✅ **Testing**: Basic testing completed
✅ **Staging**: Can be deployed
❓ **Production**: Needs security audit & performance testing

---

## Known Issues

### None at launch 🎉

---

## Migration Guide

### From v0.x to v1.0.0

1. **Database**: Run migrations (auto-applied by Hibernate)
2. **API**: All endpoints now require JWT token
3. **UI**: Migrated from basic layouts to modern card-based UI
4. **Storage**: Token now stored in secure storage (not shared prefs)

---

## Contributors

- 👨‍💻 **Phat Nguyen** - Lead Developer
- 🎨 Design inspiration from popular finance apps

---

## Support & Issues

- Report bugs: GitHub Issues
- Suggestions: GitHub Discussions
- Documentation: `/docs` folder

---

## License

MIT License - See LICENSE file

---

**Version**: 1.0.0
**Released**: 2026-03-16
**Status**: ✅ MVP Complete & Ready


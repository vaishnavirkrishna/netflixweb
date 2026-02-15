# Netflix Clone — Flutter (Web & Desktop)

A Netflix-style movie browsing application built using **Flutter** for **Web and Desktop**.  
This app uses **The Movie Database (TMDB) API** to fetch and display movie categories like Trending, Top Rated, and Upcoming, with a global search feature.

---

##  Features

-  Browse movies in categories:
  - Trending
  - Top Rated
  - Upcoming
-  Global search with debounce (optimized API calls)
-  Movie detail screen with:
  - Backdrop image
  - Poster image
  - Title
  - Release date
  - Rating
  - Overview
-  Optimized for Web/Desktop (Landscape UI like Netflix)
-  Responsive layout (Mobile / Tablet / Desktop)
-  Hover animations for desktop/web movie cards
-  Smooth horizontal scrolling movie carousels
-  Shimmer loading effects
-  Error handling with safe fallback UI
- ⌨ Keyboard shortcuts:
  - `/` or `Ctrl + F` → Open Search
  - `Esc` → Go Home

---

##  Tech Stack & Packages Used

| Package | Purpose |
|--------|---------|
| `flutter_riverpod` | State management |
| `go_router` | URL-based navigation |
| `http` | API calls |
| `cached_network_image` | Image loading + caching |
| `shimmer` | Loading shimmer UI |
| `flutter_dotenv` | Secure API key storage |
| `responsive_framework` | Responsive UI |
| `window_manager` | Desktop window sizing and setup |
| `mockito` | Unit testing support |

---

##  Project Structure

This project follows a **Feature-Based Clean Architecture style**:
lib/
├── core/
│   ├── constants/     ← API keys, endpoints
│   ├── theme/         ← Netflix dark theme
│   └── utils/         ← Responsive breakpoints
├── data/
│   ├── models/        ← Movie model
│   └── services/      ← TMDB API service
├── providers/         ← Riverpod state
└── features/
    ├── home/          ← Home screen + widgets
    ├── detail/        ← Movie detail screen
    └── search/        ← Search screen
## Running the App

### Web
```bash
flutter run -d chrome
```

### Windows Desktop
```bash
flutter run -d windows
```

### Build for Production
```bash
# Web
flutter build web --release

# Windows
flutter build windows --release
```

## Network Note

TMDB API is geo-restricted in some regions in India.
- **Web**: Uses corsproxy.io to handle CORS and geo-restrictions
- **Desktop**: Uses codetabs.com proxy to handle geo-restrictions
- **Production solution**: A backend proxy server would forward
  requests to TMDB, eliminating the need for third-party proxies

## Running Tests
```bash
# All tests
flutter test

# With coverage
flutter test --coverage
```

## API Key

This project uses TMDB API v3.
Get your free API key at: https://www.themoviedb.org/settings/api
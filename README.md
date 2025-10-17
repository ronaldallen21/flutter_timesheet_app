# Flutter Timesheet App

## Overview

A simple offline **Timesheet app** built with Flutter.  
It allows users to log time against predefined **people** and **tasks**.  
All data is stored locally using **SQLite**.

## Features

- CRUD operations for Time Entries
- Read-only views for People and Tasks
- Filter time entries by Person and Date
- Date and Time pickers with validation
- Provider for state management
- Simple, clean Material Design UI

## Architecture

- **Models:** `Person`, `Task`, `TimeEntry`
- **Providers:** `PeopleProvider`, `TasksProvider`, `TimeEntriesProvider`
- **Services:** `DatabaseService` for SQLite CRUD
- **Screens:** Home, People, Tasks, TimeEntry (Add/Edit)
- **Utils/Widgets:** reusable input fields and date/time formatting

## Getting Started

1. **Install dependencies**:

```bash
flutter clean
flutter pub get
```

2. **Run on Web**:

```bash
flutter run -d chrome
```

3. **Run on Android**:

```bash
flutter run -d android
```

4. **Build APK (debug)**:

```bash
./rebuild.sh
```

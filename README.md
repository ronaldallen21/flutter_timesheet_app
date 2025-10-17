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

### 1. Run and Debug

You can run or debug the app directly in **VS Code**:

- Select the **target device** (Android, Web, or any connected device) in the device dropdown.
- Press **Run** and **Debug**.

VS Code will automatically handle:

- Cleaning the project
- Fetching dependencies (`flutter pub get`)

### 2. Build the Application

To build the app for Android or Web, run:

```bash
./rebuild.sh
```

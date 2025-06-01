# 📚 Flutter Book CRUD App 

A clean and scalable Flutter application that performs **CRUD operations** (Create, Read, Update, Delete) on books via REST API, using **BLoC**, **Dio**, and **Clean Architecture** principles.

---

## 🎯 Objective

Build a Flutter app that interacts with the following API:

**API Endpoint:**  
[http://readbuddy-server.onrender.com/api/books](http://readbuddy-server.onrender.com/api/books)

---

## ✅ Features

1. 📋 **Book Listing**  
   - Fetches book list using `GET` request.  
   - Displays title, author(s), and cover image.

2. ➕ **Add Book**  
   - Form to add a new book using `POST`.

3. ✏️ **Edit Book**  
   - Update existing book details using `PUT/PATCH`.

4. ❌ **Delete Book**  
   - Remove a book using `DELETE`.

---

## 🧱 Architecture Overview

This app follows **Clean Architecture** with 3 layers:

### 1. **Data Layer**
- **Purpose**: Handles API calls and data transformation.
- Components:
  - `models/`: Book model & DTOs
  - `data_sources/`: API services using Dio
  - `repositories/`: Implements domain-level contracts

### 2. **Domain Layer**
- **Purpose**: Business logic & rules.
- Components:
  - `entities/`: Book entity
  - `repositories/`: Abstract repository interface
  - `usecases/`: Create, Read, Update, Delete logic

### 3. **Presentation Layer**
- **Purpose**: UI & user interaction.
- Components:
  - `blocs/`: BLoC, events, and states
  - `screens/`: Book list, add/edit forms
  - `widgets/`: Reusable UI elements

---

## 🛠️ Technologies Used

| Tool | Usage |
|------|-------|
| **Flutter** | UI |
| **Dio** | API networking |
| **flutter_bloc** | State management |
| **Equatable** | BLoC comparison |
| **Form** + `TextFormField` | Validation and user input |

---

## 🖼️ Screenshots

| Book List | Add Book | Edit Book | Delete Confirmation |
|-----------|----------|-----------|----------------------|


![Screenshot_1748747463](https://github.com/user-attachments/assets/d6c84ce7-533d-4266-bb99-d9d2eb47535d)![Screenshot_1748747468](https://github.com/user-attachments/assets/924d88a2-f5d4-42c7-80d2-3ac579e29135)![Screenshot_1748747521](https://github.com/user-attachments/assets/f2b04141-5138-47b4-afce-66effee215ff)![Screenshot_1748747529](https://github.com/user-attachments/assets/795317a1-5b75-4d0c-82b5-12662483640f)






---

## 🔧 Setup Instructions

### 1. Clone the Repository

```bash
git clone https://github.com/your-username/flutter-book-crud.git
cd flutter-book-crud

<div align="center">

# 🛒 SmartCart

### 📱 Shopping List & Tax Calculator

**Group 77**  
**COMP 3097 – Mobile App Development II**  
**George Brown College**

*A modern iOS shopping list application built with SwiftUI and SwiftData.*

</div>

---

## 👥 Team Members

| Name | Student ID |
|------|------------|
| Heemal Syangbo | 101532464 |
| Anudhin Thomas | 101516423 |
| Jeffin Yohannan | 101512594 |

---

## 🚀 Overview

SmartCart is a modern iOS application designed to help users organize shopping items, manage multiple shopping lists, and automatically calculate totals including tax.

The app provides a clean and intuitive interface where users can:
- create shopping lists
- add and manage items
- calculate subtotal, tax, and final total automatically
- save data persistently using SwiftData

---

## ✨ Features

### 📝 Shopping Lists
- Create and manage multiple shopping lists
- View shopping lists in a clean dashboard
- Delete shopping lists with confirmation alerts

### 🛍 Item Management
- Add items with:
  - name
  - price
  - quantity
  - category
- Delete items with confirmation alerts

### 🧮 Smart Calculations
- Automatic subtotal calculation
- Tax calculation (13%)
- Final total displayed instantly

### 💾 Data Persistence
- Built using **SwiftData**
- Lists and items remain saved after app restart

### 🎨 User Interface
- Clean and modern design
- Card-based layout for readability
- Smooth multi-screen navigation
- Consistent spacing and structure

---

## 📲 App Screens

- 🚀 Launch Screen
- 🏠 Home Screen (Shopping Lists)
- 📋 List Detail Screen
- ➕ Add Item Screen

---

## 🛠 Technology Stack

- Swift
- SwiftUI
- SwiftData
- Xcode
- GitHub

---

## 🧠 How It Works

**Create List → Add Items → Calculate → Save → Reopen Anytime**

1. Create a shopping list  
2. Add items with price and quantity  
3. Subtotal is calculated automatically  
4. Tax (13%) is applied  
5. Final total is displayed instantly  
6. Data is saved and persists after reopening the app  

---

## 📂 Project Structure

```text
SmartCart
├── Models
│   ├── ShoppingList.swift
│   └── CartItem.swift
├── Views
│   ├── Launch
│   ├── Home
│   ├── ListDetail
│   └── AddItem
├── Components
│   └── CircleButtonView.swift
└── SmartCartApp.swift

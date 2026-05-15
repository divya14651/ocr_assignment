 OCR Card & Passbook Scanner
1. Project Overview

This Flutter application extracts structured data from physical cards and bank passbooks using OCR technology.

It uses:

Google ML Kit for OCR (text recognition)
Custom regex-based parsing for data extraction

The goal is to convert unstructured scanned text into clean, structured information.

 2. Features
 Card Scanner
Extracts card number
Extracts expiry date (supports formats like 12/25, 12-25, 1225)
Extracts card holder name
 UI Masking

Card number is securely masked in UI:

XXXX XXXX XXXX 1234
 Passbook Scanner
Extracts account number
Extracts IFSC code
Extracts account holder name
Luhn Algorithm Validation
Manual implementation of Luhn Algorithm
Used to verify card number authenticity
Noise Handling

Handles common OCR errors such as:

O → 0
I → 1
Extra spaces and formatting issues

3. Setup & Running Instructions
Step 1: Install Dependencies
flutter pub get
Step 2: Run the Project
flutter run
Step 3: Run Tests
flutter test

4. Testing Details

This project includes unit tests for all major algorithms:
Card Parser Test
Validates regex accuracy for card extraction
 Luhn Validation Test
Ensures card number authenticity using Luhn algorithm
 Passbook Parser Test
Checks correct extraction from noisy OCR text

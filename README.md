Project OverviewThis Flutter application is designed to scan and extract structured data from physical cards and bank passbooks using OCR technology. The project focuses on handling noisy text data and implementing custom parsing logic without using any external parsing libraries.

 Key Features1. Card Scanner   Data Extraction: Automatically extracts Card Number, Expiry Date (supports formats like 12/25, 12-25, 1225), and Card Holder Name.  Security: Implements UI masking for card numbers (e.g., XXXX XXXX XXXX 1234).  Validation: Includes a manual implementation of the Luhn Algorithm to verify card authenticity.  
 
 2. Passbook Scanner   Data Extraction: Extracts Account Holder Name, Account Number, and IFSC Code from scanned documents or uploaded images.  Noise Handling: Cleans OCR misreads (e.g., O vs 0, I vs 1) and handles inconsistent spacing.
  
  Tech Stack & Libraries   Framework: Flutter (Dart)OCR Engine: Google ML Kit (Text Recognition)   Parsing: Custom Regex-based manual parsing (No third-party parsing libraries used).  
  
  Testing Requirements   As per the assignment mandate, unit tests are implemented for:  Card Parser Logic   Passbook Parser Logic   Luhn Validation Algorithm

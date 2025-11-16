# InCollege

## Overview

InCollege is a comprehensive COBOL-based professional networking application developed across 10 epics. It provides a complete social networking system for students and professionals, featuring user authentication, profile management, professional connections, job search, and messaging capabilities.

## Table of Contents

1. [Features](#features)
2. [Installation & Setup](#installation--setup)
3. [Running the Application](#running-the-application)
4. [Preparing Input Files](#preparing-input-files)
5. [Interpreting Output Files](#interpreting-output-files)
6. [Data Files](#data-files)
7. [Testing](#testing)
8. [Troubleshooting](#troubleshooting)

---

## Features

### Epic 1-3: Authentication & Account Management
- User login and account creation
- Password validation (8-12 characters, 1 uppercase, 1 digit, 1 special character)
- Maximum 5 accounts per system
- Username uniqueness enforcement

### Epic 4-6: Profile Management
- Create and edit user profiles (name, university, major, graduation year, about section)
- Add up to 3 work experiences (title, company, dates, description)
- Add up to 3 education entries (degree, university, years)
- View own profile and search for other users
- Profile information displayed with experience and education sections

### Epic 7: Professional Networking
- Send connection requests to other users with optional messages
- View pending connection requests
- Accept or decline connection requests
- View connected users in your network
- Bidirectional connection relationships

### Epic 8-9: Job Search & Applications
- Post job/internship opportunities with full details
- Browse available job listings
- View detailed job information (title, description, employer, location, salary)
- Apply for jobs/internships
- View application history and track total applications
- Jobs identified by unique auto-incremented IDs

### Epic 10: Messaging System
- Send messages to connected users (200 character limit)
- View received messages from connections
- Message validation (user existence, connection status, length)
- Messages stored with timestamps

### Additional Features
- Learn a New Skill module (Programming, Communication, Data Analysis, Leadership)
- Cross-platform compatibility (macOS, Linux, Windows)
- Persistent data storage in fixed-width format files
- Comprehensive input validation and error handling

---

## Installation & Setup

### Requirements
- GNU COBOL 3.0 or higher
- Unix-like environment (macOS, Linux) or Windows with COBOL support
- Docker (optional)

### Compilation

```bash
# Install GNU COBOL
brew install gnu-cobol              # macOS
sudo apt-get install gnucobol       # Ubuntu/Debian

# Compile
cobc -x InCollege.cob -o InCollege

# Initialize data files
touch accounts.dat profiles.dat connections.dat jobs.dat applications.dat messages.dat
```

### Docker Deployment (Optional)

```bash
docker build -t cobol-app .

# Run
docker run --rm -v "$(pwd):/data" \
  -e COB_FILE_PATH="/data" \
  -e INCOLLEGE_INPUT_TXT="/data/InCollege-Input.txt" \
  -e INCOLLEGE_OUTPUT_TXT="/data/InCollege-Output.txt" \
  cobol-app
```

---

## Running the Application

```bash
# Execute
./InCollege < InCollege-Input.txt

# View output
cat InCollege-Output.txt
```

**Important:** Before running tests, clear `applications.dat`:
```bash
rm -f applications.dat && touch applications.dat
```

---

## Preparing Input Files

### Input File Structure

`InCollege-Input.txt` contains one input per line in the exact order the application prompts for them. Each line represents a single user response.

### Menu Navigation Reference

| Menu | Options |
|------|---------|
| **Login** | 1=Log In, 2=Create Account |
| **Main** | 1=Create/Edit Profile, 2=View Profile, 3=Search User, 4=Learn Skill, 5=Pending Connections, 6=View Network, 7=Job Search, 8=Messages, 9=Exit |
| **Job Search** | 1=Post Job, 2=Browse Jobs, 3=View Applications, 4=Back |
| **Messages** | 1=Send Message, 2=View Messages, 3=Back |

### Input Preparation by Functionality

#### Authentication (Epic 1-3)

**Login:**
- Line 1: `1` (Log In)
- Line 2: Username (20 char max)
- Line 3: Password (8-12 chars)

**Create Account:**
- Line 1: `2` (Create Account)
- Line 2: Username (must be unique)
- Line 3: Password (requirements: 8-12 chars, 1 uppercase, 1 digit, 1 special char: !@#$%^&*())

#### Profile Management (Epic 4-6)

**Create/Edit Profile:**
- Choose option `1` from Main Menu
- Enter: First Name (50 char max)
- Enter: Last Name (50 char max)
- Enter: University (100 char max)
- Enter: Major (50 char max)
- Enter: Graduation Year (4 digits, 1900-2100)
- Enter: About (200 char max)

**View Profile:**
- Choose option `2` from Main Menu (displays your profile)

**Search User:**
- Choose option `3` from Main Menu
- Enter: Username to search
- If found, option to send connection request appears

#### Networking (Epic 7)

**Send Connection Request:**
- Search for user (option `3`)
- Choose `1` to send request
- Enter: Optional message (200 char max)

**View Pending Requests:**
- Choose option `5` from Main Menu
- Lists all pending requests with numbers
- Enter: Request number to accept/decline, or `0` to go back
- Choose: `1` to Accept, `2` to Decline

**View Network:**
- Choose option `6` from Main Menu
- Displays all accepted connections

#### Job Search (Epic 8-9)

**Post Job:**
- Choose option `7` from Main Menu (Job Search)
- Choose `1` (Post Job)
- Enter: Job Title (100 char max)
- Enter: Description (200 char max)
- Enter: Employer (100 char max)
- Enter: Location (100 char max)
- Enter: Salary (50 char max, or "none")

**Browse and Apply:**
- Choose option `7` from Main Menu
- Choose `2` (Browse Jobs)
- Enter: Job number to view details, or `0` to return
- When viewing job details:
  - Choose `1` to Apply
  - Choose `2` to go Back to Job List
- After applying, returns to job listings
- Enter `0` to exit browsing

**View Applications:**
- Choose option `7` from Main Menu
- Choose `3` (View Applications)
- Displays all jobs you've applied for with total count

#### Messaging (Epic 10)

**Send Message:**
- Choose option `8` from Main Menu (Messages)
- Choose `1` (Send Message)
- Enter: Recipient username (must be connected)
- Enter: Message content (200 char max)

**View Messages:**
- Choose option `8` from Main Menu
- Choose `2` (View Messages)
- Displays all received messages

#### Learn Skills

**Access Skills:**
- Choose option `4` from Main Menu
- Choose: `1`=Programming, `2`=Communication, `3`=Data Analysis, `4`=Leadership, `5`=Back

### Input File Best Practices

- One input per line, no blank lines mid-sequence
- Ensure trailing newline at end of file
- Use Unix line endings (LF, not CRLF)
- Respect character limits for each field
- Input must match prompt sequence exactly

---

## Interpreting Output Files

Output is written to both console and `InCollege-Output.txt`. Below are the key indicators for each functionality.

### Success Messages

| Operation | Success Indicator |
|-----------|-------------------|
| Login | `You have successfully logged in.` followed by `Welcome, [Username]!` |
| Account Creation | `Account created successfully!` followed by `Welcome, [Username]!` |
| Profile Saved | `Profile saved successfully!` |
| Connection Request Sent | `Connection request sent!` |
| Connection Accepted | `Connection request accepted!` |
| Connection Declined | `Connection request declined.` |
| Job Posted | `Job posted successfully!` |
| Job Application | `Your application for [Title] at [Employer] has been submitted.` |
| Message Sent | `Message sent to [Username] successfully!` |

### Error Messages

| Error Type | Error Message |
|------------|---------------|
| Invalid Login | `Invalid username or password!` |
| Password Invalid | `Password must be 8-12 characters, at least one uppercase letter, one digit, one special character` |
| Username Exists | `Username already exists!` |
| Max Accounts | `Maximum of 5 accounts reached!` |
| Profile Not Found | `Profile not found!` |
| Invalid Year | `Invalid graduation year!` |
| User Not Found | `User not found!` |
| Not Connected | `You can only send messages to users you are connected with!` |
| Message Too Long | `Error: Message exceeds 200 characters. Please shorten your message.` |
| Invalid Job Number | `Invalid job number!` |
| Already Connected | `You are already connected or have a pending request with this user.` |
| Invalid Input | `Invalid input!` or `Invalid choice. Try again.` |

### Output Data Formats

**Profile Display:**
```
--- Profile ---
Name: [First] [Last]
University: [University]
Major: [Major]
Graduation Year: [Year]
About: [About text]
Experience:
  Title: [Title]
  Company: [Company]
  Dates: [Dates]
  Description: [Description]
Education:
  Degree: [Degree]
  University: [University]
  Years: [Years]
-------------------
```

**Job Listings:**
```
--- Available Job Listings ---
1. [Title] at [Employer] ([Location])
2. [Title] at [Employer] ([Location])
-----------------------------
```

**Job Details:**
```
--- Job Details ---
Title: [Job Title]
Description: [Description]
Employer: [Employer]
Location: [Location]
Salary: [Salary]
-------------------
```

**Application Summary:**
```
--- Your Job Applications ---
Application Summary for [Username]
------------------------------
Job Title: [Title]
Employer: [Employer]
Location: [Location]
------------------------------
Total Applications: [Count]
------------------------------
```

**Messages Display:**
```
--- Your Messages ---
From: [Username]
Message: [Content]
---
From: [Username]
Message: [Content]
---
---------------------
```
Note: Timestamps are stored but not displayed in message view.

**Network Display:**
```
--- My Network ---
Connected with: [Username]
Connected with: [Username]
------------------
```

**Pending Connections:**
```
--- Pending Connection Requests ---
1. From: [Username]
   Message: [Optional message]
2. From: [Username]
Enter request number to accept/decline (or 0 to go back):
```

**Empty States:**
- No messages: `No messages received.`
- No applications: `Total Applications: 0`
- No pending requests: `No pending connection requests.`
- No connections: Empty list under `--- My Network ---`

---

## Data Files

All data files use fixed-width record formats with space padding.

### File Specifications

| File | Record Size | Format |
|------|-------------|--------|
| **accounts.dat** | 34 bytes | `[Username:20][Password:12][Length:2]` |
| **profiles.dat** | ~2420 bytes | `[Username:20][FirstName:50][LastName:50][University:100][Major:50][Year:4][About:200][ExpCount:1][3×Experience:450][EduCount:1][3×Education:250]` |
| **connections.dat** | 269 bytes | `[Sender:20][Recipient:20][Status:10][Message:200][Timestamp:19]` |
| **jobs.dat** | 595 bytes | `[JobID:6][Title:100][Description:200][Employer:100][Location:100][Salary:50][Poster:20][Timestamp:19]` |
| **applications.dat** | 341 bytes | `[Username:20][JobID:6][Title:100][Employer:100][Location:100][Timestamp:19]` |
| **messages.dat** | 259 bytes | `[Sender:20][Recipient:20][Content:200][Timestamp:19]` |

**Experience Entry** (450 bytes): Title(100), Company(100), Dates(50), Description(200)

**Education Entry** (250 bytes): Degree(100), University(100), Years(50)

**Connection Status Values:** `PENDING` or `ACCEPTED`

**Timestamp Format:** `YYYYMMDDHHMMSS` (14 digits + 5 spaces = 19 bytes)

---

## Testing

### Test Suite

The project includes 11 input/output file pairs:

- **InCollege-Input.txt / InCollege-Output.txt** - Epic 10 reference sample
- **Test 1-10** - Located in `Epic10-Storyx-Test-Input/` and `Epic10-Storyx-Test-Output/`
  - 3 Positive tests (send message, multiple applications, browse and view)
  - 3 Negative tests (non-existent user, not connected, invalid job number)
  - 4 Edge cases (no messages, no applications, message too long, view without applying)

### Running Tests

**Single Test:**
```bash
rm -f applications.dat && touch applications.dat
cp Epic10-Storyx-Test-Input/InCollege-Input1.txt InCollege-Input.txt
./InCollege
```

**All Tests:**
```bash
for f in Epic10-Storyx-Test-Input/InCollege-Input*.txt; do
    rm -f applications.dat && touch applications.dat
    base=$(basename "$f" .txt | sed 's/InCollege-Input//')
    cp "$f" InCollege-Input.txt
    ./InCollege > "Epic10-Storyx-Test-Output/InCollege-Output${base}.txt" 2>&1
    echo "Test ${base} completed"
done
```

**Verify Output:**
```bash
diff InCollege-Output.txt Epic10-Storyx-Test-Output/InCollege-Output1.txt
```

---

## Troubleshooting

### Common Issues and Solutions

**File not found / Status errors**
```bash
touch accounts.dat profiles.dat connections.dat jobs.dat applications.dat messages.dat
chmod 644 *.dat
```

**Output doesn't match expected**
```bash
rm -f applications.dat && touch applications.dat  # Clear before each test
```

**"User not found" when messaging**
- Verify username spelling (case-sensitive)
- Check connection status is ACCEPTED in `connections.dat`
- Confirm user exists in `accounts.dat`

**Input file not reading correctly**
```bash
dos2unix InCollege-Input.txt     # Fix line endings
sed -i 's/\r$//' InCollege-Input.txt  # Alternative
```

**Compilation errors**
```bash
cobc --version  # Ensure GNU COBOL 3.0+
```

**"Maximum of 5 accounts reached"**
```bash
cat accounts.dat | wc -l              # View count
rm accounts.dat && touch accounts.dat  # Reset (WARNING: deletes all)
```

### Debugging

```bash
# View data files
cat accounts.dat

# Count records
wc -l accounts.dat

# Run with logging
./InCollege < InCollege-Input.txt 2>&1 | tee debug.log

# Compare with reference
diff InCollege-Input.txt Epic10-Storyx-Test-Input/InCollege-Input1.txt
```

---

## Important Notes

1. **Data Persistence:** All `.dat` files persist between runs. Always clear `applications.dat` before tests.

2. **Input Format:** Application reads from `InCollege-Input.txt` only. Each line = one input. No blank lines mid-sequence. Must end with newline.

3. **Output Format:** Written to both console and `InCollege-Output.txt`. Variable-length records (1-500 chars) eliminate trailing spaces.

4. **Connection Requirements:** Messages can only be sent to users with ACCEPTED connection status. Requests must be accepted before messaging.

5. **Validation Rules:**
   - Usernames: Max 20 characters, must be unique
   - Passwords: 8-12 characters, 1 uppercase, 1 digit, 1 special character (!@#$%^&*())
   - Messages: Max 200 characters
   - System: Max 5 user accounts
   - Graduation Year: 1900-2100

6. **Timestamps:** All timestamps use `YYYYMMDDHHMMSS` format (e.g., 20251116120000 = Nov 16, 2025, 12:00 PM)

---

## License

Developed as part of a Software Engineering course curriculum.

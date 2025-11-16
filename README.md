# InCollege - Professional Networking Platform

## Overview

InCollege is a COBOL-based professional networking application that enables students and professionals to connect through job postings, messaging, and profile management. The system implements authentication, user profiles, professional connections, job search capabilities, and an integrated messaging system.

## Table of Contents

1. [Installation & Setup](#installation--setup)
2. [Running the Application](#running-the-application)
3. [Input File Preparation](#input-file-preparation)
4. [Output File Interpretation](#output-file-interpretation)
5. [Data Files Specification](#data-files-specification)
6. [Testing](#testing)
7. [Troubleshooting](#troubleshooting)

---

## Installation & Setup

### Compilation

```bash
# Install GNU COBOL (if not already installed)
brew install gnu-cobol  # macOS
# or
sudo apt-get install gnucobol  # Ubuntu/Debian

# Compile the application
cobc -x InCollege.cob -o InCollege

# Initialize data files
touch accounts.dat profiles.dat connections.dat jobs.dat applications.dat messages.dat
```

### Docker (Optional)

```bash
# Build
docker build -t cobol-app .

# Run (macOS/Linux)
docker run --rm -v "$(pwd):/data" \
  -e COB_FILE_PATH="/data" \
  -e INCOLLEGE_INPUT_TXT="/data/InCollege-Input.txt" \
  -e INCOLLEGE_OUTPUT_TXT="/data/InCollege-Output.txt" \
  cobol-app
```

---

## Running the Application

```bash
# Standard execution
./InCollege < InCollege-Input.txt

# Before running tests, clear applications.dat
rm -f applications.dat && touch applications.dat

# View output
cat InCollege-Output.txt
```

The application reads input from `InCollege-Input.txt` and writes output to both the console and `InCollege-Output.txt`.

---

## Input File Preparation

### Input File Structure

Each line in `InCollege-Input.txt` represents one user input. Lines must appear in the exact order the application prompts for them.

### Menu Reference

**Login Menu:** 1=Log In, 2=Create Account

**Main Menu:** 1=Create/Edit Profile, 2=View Profile, 3=Search User, 4=Learn Skill, 5=Pending Connections, 6=View Network, 7=Job Search, 8=Messages, 9=Exit

**Job Menu:** 1=Post Job, 2=Browse Jobs, 3=View Applications, 4=Back

**Messages Menu:** 1=Send Message, 2=View Messages, 3=Back

### Input Examples by Functionality

#### 1. Login and Exit
```
1
AdminUser
Pass123!
9
```
Line 1: Choose Log In | Line 2: Username | Line 3: Password | Line 4: Exit

#### 2. Create Account
```
2
NewUser
SecureP@ss1
```
**Password Requirements:** 8-12 characters, 1 uppercase, 1 digit, 1 special character (!@#$%^&*())

#### 3. Create/Edit Profile
```
1
AdminUser
Pass123!
1
John
Doe
University of South Florida
Computer Science
2025
Passionate about software development
9
```
After login: Choose Create/Edit Profile → Enter: First Name, Last Name, University, Major, Year (1900-2100), About (max 200 chars)

#### 4. Search User and Send Connection Request
```
1
AdminUser
Pass123!
3
ProfSmith
1
Looking forward to connecting!
9
```
After login: Search User → Enter username → Send Request → Enter optional message (max 200 chars)

#### 5. Accept/Decline Connection Request
```
1
ProfSmith
Pass123!
5
1
1
9
```
View Pending Connections → Select request number → 1=Accept, 2=Decline

#### 6. Post a Job
```
1
AdminUser
Pass123!
7
1
Software Engineer Intern
Develop web applications
TechCorp Inc
Tampa, FL
$25/hour
7
4
9
```
Job Menu → Post Job → Enter: Title (max 100), Description (max 200), Employer (max 100), Location (max 100), Salary (max 50, or "none")

#### 7. Browse Jobs and Apply
```
1
AdminUser
Pass123!
7
2
1
1
0
3
4
9
```
Job Menu → Browse → Select job number → Apply (1) or Back (2) → Enter 0 to return to Job Menu → View Applications

#### 8. Send Message
```
1
AdminUser
Pass123!
8
1
ProfSmith
Thank you for your message!
3
9
```
Messages Menu → Send Message → Recipient username → Message content (max 200 chars)
**Note:** You must be connected (ACCEPTED status) with the recipient.

#### 9. View Messages
```
1
AdminUser
Pass123!
8
2
3
9
```
Messages Menu → View Messages → Back to Main Menu

---

## Output File Interpretation

### Success Indicators

**Login Success:**
```
You have successfully logged in.
Welcome, AdminUser!
```

**Account Created:**
```
Account created successfully!
Welcome, NewUser!
```

**Profile Saved:**
```
Profile saved successfully!
```

**Connection Request Sent:**
```
Connection request sent!
```

**Connection Accepted:**
```
Connection request accepted!
```

**Job Posted:**
```
Job posted successfully!
```

**Job Application:**
```
Your application for [Title] at [Employer] has been submitted.
```

**Message Sent:**
```
Message sent to [Username] successfully!
```

### Error Messages

**Invalid Login:**
```
Invalid username or password!
```

**Password Validation Failed:**
```
Password must be 8-12 characters, at least one uppercase letter, one digit, one special character
```

**Username Exists:**
```
Username already exists!
```

**Maximum Accounts:**
```
Maximum of 5 accounts reached!
```

**User Not Found:**
```
User not found!
```

**Not Connected (for messaging):**
```
You can only send messages to users you are connected with!
```

**Message Too Long:**
```
Error: Message exceeds 200 characters. Please shorten your message.
```

**Invalid Job Number:**
```
Invalid job number!
```

**Already Connected:**
```
You are already connected or have a pending request with this user.
```

### Data Display Formats

**Profile Display:**
```
--- Profile ---
Name: John Doe
University: University of South Florida
Major: Computer Science
Graduation Year: 2025
About: Passionate about software development
-------------------
```

**Job Listings:**
```
--- Available Job Listings ---
1. Software Engineer at TechCorp Inc (Tampa, FL)
2. UX Designer at CreativeStudio (Remote)
-----------------------------
```

**Job Details:**
```
--- Job Details ---
Title: Software Engineer
Description: Develop and maintain applications
Employer: TechCorp Inc
Location: Tampa, FL
Salary: $85,000/year
-------------------
```

**Job Applications Summary:**
```
--- Your Job Applications ---
Application Summary for AdminUser
------------------------------
Job Title: Software Engineer
Employer: TechCorp Inc
Location: Tampa, FL
------------------------------
Total Applications: 2
------------------------------
```

**Messages Display:**
```
--- Your Messages ---
From: ProfSmith
Message: Great work on the project!
---
From: FriendA
Message: Did you see the new internship posting?
---
---------------------
```

**Network Display:**
```
--- My Network ---
Connected with: ProfSmith
Connected with: FriendA
------------------
```

**Pending Connections:**
```
--- Pending Connection Requests ---
1. From: AdminUser
   Message: Looking forward to connecting!
2. From: JohnDoe
Enter request number to accept/decline (or 0 to go back):
```

---

## Data Files Specification

All data files use fixed-width record formats with space padding.

### accounts.dat (34 bytes/record)
```
Format: [Username: 20][Password: 12][Length: 2]
Example: AdminUser           Pass123!    08
```

### profiles.dat (~2420 bytes/record)
```
Format: [Username: 20][FirstName: 50][LastName: 50][University: 100][Major: 50]
        [Year: 4][About: 200][ExpCount: 1][3x Experience: 450 each]
        [EduCount: 1][3x Education: 250 each]
```
Experience: Title(100), Company(100), Dates(50), Description(200)
Education: Degree(100), University(100), Years(50)

### connections.dat (269 bytes/record)
```
Format: [Sender: 20][Recipient: 20][Status: 10][Message: 200][Timestamp: 19]
Status: PENDING or ACCEPTED
Example: AdminUser           ProfSmith           ACCEPTED    ...
```

### jobs.dat (595 bytes/record)
```
Format: [JobID: 6][Title: 100][Description: 200][Employer: 100]
        [Location: 100][Salary: 50][Poster: 20][Timestamp: 19]
Example: 000001Software Engineer    ...
```

### applications.dat (341 bytes/record)
```
Format: [Username: 20][JobID: 6][Title: 100][Employer: 100]
        [Location: 100][Timestamp: 19]
```

### messages.dat (259 bytes/record)
```
Format: [Sender: 20][Recipient: 20][Content: 200][Timestamp: 19]
Timestamp Format: YYYYMMDDHHMMSS (14 digits + 5 spaces padding)
```

---

## Testing

### Test Suite Structure

The project includes 11 input/output pairs:

1. **InCollege-Input.txt / InCollege-Output.txt** - Epic 10 sample (job search and messaging)
2. **Test 1** - Edge: No messages
3. **Test 2** - Edge: No applications
4. **Test 3** - Positive: Send message
5. **Test 4** - Positive: Multiple applications
6. **Test 5** - Negative: Non-existent user
7. **Test 6** - Negative: Not connected
8. **Test 7** - Positive: Browse and view
9. **Test 8** - Negative: Invalid job number
10. **Test 9** - Edge: Message too long
11. **Test 10** - Edge: View without applying

### Running Tests

**Individual Test:**
```bash
rm -f applications.dat && touch applications.dat
cp Epic10-Storyx-Test-Input/InCollege-Input1.txt InCollege-Input.txt
./InCollege
cat InCollege-Output.txt
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

**Compare Outputs:**
```bash
diff InCollege-Output.txt Epic10-Storyx-Test-Output/InCollege-Output1.txt
```

---

## Troubleshooting

### Common Issues

**Issue: File not found / File status errors**
```bash
# Solution: Ensure all data files exist
touch accounts.dat profiles.dat connections.dat jobs.dat applications.dat messages.dat
chmod 644 *.dat
```

**Issue: Output doesn't match expected**
```bash
# Solution: Clear applications.dat before each test
rm -f applications.dat && touch applications.dat
```

**Issue: "User not found" when sending message**
- Verify username spelling (case-sensitive)
- Ensure you're connected with recipient (ACCEPTED status in connections.dat)
- Check that recipient account exists in accounts.dat

**Issue: Input file not read correctly**
```bash
# Solution: Fix line endings (Unix LF, not Windows CRLF)
dos2unix InCollege-Input.txt
# or
sed -i 's/\r$//' InCollege-Input.txt
```

**Issue: Compilation errors with OCCURS**
```bash
# Solution: Ensure GNU COBOL 3.0+
cobc --version
```

**Issue: "Maximum of 5 accounts reached"**
```bash
# Solution: View/reset accounts
cat accounts.dat | wc -l
rm accounts.dat && touch accounts.dat  # WARNING: Deletes all accounts
```

### Debugging Commands

```bash
# View data file contents
cat accounts.dat

# Count records
wc -l accounts.dat

# Run with error logging
./InCollege < InCollege-Input.txt 2>&1 | tee debug.log

# Compare with working example
diff InCollege-Input.txt Epic10-Storyx-Test-Input/InCollege-Input1.txt
```

---

## Project Structure

```
InCollege-Epic9/
├── InCollege.cob                    # COBOL source code
├── InCollege                        # Compiled executable
├── InCollege-Input.txt              # Input file
├── InCollege-Output.txt             # Output file
├── Dockerfile                       # Docker configuration
├── README.md                        # This documentation
├── Roles.txt                        # Team roles
├── Data Files
│   ├── accounts.dat                 # User accounts
│   ├── profiles.dat                 # User profiles
│   ├── connections.dat              # User connections
│   ├── jobs.dat                     # Job postings
│   ├── applications.dat             # Job applications
│   └── messages.dat                 # User messages
├── Epic10-Storyx-Test-Input/        # 10 test input files
│   ├── InCollege-Input1.txt
│   └── ... (through Input10.txt)
├── Epic10-Storyx-Test-Output/       # 10 test output files
│   ├── InCollege-Output1.txt
│   └── ... (through Output10.txt)
└── Epics/                           # Requirement documents
    └── Epic1.pdf through Epic10.pdf
```

---

## Features by Epic

**Epic 1-3:** User authentication, account creation (max 5), password validation (8-12 chars, uppercase, digit, special char)

**Epic 4-6:** Profile management (name, university, major, year, about), experience (3 entries), education (3 entries), profile search

**Epic 7:** Professional networking (send/accept/decline connection requests, view network)

**Epic 8-9:** Job search (post jobs, browse listings, view details, apply, track applications)

**Epic 10:** Messaging system (send to connected users, view messages, 200 char limit, validation)

**Additional:** Learn a New Skill module (4 courses)

---

## Important Notes

1. **Data Persistence:** All `.dat` files persist between runs. Clear `applications.dat` before tests for consistent results.

2. **Input Format:** Application reads exclusively from `InCollege-Input.txt`. Each line = one input. No blank lines mid-sequence.

3. **Output:** Written to both console and `InCollege-Output.txt`. Variable-length records eliminate trailing spaces.

4. **Connections:** Messages only work between ACCEPTED connections. Connection requests must be accepted first.

5. **Validation:** Usernames (20 char max, unique), Passwords (8-12 char requirements), Messages (200 char max), Accounts (5 max)

6. **Timestamps:** Format YYYYMMDDHHMMSS (e.g., 20251116120000 = Nov 16, 2025, 12:00:00 PM)

---

## Quick Reference

```bash
# Essential Commands
cobc -x InCollege.cob -o InCollege          # Compile
./InCollege < InCollege-Input.txt           # Run
cat InCollege-Output.txt                    # View output
rm -f applications.dat && touch applications.dat  # Clear apps
diff Output1.txt Output2.txt                # Compare outputs
```

**Menu Codes:** Login(1=Login,2=Create) | Main(1-9) | Jobs(1=Post,2=Browse,3=Apps,4=Back) | Messages(1=Send,2=View,3=Back)

---

## Support

- **Epic Documents:** See `Epics/` folder for detailed requirements
- **Team Contacts:** Refer to `Roles.txt`
- **Test Examples:** Use `Epic10-Storyx-Test-Input/` for reference

---

## Version

**Current:** Epic 10 (Messaging System)

**Previous:** Epic 9 (Job Applications) | Epic 8 (Job Search) | Epic 7 (Networking) | Epic 4-6 (Profiles) | Epic 1-3 (Authentication)

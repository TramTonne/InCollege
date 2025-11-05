# InCollege — Professional Networking Platform

A COBOL-based professional networking application that allows users to connect, share job opportunities, and communicate with each other.

## 🚀 Features

### User Authentication
- Create new accounts with secure password requirements
- Log in/log out functionality
- Session management

### User Profiles
- Create and edit detailed professional profiles
- Add education history
- Add work experience
- Personal "About Me" section

### Networking
- Send and accept connection requests
- View your network of connections
- Manage pending connection requests
- Search for other users

### Job Board
- Post job/internship opportunities
- Browse available positions
- Apply for jobs
- Track your applications

### Messaging (New in Week 8)
- Send private messages to connections
- Message history and tracking
- Real-time notifications (under development)

## 🖥 Getting Started

### Prerequisites
- Docker
- Git

### Running the Application

#### Windows (PowerShell)
```powershell
docker run --rm -v "${PWD}:/data" `
  -e COB_FILE_PATH="/data" `
  -e INCOLLEGE_INPUT_TXT="/data/InCollege-Input.txt" `
  -e INCOLLEGE_OUTPUT_TXT="/data/InCollege-Output.txt" `
  -e INCOLLEGE_TEST_TXT="/data/InCollege-Test.txt" `
  -e ROLES_TXT="/data/Roles.txt" `
  -e ACCOUNTS_DAT="/data/accounts.dat" `
  -e MESSAGES_DAT="/data/messages.dat" `
  cobol-app
```

#### macOS / Linux
```bash
docker run --rm -v "$(pwd):/data" \
  -e COB_FILE_PATH="/data" \
  -e INCOLLEGE_INPUT_TXT="/data/InCollege-Input.txt" \
  -e INCOLLEGE_OUTPUT_TXT="/data/InCollege-Output.txt" \
  -e INCOLLEGE_TEST_TXT="/data/InCollege-Test.txt" \
  -e ROLES_TXT="/data/Roles.txt" \
  -e ACCOUNTS_DAT="/data/accounts.dat" \
  -e MESSAGES_DAT="/data/messages.dat" \
  cobol-app
```

## 🔧 Configuration

### Environment Variables
- `COB_FILE_PATH`: Path to data directory
- `INCOLLEGE_INPUT_TXT`: Input file path
- `INCOLLEGE_OUTPUT_TXT`: Output file path
- `INCOLLEGE_TEST_TXT`: Test input file path
- `ROLES_TXT`: Team roles file
- `ACCOUNTS_DAT`: User accounts database
- `MESSAGES_DAT`: Messages database

## 🗄️ Data Files

| File | Description |
|------|-------------|
| `accounts.dat` | Stores user account information |
| `profiles.dat` | Stores user profile data |
| `connections.dat` | Manages user connections |
| `jobs.dat` | Job postings |
| `applications.dat` | Job applications |
| `messages.dat` | Private messages between users |

## 🔄 Rebuilding the Docker Image

To rebuild the Docker image (e.g., after code changes):

```bash
docker build --no-cache -t cobol-app .
```

## 🧹 Resetting Data

### Reset All Data (Linux/macOS)
```bash
rm -f accounts.dat profiles.dat connections.dat jobs.dat applications.dat messages.dat
```

### Reset Individual Files (Windows PowerShell)
```powershell
# Reset accounts
ni accounts.dat -Force

# Reset messages
ni messages.dat -Force
```

## 📱 Using the Application

### Creating an Account
1. Select "Create New Account" from the main menu
2. Enter a unique username
3. Create a secure password (8-12 chars, 1 uppercase, 1 digit, 1 special char)

### Sending Messages (New in Week 8)

#### How to Send a Message
1. Log in to your account
2. Select "Messages" from the main menu
3. Choose "Send a New Message"
4. Enter the username of a connection
5. Type your message (max 200 characters)
6. The message will be saved for the recipient

#### Input File Preparation
To test the messaging feature using the input file (`InCollege-Input.txt`), follow this format:

```
[username]          # Your username
[password]          # Your password
6                   # Select Messages from main menu
1                   # Choose "Send a New Message"
[recipient_username] # Username of your connection
[message_content]    # Your message (max 200 chars)
```

**Example Input:**
```
johndoe
Pass123!
6
1
janedoe
Hi Jane, I came across your profile and would like to connect regarding potential collaboration opportunities. Looking forward to your response!
```

**Important Notes:**
- You must be logged in to send messages
- The recipient must be in your connections
- Messages are limited to 200 characters
- All input is case-sensitive
- Each input should be on a new line
- Empty lines in the input file will be treated as empty inputs

#### Output
After sending a message, the system will display a confirmation message in `InCollege-Output.txt` and on the console:
```
Message sent to [recipient_username] successfully!
```

If there's an error (e.g., user not found, not connected, etc.), an appropriate error message will be displayed.

### Job Search
1. Log in to your account
2. Select "Job Search/Internship"
3. Browse available jobs or post a new one
4. Apply for positions that match your interests

## 🧪 Testing

### Running Tests
1. Prepare test input in `InCollege-Test.txt`
2. Run the application
3. Check `InCollege-Output.txt` for results

### Test Cases
- User registration and authentication
- Profile creation and updates
- Connection management
- Job posting and applications
- Messaging between users

## 📝 Notes

- All input is read from `InCollege-Input.txt`
- All output is written to `InCollege-Output.txt` and displayed on screen
- The system enforces secure password policies
- Users must be connected to message each other
- Some features may be marked as "under construction"

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

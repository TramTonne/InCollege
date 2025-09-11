# InCollege — COBOL Application

## 🖥 Running the Application

### Windows (PowerShell)
```powershell
docker run --rm -v "${PWD}:/data" `
  -e COB_FILE_PATH="/data" `
  -e INCOLLEGE_INPUT_TXT="/data/InCollege-Input.txt" `
  -e INCOLLEGE_OUTPUT_TXT="/data/InCollege-Output.txt" `
  -e INCOLLEGE_TEST_TXT="/data/InCollege-Test.txt" `
  -e ROLES_TXT="/data/Roles.txt" `
  -e ACCOUNTS_DAT="/data/accounts.dat" `
  cobol-app
```

### macOS / Linux
```bash
docker run --rm -v "$(pwd):/data"   -e COB_FILE_PATH="/data"   -e INCOLLEGE_INPUT_TXT="/data/InCollege-Input.txt"   -e INCOLLEGE_OUTPUT_TXT="/data/InCollege-Output.txt"   -e INCOLLEGE_TEST_TXT="/data/InCollege-Test.txt"   -e ROLES_TXT="/data/Roles.txt"   -e ACCOUNTS_DAT="/data/accounts.dat"   cobol-app
```

---

## 🔄 Rebuilding the Docker Image

Rebuild the image without cache:
```bash
docker build --no-cache -t cobol-app .
```

---

## 🗑 Resetting the Accounts File

**Linux/macOS:**
```bash
echo "" > accounts.dat
```

**Windows PowerShell:**
```powershell
ni accounts.dat -Force
```

---

## 📂 Files Overview

- **InCollege-Input.txt** — standard program input file  
- **InCollege-Output.txt** — captured program output file  
- **InCollege-Test.txt** — comprehensive test input file (positive, negative, edge cases)  
- **Roles.txt** — team roles for this project  
- **accounts.dat** — persistent file storing user accounts  

---

## 📝 Notes

- All program input is read from `InCollege-Input.txt`.  
- All console output is mirrored to `InCollege-Output.txt`.  
- Use `InCollege-Test.txt` to run automated test scenarios.

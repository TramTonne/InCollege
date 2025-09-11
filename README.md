README — COBOL app

Run (PowerShell):
docker run --rm -v "${PWD}:/data" `
  -e COB_FILE_PATH="/data" `
  -e INCOLLEGE_INPUT_TXT="/data/InCollege-Input.txt" `
  -e INCOLLEGE_OUTPUT_TXT="/data/InCollege-Output.txt" `
  -e INCOLLEGE_TEST_TXT="/data/InCollege-Test.txt" `
  -e ROLES_TXT="/data/Roles.txt" `
  -e ACCOUNTS_DAT="/data/accounts.dat" `
  cobol-app

Rebuild image (no cache):
docker build --no-cache -t cobol-app .

Reset accounts file (PowerShell):

Run (macOS/Linux):
docker run --rm -v "$(pwd):/data"   -e COB_FILE_PATH="/data"   -e INCOLLEGE_INPUT_TXT="/data/InCollege-Input.txt"   -e INCOLLEGE_OUTPUT_TXT="/data/InCollege-Output.txt"   -e INCOLLEGE_TEST_TXT="/data/InCollege-Test.txt"   -e ROLES_TXT="/data/Roles.txt"   -e ACCOUNTS_DAT="/data/accounts.dat"   cobol-app

# InCollege
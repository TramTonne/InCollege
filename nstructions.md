You are editing InCollege.cob.

Goal: Implement ONLY Epic 8 (Week 8) “Basic Messaging System — Part 1 (Send Message)” exactly as specified. Do not add, refactor, or remove anything outside this Epic. Keep prior features (login, profiles, connections, jobs, etc.) untouched.

Important note about the PDF’s SAMPLE OUTPUT: it is a simplified example to highlight how the new “Messages” option and submenu should look. It does NOT include the rest of the program (e.g., Create/Edit Profile, Post a Job). Integrate the new menu into the real program without removing or altering existing options.

Scope / Requirements (from the Epic 8 spec):

1) Menu integration
   - Add a new post-login “Messages” option.
   - Inside it, show a “Messages” submenu with:
     1. “Send a New Message”
     2. “View My Messages” → print “View My Messages is under construction.” for Week 8 only.

2) Send a New Message flow
   - Prompt for the recipient’s username.
   - Users may send messages ONLY to users they are already connected with (use Week-5 connections). Validate this.
   - If the recipient is not a valid connection (or unknown), print the appropriate message and return to the Messages submenu.
   - If valid, prompt for free-form message text (cap safely around 200 chars if needed).

3) Persistence
   - Save every sent message persistently so it survives program restarts.
   - Store at least: Sender username, Recipient username, Message content. (Timestamp is optional, not required.)
   - Use a simple sequential storage consistent with the project’s data-file approach.

4) I/O protocol (must match the course testing harness)
   - All inputs (menu choices, recipient, message text) come from the input file (InCollege-Input.txt).
   - All outputs (prompts, confirmations, errors) must be displayed AND written identically to the output file (InCollege-Output.txt).
   - Reuse the program’s existing input/output routines and formatting so outputs remain consistent with the rest of the app.

5) Programmer implementation details
   - Define a persistent storage for messages (e.g., a new sequential file) with fields for sender, recipient, message.
   - Implement the file I/O to append new messages when sent.
   - Implement a connection-validation routine that checks existing connections (treat A-B and B-A symmetrically, and only allow if accepted/connected per prior weeks).
   - Keep variable names, PIC sizes, and coding style consistent with what’s already in this file.

Acceptance / Done
   - From the logged-in main menu, user can open “Messages” → choose “Send a New Message” → enter a connected recipient → enter message text → message is persisted.
   - Choosing “View My Messages” prints “View My Messages is under construction.” (no retrieval this week).
   - Inputs strictly from file; outputs shown on screen and mirrored identically to the output file.
   - No unrelated behavior changed; minimal diff beyond what’s needed for this Epic.

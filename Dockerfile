FROM ubuntu:22.04

RUN apt-get update && \
    apt-get install -y gnucobol && \
    rm -rf /var/lib/apt/lists/*

# Build once
WORKDIR /work
COPY InCollege.cob .
RUN cobc -x -free -o /usr/local/bin/InCollege InCollege.cob

WORKDIR /data
COPY InCollege-Input.txt .
COPY accounts.dat .
COPY profiles.dat .
COPY connections.dat .
COPY Roles.txt .
ENV COB_FILE_PATH="/data:."

# (These env vars are optional helpers; COBOL uses literal filenames and COB_FILE_PATH)
ENV InCollege_Input_txt="InCollege-Input.txt" \
    InCollege_Output_txt="InCollege-Output.txt" \
    InCollege_Test_txt="InCollege-Test.txt" \
    Roles_txt="Roles.txt" \
    accounts_dat="accounts.dat" \
    profiles_dat="profiles.dat"

ENTRYPOINT ["/usr/local/bin/InCollege"]

# Set up COMP2521 Docker Image on MacOS

Note: these instructions are somewhat bare-bones right now. They should work,
but it'd be nice to have something a little more thorough. Consider making a
pull request if you'd like to help out!

1. Set up Git by running `git --version` in a terminal. If prompted to download
   extra features, accept and wait for the download to complete.

2. Install [Docker Desktop](https://docs.docker.com/desktop/install/mac-install/).

3. Launch a terminal.

4. Download the project by running `git clone https://github.com/COMP2521UNSW/2521-docker-image.git`.
   The image will download to your current terminal directory, so ensure you
   run this in a safe location (to avoid data loss).

5. Run the setup script and follow its prompts. You can run
   `cd 2521-docker-image` then `./scripts/setup`.

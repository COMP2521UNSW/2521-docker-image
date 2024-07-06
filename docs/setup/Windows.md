# Set up COMP2521 Docker Image on Windows

Note: these instructions are somewhat bare-bones right now. They should work,
but it'd be nice to have something a little more thorough. Consider making a
pull request if you'd like to help out!

1. Install [Git](https://git-scm.com/download/win).

    * Ensure that you install the additional command-line tools.
    * Ensure that the tools are added to your PATH.

2. Install [Docker Desktop](https://docs.docker.com/desktop/install/windows-install/).

3. Launch a "Git Bash" terminal.

4. `git clone` the repo.

5. Run the setup script and follow its prompts. From the directory you cloned,
   you can run `./scripts/setup`. You may need to restart your terminal during
   the setup process if the SSH agent wasn't configured correctly.

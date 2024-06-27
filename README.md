# COMP2521 Docker Image

This is an experimental docker image for COMP2521, intended to allow students
to complete their work locally.

Currently testing on Linux, but intending to support MacOS too. May also try
Windows, but that will be painful due to the need to rewrite all the scripts
(or use Git Bash?).

## Setup

1. Install Docker using [these instructions](https://docs.docker.com/get-docker/)
2. `git clone` this repository.
3. Open a terminal and `cd` into the repo.
4. Run `./scripts/2521-setup` to set up the working environment.
5. Restart your shell to get access to the scripts.

After completing setup, the environment can be updated at any time using
`2521-update`. This will update the repository to the latest version, and
rebuild the Docker image.

## Usage

### Starting the environment

Run the `2521-up` command.

### Connecting to the environment (command line)

Run the `2521-sh` command.

### Connecting to the environment (VS Code)

1. Ensure that the environment is started by running `2521-up`.
2. Install the "Dev Containers" extension in VS Code.
3. Choose the `><` "Open a remote window" button in VS Code (found in the
   bottom left).
4. Choose to "Attach to a running container".
5. Select the container whose name contains `cs2521`.

#### Recommended extensions

To get the best editor experience, it is recommended to install a few
extensions:

* `clangd` for C editor support.

### Shutting down the environment

Run the `2521-down` command. It is recommended to shut down the environment
when it is not in use to reduce energy consumption.

### Fetching starter code from CSE

Within the environment, use the `cse-fetch` command alongside the path to the
`.zip` file to download. It will be downloaded and extracted to a directory
named `starter_code` within your current directory.

### Uploading work to CSE

Within the environment, use the `cse-push` command to upload the contents of
the current directory to CSE. It will be placed within
`/home/${ZID}/2521-push/${curr_dir}`.

### Connecting to CSE from the environment

You can start an SSH session by running the `cse` command.

## How it works

### Access to CSE systems

* The `docker-compose.yml` is configured to forward the host system's SSH agent
  to the environment. This means that setting up SSH access within the host
  environment will also grant access within the Docker environment.

* In order to give correct access permissions for the `ssh` directory, the host
  user's `~/.ssh` directory is symlinked to `config/ssh`. At runtime, this is
  added as a Docker volume mounted at `~/.ssh` in the environment.

* In addition, during setup, the user's zID is stored to `home/.zid`. This is
  used to configure the `cse*` commands within the environment.

### Storing work

* A `home` directory is created at the root of this repo during setup.

* This is added to the environment as a Docker volume mounted on their home
  directory.

## Uninstalling

Run `2521-uninstall` and follow its prompts.

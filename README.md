# [COMP2521 Docker Image](https://comp2521unsw.github.io/2521-docker-image/)

This is an experimental docker image for COMP2521, intended to allow students
to complete their work locally.

## Setup

See [the documentation](https://comp2521unsw.github.io/2521-docker-image/setup/).

## Usage

### Starting the environment

Run the `2521-up` command.

### Connecting to the environment (command line)

Run the `2521-sh` command.

### Connecting to the environment (VS Code)

Run the `2521-code` command.

#### Recommended extensions

To get the best editor experience, it is recommended to install a few VS Code
extensions within the container:

* `clangd` for C editor support.

### Shutting down the environment

Run the `2521-down` command. It is recommended to shut down the environment
when it is not in use to reduce energy consumption.

### Updating the environment

Run the `2521-update` command. This will rebuild the image after using Git to
pull changes.

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

* This is added to the environment as a Docker volume mounted as their home
  directory.

## Uninstalling

Run `2521-uninstall` and follow its prompts.

# System Files

This is a simple project that can be opened in your editor to show
all of the various system files that are available on the
system. This is useful for debugging and testing purposes.

## Installation

To install this project:
  - clone the repository
  - cd into the directory
  - run:
```bash
./setup.sh
```

## Adding new files

So, you think there are some files you'd like to see in
here but are missing? No problem! It's simple to add them.

Open the `setup.sh` file and add the file to the list that
makes sense -- or add a new list if it doesn't make sense.

The `setup.sh` file is a simple bash script that can be
run as many times as you like. It will not overwrite any
existing files.

## Cleaning up

If you want to remove all of the files that were created
and start over, you can run the `cleanup.sh` script.

  ```bash
  ./cleanup.sh
  ```

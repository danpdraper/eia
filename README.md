## Installation

### Github

Open a terminal and navigate to your user's home directory:

```
cd $HOME
```

Create the directories in the path `.ssh/github/eia`:

```
mkdir -p .ssh/github/eia
```

Generate a new SSH key pair:

```
ssh-keygen -t ed25519 -C "your_email@example.com"
```

When you are prompted to "Enter a file in which to save the key", provide the following path:

```
$HOME/.ssh/github/eia/id_ed25519
```

Note that the `ssh-keygen` program will not expand the `$HOME` environment variable in the path that you enter, so you will need to replace `$HOME` in the path above with the path to your user's home directory.

When you are prompted to "Enter passphrase", enter a secure passphrase. Retain the passphrase that you entered as you will need to enter it whenever you attempt to authenticate with Github.

Before proceeding, you will need to add the newly-generated key to your Github account. Follow [these](https://docs.github.com/en/github/authenticating-to-github/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account) instructions to do so.

Configure your SSH client to use your newly-generated key whenever interacting with the danpdraper/eia repository on Github:

```
echo -e 'Host github-eia\n  HostName github.com\n  IdentityFile ~/.ssh/github/eia/id_ed25519\n  User git' >> ~/.ssh/config
```

### Virtual Environment

Install the Python package pip on your machine:

```
python3 -m pip install --user --upgrade pip
```

Create a `projects` directory and make that directory the working directory:

```
mkdir projects && cd projects
```

Clone the `eia` package into an `eia` directory:

```
GIT_SSH_COMMAND='ssh -i ~/.ssh/github/eia/id_ed25519' git clone git@github.com:danpdraper/eia.git
```

Enter your passphrase when prompted.

Make the `eia` directory the working directory and create a Python virtual environment therein:

```
cd eia
python3 -m venv env
```

Update the Git remote origin URL to match the `Host` key that you added to `$HOME/.ssh/config`:

```
git remote set-url origin github-eia:danpdraper/eia.git
```

Create a symbolic link from `.git/hooks/pre-push` to `githooks/pre-push`:

```
./githooks/create_symbolic_links.sh
```

Git will invoke the `pre-push` script whenever you attempt to push to Github. The script will execute all of the tests in the `eia` package and, should any of the tests fail, the script will reject the push.

Activate the virtual environment:

```
source env/bin/activate
```

Install the dependencies of the `eia` package:

```
python3 -m pip install -r requirements.txt
```

Install the `eia` package:

```
python3 setup.py develop
```

Verify that everything is working as expected by executing all of the Python tests in the package:

```
python3 -m pytest -vv
```

If all of the tests pass, then you have successfully installed the `eia` package on your machine and you are ready to start developing.

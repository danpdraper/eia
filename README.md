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

## Legislation Preprocessing

### Preparing Legislation for Preprocessing

Open [this](https://docs.google.com/spreadsheets/d/1pfEgen0jwUhYeVDrFlTAHWbcuDYfnDdxVGClWuU4X3Q) Google sheet in your browser and navigate to the 'Adoption' sheet. Find the state of interest in the 'State' column (column A) and click on the link in the 'Encapsulating Document URL' column (column N) in the corresponding row.

In some cases the link will lead you directly to the legislation, while in others the link will lead you to a landing page from which you need to either download the legislation or click an additional link to access the legislation in your browser.

Once you have opened the document containing the legislation of interest, press CTRL (CMD on Mac) + A to select all of the text in the document and press CTRL + C to copy the selected text. Open a new document in a text editor of your choosing and press CTRL + V to paste the copied contents into the new document. Do not modify the pasted text at this point.

Save the document as `{state}_{language}.txt` in the directory `${PROJECT_ROOT}/raw_data/unprocessed/{continent}`. If you are unsure, the language is provided in the 'Language' column (column O) in the 'Adoption' sheet in the aforementioned Google sheet. The file name must be snake case; see [this](https://github.com/danpdraper/eia/tree/mainline/raw_data/unprocessed/africa) directory for examples. `${PROJECT_ROOT}` is the path to the directory into which you cloned the `eia` repository. If you followed the installation instructions in this README, then `${PROJECT_ROOT}` would be `$HOME/projects/eia`. If the `{continent}` directory does not exist, create it before saving the file (`{continent}` should also be snake case).

### Developing the Preprocessing Script

Open a new document in a text editor of your choosing and save the file as `{state}_{language}.sh` in the directory `${PROJECT_ROOT}/scripts/legislation/{continent}`. Again, if the `{continent}` directory does not exist, create it before saving the file.

The script `${PROJECT_ROOT}/scripts/legislation/preprocess_legislation.sh` and module `${PROJECT_ROOT}/scripts/legislation/common.sh` expect that every state-and-language-specific preprocessing script will contain a function named `preprocess_state_and_language_input_file`. Accordingly, add the following to your newly-created file:

```
function preprocess_state_and_language_input_file {
  if [ "#$" -ne 2 ] ; then
    echo_usage_error "$*" '<input_file_path> <language>'
    return 1
  fi
  local input_file_path="$1"
  local language="$2"
}
```

The module `${PROJECT_ROOT}/scripts/legislation/common.sh` contains a function named `apply_common_transformations` that, as the name suggests, applies a series of generally-applicable transformations to the unprocessed legislation. You can employ this function in your preprocessing script by amending the `preprocess_state_and_language_input_file` function as follows:

```
function preprocess_state_and_language_input_file {
  if [ "#$" -ne 2 ] ; then
    echo_usage_error "$*" '<input_file_path> <language>'
    return 1
  fi
  local input_file_path="$1"
  local language="$2"

  apply_common_transformations "$input_file_path" "$language"
}
```

#### Preamble

The next step is to remove all characters in the legislation prior to the first header. To do so, find the first header in the unprocessed legislation. It will be something like 'Title I ...', 'Chapter I ...' or 'Section I ...' (or the equivalent in the legislation's language). Let's assume for illustration purposes that the first header reads 'Title I General Provisions'. Assuming furthermore that there is no other header that starts with 'Title I' in the legislation, I would update my preprocessing script as follows:

```
# New function
function remove_all_text_before_first_title_header {
  sed -n '/^Title I/,$p'
}

function preprocess_state_and_language_input_file {
  if [ "#$" -ne 2 ] ; then
    echo_usage_error "$*" '<input_file_path> <language>'
    return 1
  fi
  local input_file_path="$1"
  local language="$2"

  # Pipe output of apply_common_transformations to new function
  apply_common_transformations "$input_file_path" "$language" | \
    remove_all_text_before_first_title_header
}
```

The `sed` command in the `remove_all_text_before_first_title_header` function prints only the matching line and those that follow, where the matching line is the first line to start with 'Title I'. If the legislation's preamble happened to contain a line starting with 'Title I' (e.g. 'Title I provides an outline of the ...'), then you would need to expand the regular expression to avoid the undesirable match. In such a case, you could modify the `sed` command as follows:

```
sed -n '/Title I General Provisions/,$p'
```

At this point, it would sensible to review the fruits of your labour. Open your terminal and execute the following command:

```
${PROJECT_ROOT}/scripts/legislation/preprocess_legislation.sh {state} {language} && cat ${PROJECT_ROOT}/raw_data/preprocessed/{continent}/{state}_{language}.txt
```

This command is idempotent, which for our purposes is important because you can execute the command as many times as you like without affecting the contents of the file that you saved to the `${PROJECT_ROOT}/raw_data/unprocessed/{continent}` directory. The `preprocess_legislation.sh` script reads in the unprocessed legislation, applies the transformations that you define and writes the result to `${PROJECT_ROOT}/raw_data/preprocessed/{continent}/{state}_{language}.txt`. You can thus execute the command often and use the results as the basis for tweaking and expanding your transformations.

#### Articles

Generally speaking, the next step is to amend all of the errors in the legislation's articles. The difficulty of this step varies considerably with the quality of the unprocessed legislation. If, for example, you copied the contents of the unprocessed legislation from a word document or a PDF that was created from a word document, then chances are that there will be few errors to amend. If, on the other hand, you copied the contents of the unprocessed legislation from a PDF that was created from a scan of a physical copy of the legislation, then the contents of the unprocessed legislation might be quite mangled and require significant amendment. For an example of the former, consult [this](https://github.com/danpdraper/eia/blob/mainline/raw_data/unprocessed/africa/angola_portuguese.txt) unprocessed legislation and [this](https://github.com/danpdraper/eia/blob/mainline/scripts/legislation/africa/angola_portuguese.sh#L16-L41) preprocessing script. For an example of the latter, consult [this](https://github.com/danpdraper/eia/blob/mainline/raw_data/unprocessed/africa/gabon_french.txt) unprocessed legislation and [this](https://github.com/danpdraper/eia/blob/mainline/scripts/legislation/africa/gabon_french.sh#L8-L963) preprocessing script.

The difficulty of amending errors in articles can be significantly compounded by a lack of familiarity with the language in which the legislation is written. One effective mechanism of at least partially mitigating such a lack is to copy the contents of `${PROJECT_ROOT}/raw_data/preprocessed/{continent}/{state}_{language}.txt` into a word processor with spelling and grammar checking functionality. Such functionality will assist not only in identifying discrepancies between the unprocessed legislation and the source document, but also in identifying omissions (e.g. accents) and errors in the source document.

#### Headers

Like the legislation's articles, the difficulty of amending the errors in the legislation's headers varies with the quality of the unprocessed legislation. That said, the number of words in headers is typically negligible relative to the number of words in articles, so the potential difficulty is not as severe.

It is worth noting that there is not (at the time of writing) a function in `${PROJECT_ROOT}/scripts/legislation/common.sh` like `amend_error_in_article` to assist with amendment of errors in headers. Consult [this](https://github.com/danpdraper/eia/blob/mainline/scripts/legislation/africa/gabon_french.sh#L965-L990) preprocessing script for guidance.

#### Annexes

You might come across unprocessed legislation that includes one or more annexes. At the time of writing, annexes factor into legislation-level similarity analysis, so errors in annexes should be amended. That said, in order to ensure that annexes do not factor into provision-level similarity analysis, line-leading numbers in annexes must not be enclosed in brackets (i.e. '[' and ']'). More information regarding formatting is provided in the 'Expected Format' section below. For examples of annex error amendment, consult [this](https://github.com/danpdraper/eia/blob/mainline/raw_data/unprocessed/africa/angola_portuguese.txt) unprocessed legislation and [this](https://github.com/danpdraper/eia/blob/mainline/scripts/legislation/africa/angola_portuguese.sh#L43-L53) preprocessing script, and [this](https://github.com/danpdraper/eia/blob/mainline/raw_data/unprocessed/africa/republic_of_the_congo_french.txt) unprocessed legislation and [this](https://github.com/danpdraper/eia/blob/mainline/scripts/legislation/africa/republic_of_the_congo_french.sh#L28-L76) preprocessing script.

#### Other Amendments

The instructions provided in this README are understandably general. The range of error flavours is far too broad to address succinctly, so if you are faced with a formatting challenge that is not covered by the limited number of examples provided here, the wisest course of action is either to try and find an applicable example in the complete collection of preprocessing scripts [here](https://github.com/danpdraper/eia/tree/mainline/scripts/legislation) or to try your hand at developing a novel transformation for your use case. The latter will certainly prove more beneficial to the development of your shell scripting competency.

### Expected Format

#### Headers

Every header should be on its own line and should follow the format `(Header Type) (Identifier) - (Label)` where `(Header Type)` is `Title`, `Chapter`, `Section` or `Annex` (or equivalent in the language of the legislation), `(Identifier)` is either a number, a single letter, an ordinal or a roman numberal, and `(Label)` is all of the text that otherwise follows the identifier. Here are some examples:

```
Unprocessed: Title I General Provisions
Preprocessed: Title I - General Provisions

Unprocessed: CHAPITRE 2 L'ENVIRONNEMENT
Preprocessed: CHAPITRE 2 - L'ENVIRONNEMENT

Unprocessed: Sección Primera: Definiciones
Preprocessed: Sección Primera - Definiciones

Unprocessed: ANNEX A - TYPES OF PROJECTS REQUIRING ASSESSMENT
Preprocessed: ANNEX A - TYPES OF PROJECTS REQUIRING ASSESSMENT
```

#### Articles

Every article should be on its own line and should follow the format `(Number) Text ... [Article Delimiter] Text ... [Article Delimiter] ...`. The line should start with the article number in parentheses (round brackets) and every article delimiter (bullet points and bullet-point-like letters, numbers and roman numerals) should be enclosed in square brackets. Any non-number and non-letter character that is being used as a bullet point but is not a bullet point (such as a dash) should be replaced with a bullet point. Here are some examples:

```
Unprocessed: Article 1. I like walking the dog: a. when it is warm and b. when I am well-rested.
Preprocessed: (1) I like walking the dog: [a] when it is warm and [b] when I am well-rested.

Unprocessed: Art. 22 - I do not like walking the dog: i) when the dog is more interested in sniffing than walking; ii) it is raining; or iii) the street is clogged with people. Dogs need: - exercise, - interaction with other dogs, - ongoing stimulation generally.
Preprocessed: (22) I do not like walking the dog: [i] when the dog is more interested in sniffing than walking; [ii] it is raining; or [iii] the street is clogged with people. Dogs need: [•] exercise, [•] interaction with other dogs, [•] ongoing stimulation generally.
```

#### Annexes

Annexes do not need to adhere to a particular format. As mentioned in the 'Developing the Preprocessing Script' section above, the only formatting requirement with respect to annexes is that none of the lines in the annex start with a number in parentheses.

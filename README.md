# Practice Dutch-to-English

## TLDR

Just run

```bash
  $ ./translate.sh -loop -noprompt -user=test -retry
```

## What it does

It feeds bunch of common dutch words, and prompts for answer. It checks if correct, and if so, it increases the number of this word being correctly answered. If false answer was provides, it will store the wrong answer in the file, so that it can be later practiced again.

## The content

- sources/nl_frequency.txt contains 4621 most often used dutch words (source wiktionary)
- `translate.sh` is main script, supporting options
  - `-topdown` starts the prompting from the most often used dutch words and torward less common ones
  - `-loop` will continue to feed next word, regardless of the success or fail of current one
  - `-noprompt` will remove prompt for line selection	
  - `-user=X` will store all correct and incorrect answers of this user as files `.fail` and `.success` inside the `saves` folder
- `check_and_save.sh` does exactly that - saves the correct and wrong answers into saves/user files, so that there can be statistics and training on wrong anwsers
- `random.sh` is used in a 

- `./translate_from_google.sh nl en kijk`
  - it uses web google translation
  - can be directly called by providing: `src_lan dest_lan word(s)` as parameters (where language is a short code like `en`)
- `./translate_from_dictionary.sh slag`
  - uses a dutch-english dictionary stored in `sources/nld-eng.tei` - can be and IS buggy

See source/README.md for more about extra language files.

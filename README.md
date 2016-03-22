# GutenbergNoun
Mine text from Project Gutenberg, prepare, annotate and extract the nouns

## Getting Started

Install dependency.
```
R
tm (R library)
Java 8
git (optional)
wget (optional, required for demo texts)
find (optional, required for demo texts)
```

Copy or `git clone` the repository. 

Move into project folder.

Optional: 
Prepare some texts you want to analyse in a subfolder named `data`.
For examlpe from [Project Gutenberg](http://www.gutenberg.org/ebooks/). In this demo only english texts will be annotated correctly.  
If you don't create the `data` folder and have `wget` and `find` installed, some data will be prepared on the first run.

Run `R --file=analysis.R`

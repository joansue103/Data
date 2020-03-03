#wlączenie bibliotek
library(tm)
#zmiana katalogu roboczego
workDir <- "D:\\jm\\pjn"
setwd(workDir)

#definicja katalogów projektu
inputDir <- ".\\data"
outputDir <- ".\\results"
scriptsDir <- ".\\scripts"
workspaceDir <-".\\workspace"

#uworzenie katalogu wyssciowego
dir.create(outputDir, showWarnings = FALSE)
dir.create(workspaceDir, showWarnings = FALSE)

#utworzenie korpusu dokumentow
corpusDir <- paste(
  inputDir,
  "\\",
  "Literatura - streszczenia - oryginał",
  sep = ""
)


corpus <- VCorpus(
  DirSource(
    corpusDir,
    pattern = "*.txt",
    encoding =  "UTF-8"
  ),
  readerControl = list(
    language = "pl_PL"
  )
)
#wstepne przetwarzanie

corpus <- tm_map(corpus, removeNumbers)
corpus <- tm_map(corpus, removePunctuation)
corpus <- tm_map(corpus, content_transformer(tolower))
stoplistFile <- paste(
  inputDir,
  "\\",
  "stopwords_pl.txt",
  sep = ""
  
)
stoplist <- readLines(
  stoplistFile,
  encoding = "UTF-8"
)
corpus <- tm_map(corpus, removeWords, stoplist)
corpus <- tm_map(corpus, stripWhitespace)


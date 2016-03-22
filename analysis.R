source("preparation.R")

library(tm)

dataDir <- prepareData()
taggerDir <- prepareTagger()

removeDisclaimer <- function(x) {
    pattern <- "\\*\\*\\* START: FULL LICENSE \\*\\*\\*"
    i <- min(length(x),grep(pattern, x) - 1)
    x[1:i]
}

tagWithTreeTagger <- function(x) {
    command <- paste0("java -mx300m -cp '", taggerDir, "/stanford-postagger.jar:", taggerDir, "/lib/*' edu.stanford.nlp.tagger.maxent.MaxentTagger -model ", taggerDir, "/models/english-left3words-distsim.tagger -outputFormat slashTags -tagSeparator /")
    system(command, intern=TRUE,
       ignore.stdout = FALSE, ignore.stderr = TRUE,
       wait = TRUE, input = x)
}

removeNonNoun <- function(x) gsub("\\S+/(N[^N]|[^N]N|[^N]{2}|\\S{3,}|\\S{1})(\\s|$)", "", x)

corpus <- VCorpus(DirSource(dataDir), readerControl=list(reader=readPlain))
cleanedCorpus <- tm_map(corpus, content_transformer(removeDisclaimer))
taggedCorpus <- tm_map(cleanedCorpus, content_transformer(tagWithTreeTagger))
nounCorpus <- tm_map(taggedCorpus, content_transformer(removeNonNoun))

lapply(nounCorpus[1], as.character)

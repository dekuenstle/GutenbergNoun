prepareTagger <- function() {
    tagger <- "stanford-postagger-2015-12-09"
    taggerZip <- paste(tagger, ".zip", sep="")
    taggerUrl <- paste("http://nlp.stanford.edu/software/", taggerZip, sep="")
    if(!file.exists(tagger)) {
        download.file(taggerUrl, taggerZip)
        unzip(taggerZip)
        file.remove(taggerZip)
    }
    return(tagger)
}

prepareData <- function(depth=1) {
    downloadDir <- "download"
    dataDir <- "data"
    if (! file.exists(dataDir)) {
        if( ! file.exists(downloadDir)) {
            wget <- paste("wget -w 0.5 -N -r -l ", depth, " --no-remove-listing -H -P", downloadDir, "\"http://www.gutenberg.org/robot/harvest?filetypes[]=txt&langs[]=en\"")
            system(wget)
        }
        find <- paste("find ", downloadDir, "/www.gutenberg.lib.md.us -name \"*.zip\" -exec unzip -d ", dataDir, " {} \\;", sep="")
        system(find)
    }
    return(dataDir)
}

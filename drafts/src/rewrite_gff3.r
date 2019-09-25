## Time-stamp: <2019-09-25 13:44:42 chl>

WD <- "~/cwd/nobackup/galaxy/RNAseq/"
setwd(WD)

system("grep '^>' Podans1_GeneCatalog_transcripts_20171002.nt.fasta | sed 's/>//g' > transcrits")

d <- read.table("Podans1_GeneCatalog_20171002.gff3", header = F, skip = 2, sep = "\t", stringsAsFactor = FALSE)

trans <- scan("transcrits", what = "character", sep = "\n")

## Split field and replace Name with transcript ID
val <- strsplit(d[, 9], ";")

for (i in seq_along(val)) {
  if (grepl("Name=", val[i])) {
    id <- stringr::str_extract(ids[i], "\\d+$")
    match <- trans[grep(paste0("\\|", id, "\\|"), trans)]
    val[i][[1]][2] <- paste0("Name=", match)
  }
}

## Concatenate and update original values
for (i in seq_along(val))
  d[i, 9] <- paste(unlist(val[[i]]), collapse = ";")

## Write output file
write.table(d, file = "tmp.gff3", sep = "\t", row.names = FALSE, col.names = FALSE, quote = FALSE)
system("cat header tmp.gff3 > Podans1_GeneCatalog_20171002-rev.gff3")

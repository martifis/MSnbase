readMSnSet <- function(exprsFile,
                       phenoDataFile,
                       featureDataFile,
                       experimentDataFile,
                       notesFile,
                       path,
                       annotation,
                       ## arguments to read.* methods
                       exprsArgs=list(sep=sep, header=header, row.names=row.names, quote=quote, ...),
                       phenoDataArgs=list(sep=sep, header=header, row.names=row.names, quote=quote, stringsAsFactors=stringsAsFactors, ...),
                       featureDataArgs=list(sep=sep, header=header, row.names=row.names, quote=quote, stringsAsFactors=stringsAsFactors, ...),
                       experimentDataArgs=list(sep=sep, header=header, row.names=row.names, quote=quote, stringsAsFactors=stringsAsFactors, ...),
                       sep = "\t", header = TRUE, quote = "", stringsAsFactors = FALSE, row.names = 1L,
                       ## widget
                       widget = getOption("BioC")$Base$use.widgets,
                       ...) {
  eset <- readExpressionSet(exprsFile, phenoDataFile, experimentDataFile,
                            notesFile, path, annotation,
                            exprsArgs, phenoDataArgs, experimentDataArgs,
                            sep, header, quote, stringsAsFactors, row.names,
                            widget, ...)
  .process <- new("MSnProcess",
                  processing=paste("Quantitation data loaded:",date(),
                    " using readMSnSet."),
                  files=exprsFile)
  .miame <- experimentData(eset)
  .miape <- new("MIAPE",
                name = .miame@name,
                lab = .miame@lab,
                contact = .miame@contact,
                title = .miame@title,
                abstract = .miame@abstract,
                url = .miame@url)
  if (!missing(featureDataFile)) {
    featureDataArgs$file <- featureDataFile
    fd <- do.call(read.AnnotatedDataFrame, featureDataArgs)
    if (!identical(featureNames(fd), featureNames(eset)))
      stop("Row names of the quantitation matrix must be identical to\n",
           "the feature names of the featuredata table.\n",
           "You could use 'options(error=recover)' to compare the",
           "values of 'rowames(fd)' and 'featureNames(eset)'.\n")
    mset <- new("MSnSet",
                exprs = exprs(eset),
                phenoData = phenoData(eset),
                featureData = fd,
                processingData = .process,
                protocolData = protocolData(eset),
                experimentData = .miape)    
  } else {
    mset <- new("MSnSet",
                exprs = exprs(eset),
                phenoData = phenoData(eset),
                processingData = .process,
                protocolData = protocolData(eset),
                experimentData = .miape)
  }
  if (validObject(mset))
    return(mset)
}
 

readMSnSet2 <- function(file, ecol, fnames, ...) {  
  xx <- read.csv(file, ...)
  if (is.character(ecol)) {
    ecol0 <- ecol
    ecol <- match(ecol0, colnames(xx))
    if (any(is.na(ecol)))
      stop("Column identifiers ",
           paste(ecol0[is.na(ecol)], collapse = ", "),
           " not recognised among\n",
           paste(colnames(xx), paste = ", "))
  }
  eset <- as.matrix(xx[, ecol])
  fdata <- xx[, -ecol, drop = FALSE]
  ans <- new("MSnSet",
             exprs = eset,
             featureData = new("AnnotatedDataFrame",
               data = fdata))
  if (!missing(fnames)) {
    if (is.na(match(fnames, colnames(xx))))
      stop(fnames, "not found among\n",
           paste(colnames(xx), paste = ", "))        
    featureNames(ans) <- fdata[, fnames]
  }
  if (validObject(ans))
    return(ans)
}    

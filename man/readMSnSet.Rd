\name{readMSnSet}

\alias{readMSnSet}
\alias{readMSnSet2}

\title{ Read 'MSnSet' }

\description{
  This function reads data files to generate an
  \code{\linkS4class{MSnSet}} instance. It is a wrapper around Biobase's
  \code{\link{readExpressionSet}} function with an additional 
  \code{featureDataFile} parameter to include feature data.
  See also \code{\link{readExpressionSet}} for more details.
  \code{readMSnSet2} is a simple version that takes a single
  text spreadsheet as input and extracts the expression data
  and feature meta-data to create and \code{MSnSet}.
}

\usage{
readMSnSet(exprsFile,
           phenoDataFile,
           featureDataFile,
           experimentDataFile,
           notesFile,
           path, annotation,
           exprsArgs = list(sep = sep, header = header, row.names = row.names, quote = quote, ...),
           phenoDataArgs = list(sep = sep, header = header, row.names = row.names, quote = quote, stringsAsFactors = stringsAsFactors, ...),
           featureDataArgs = list(sep = sep, header = header, row.names = row.names, quote = quote, stringsAsFactors = stringsAsFactors, ...),
           experimentDataArgs = list(sep = sep, header = header, row.names = row.names, quote = quote, stringsAsFactors = stringsAsFactors, ...),
           sep = "\t",
           header = TRUE,
           quote = "",
           stringsAsFactors = FALSE,
           row.names = 1L,
           widget = getOption("BioC")$Base$use.widgets, ...)

readMSnSet2(file, ecol, fnames, ...)
}

\arguments{
  Arguments direclty passed to \code{readExpressionSet}. The description
  is from the \code{readExpressionSet} documentation page.
  \item{exprsFile}{(character) File or connection from which to read
    expression values. The file should contain a matrix with rows as
    features and columns as samples. \code{\link{read.table}} is called
    with this as its \code{file} argument and further arguments given by
    \code{exprsArgs}.}  
  \item{phenoDataFile}{(character) File or connection from which to read
    phenotypic data. \code{\link{read.AnnotatedDataFrame}} is called
    with this as its \code{file} argument and further arguments given by
    \code{phenoDataArgs}.} 
  \item{experimentDataFile}{(character) File or connection from which to
    read experiment data. \code{\link{read.MIAME}} is called with this
    as its \code{file} argument and further arguments given by
    \code{experimentDataArgs}.} 
  \item{notesFile}{(character) File or connection from which to read
    notes; \code{\link{readLines}} is used to input the file.}
  \item{path}{(optional) directory in which to find all the above
    files.}
  \item{annotation}{(character) A single character string indicating the
    annotation associated with this ExpressionSet.} 
  \item{exprsArgs}{A list of arguments to be used with
    \code{\link{read.table}} when reading in the expression matrix.}
  \item{phenoDataArgs}{A list of arguments to be used (with
    \code{\link{read.AnnotatedDataFrame}}) when reading
    the phenotypic data.}
  \item{experimentDataArgs}{A list of arguments to be used (with
    \code{\link{read.MIAME}}) when reading the experiment data.}
  \item{sep, header, quote, stringsAsFactors, row.names}{arguments used
    by the \code{\link{read.table}}-like functions.}
  \item{widget}{A boolean value indicating whether widgets can be
    used. Widgets are NOT yet implemented for
    \code{read.AnnotatedDataFrame}.}
  \item{\dots}{Further arguments that can be passed on to the
    \code{\link{read.table}}-like functions.}
  
  Additional argument, specific to \code{readMSnSet}:
  \item{featureDataFile}{(character) File or connection from which to read
    feature data. \code{\link{read.AnnotatedDataFrame}} is called
    with this as its \code{file} argument and further arguments given by
    \code{phenoDataArgs}.} 
  \item{featureDataArgs}{A list of arguments to be used (with
    \code{\link{read.AnnotatedDataFrame}}) when reading the phenotypic
    data. }

  Arguments for \code{readMSnSet2}:
  \item{file}{A \code{character} indicating the spreadsheet
    file. Default is to read the file as a comma-separated values
    (csv). If different, use the additional arguments, passed to
    \code{\link{read.csv}}, to parametrise file import.}
  \item{ecol}{A \code{numeric} indicating the indices of the columns to
    be used as expression values. Can also be a \code{character}
    indicating the names of the columns. Caution must be taken of the
    column names are composed of special characters like '(' or '-' that
    will be converted to a '.'. If \code{ecol} does not match, the error
    message will dispay the column names are see by \code{R}.
  }
  \item{fnames}{An optional \code{character} indicating the column to be
    used as feature names. }
}


\value{ An instance of the \code{\linkS4class{MSnSet}} class. }

\author{
  Laurent Gatto <lg390@cam.ac.uk>
}

\seealso{
  The \code{\link{grepEcols}} and \code{\link{getEcols}} helper
  functions to identify the \code{ecol} values.
  The \code{MSnbase-io} vignette illustrates these functions in
  detail. It can accessed with \code{vignette("MSnbase-io")}.
}

\examples{
\dontrun{
exprsFile <- "path_to_intensity_file.csv"
fdatafile <- "path_to_featuredata_file.csv"
pdatafile <- "path_to_sampledata_file.csv"
## Read ExpressionSet with appropriate parameters
res <- readMSnSet(exprsFile, pdataFile, fdataFile, sep = "\t", header=TRUE)
}}

\keyword{file}
\keyword{manip}

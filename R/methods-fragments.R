setMethod("calculateFragments", c("character", "missing"),
          function(sequence, type=c("b", "y"), z=1,
                   modifications=c(C=57.02146),
                   neutralLoss=defaultNeutralLoss(),
                   verbose=TRUE) {
            l <- lapply(sequence, .calculateFragments,
                        type=type, z=z, modifications=modifications,
                        neutralLoss=neutralLoss, verbose=verbose)
            return(do.call(rbind, l))
        })

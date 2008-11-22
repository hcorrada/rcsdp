# Convert data to/from csdp format
# to R objects (matrix or simple_triplet_sym_matrix)

# vectors
vector_R2csdp <- function(x)
  {
    c(0,x);
  }

vector_csdp2R <- function(x)
  {
    x[-1];
  }

blkmatrix_R2csdp <- function(X,prob.info)
  {
    do.one.block <- function(blocknum)
      {
        cur.block <- X[[blocknum]];
        cur.type <- prob.info$block.types[blocknum];
        cur.size <- prob.info$block.sizes[blocknum];
        
        if (cur.type == 1) {
          data <- as.double(cur.block);
        }
        else {
          data <- vector_R2csdp(cur.block)
        }
        list(blocksize=as.integer(cur.size),
             blockcategory=as.integer(cur.type),
             data=as.double(data))
      }
    
    nblocks <- prob.info$nblocks;
    list(nblocks=nblocks,
         blocks=lapply(seq_along(X),do.one.block))
  }

blkmatrix_csdp2R <- function(X,prob.info)
  {
    do.one.block <- function(blocknum)
      {
        cur.block <- X$blocks[[blocknum]];
        cur.type <- prob.info$block.types[blocknum];
        cur.size <- prob.info$block.sizes[blocknum];
        
        names(cur.block) <- c("blocksize","blockcategory","data");
        if (cur.type == 1)
          matrix(cur.block$data,cur.size,cur.size)
        else
          vector_csdp2R(cur.block$data);
      }
    names(X) <- c("nblocks","blocks");
    lapply(seq_along(X$blocks),do.one.block);
  }

constraints_R2csdp <- function(A,prob.info)
  {
    nblocks <- prob.info$nblocks;

    do.one.constraint <- function(constraintnum)
      {
        Ai = A[[constraintnum]]
        ret <- vector("list",nblocks)

        k <- 0;
        for (j in 1:nblocks) {
          blocknum <- j;
          Aij <- Ai[[blocknum]];
          
          cur.type <- prob.info$block.types[blocknum];
          cur.size <- prob.info$block.sizes[blocknum];
          
          if (cur.type == 1) {
            tmp <- as.simple_triplet_sym_matrix(Aij);
            if (length(tmp$v) == 0)
              next
            
            iindices <- vector_R2csdp(tmp$i);
            jindices <- vector_R2csdp(tmp$j);
            entries <- vector_R2csdp(tmp$v);
          }
          else {
            nnz <- which(Aij != 0);
            if (length(nnz) == 0)
              next
            
            iindices <- vector_R2csdp(nnz);
            jindices <- vector_R2csdp(nnz);
            entries <- vector_R2csdp(Aij[nnz]);
          }
          k <- k+1
          ret[[k]] <- list(iindices=as.integer(iindices),
                           jindices=as.integer(jindices),
                           entries=as.double(entries),
                           blocknum=as.integer(blocknum),
                           blocksize=as.integer(cur.size),
                           constraintnum=as.integer(constraintnum),
                           numentries=as.integer(length(entries)-1))

        }
        ret[1:k]
      }
    lapply(seq_along(A),do.one.constraint);
  }

constraints_csdp2R <- function(A,prob.info)
  {
    nblocks <- prob.info$nblocks
    do.one.constraint <- function(constraintnum)
      {
        Ai <- A[[constraintnum]]
        ret <- lapply(prob.info$block.sizes,function(x) .simple_triplet_zero_sym_matrix(x))
        
        for (j in 1:length(Ai)) {
          Aij <- Ai[[j]];
          names(Aij) <- c("iindices","jindices","entries",
                          "blocknum","blocksize","constraintnum","numentries");
          if (Aij$constraintnum != constraintnum)
            stop("Constraint number in csdp constraint matrix is not right")

          cur.type <- prob.info$block.types[Aij$blocknum];
          cur.size <- prob.info$block.sizes[Aij$blocknum];

          if (cur.type == 1) {
            cur.iindices <- vector_csdp2R(Aij$iindices);
            cur.jindices <- vector_csdp2R(Aij$jindices);

            # simple_triplet_sym_matrix uses the lower triangle
            if (any(cur.iindices < cur.jindices)) {
              tmp <- cur.iindices
              cur.iindices <- cur.jindices
              cur.jindices <- tmp
            }
            ret[[Aij$blocknum]] <- simple_triplet_sym_matrix(i=cur.iindices,
                                                             j=cur.jindices,
                                                             v=vector_csdp2R(Aij$entries),
                                                             n=cur.size,
                                                             check.ind=TRUE);
            
          }
          else {
            tmp <- rep(0.0,cur.size);
            tmp[vector_csdp2R(Aij$iindices)] <- vector_csdp2R(Aij$entries)
            ret[[Aij$blocknum]] <- tmp;
          }
        }
        ret
      }
    lapply(seq_along(A),do.one.constraint);
  }


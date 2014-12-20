## function "makeCacheMatrix" make a special "matrix" so that function "cacheSolve" 
## can calculate the inverse of that matrix for once and getting the cached results later

## makeCacheMatrix create a list containing functions:
## 1. set the value of matrix
## 2. get the value of matrix
## 3. set the inverse of the matrix
## 4. get the inverse of the matrix

makeCacheMatrix <- function(x = matrix()) {
  m <- NULL
  set <- function(y) {
    x <<- y
    m <<- NULL
  }
  get <- function() x
  setinv <- function(inv) m <<- inv
  getinv <- function() m
  list(set = set, get = get, setinv = setinv, getinv = getinv)
}


## following function calculates the inverse of the special "matrix" created with the above function. 
## However, it first checks to see if the inverse has already been calculated.

cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
  m <- x$getinv()
  if(!is.null(m)) {
    message("Getting cache data")
    return(m)
  }
  data <- x$get()
  m <- solve(data)
  x$setinv(m)
  m
    
}

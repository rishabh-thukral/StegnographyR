#Decryption
decrypt_stegnography <- function(intensities){
  messg <- ""
  k<-0
  ascii <- 0
  done <- FALSE
  for(i in nrow(intensities)){
    if(done==TRUE){
      break
    }
    for(j in ncol(intensities)){
      if(bitwAnd(intensities[i,j],1)==1){
        ascii <- ascii + 2**k
      }
      k <- k+1
      if(k%%8==0){
        charPick <- intToUtf8(ascii)
        if(charPick=="~"){
          done <- TRUE
        }else{
          messg <- paste0(messg,charPick)
        }
        k <- 0;
        ascii <- 0
      }
      if(done==TRUE){
        break
      }
    }
  }
  return(messg)
}
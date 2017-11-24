#Encyrption
encrypt_stegnography <- function(intensities,PT){
  #Add Delimiter `~` to PT
  PT <- paste0(PT,"~")
  #convert PT to bitstream
  intPT <- utf8ToInt(PT)
  #extract bits
  toBits <- matrix(data = 0,nrow = length(intPT),ncol = 8)
  for(i in seq(8)){
    colnames(toBits)[i] <- paste0("bit",i-1)
    bit <- vector(mode = "numeric",length = length(intPT))+ (2**(i-1))
    toBits[,i] <- bitwAnd(intPT,bit)
  }
  toBits[(toBits!=0)]=1
  #toBits stores values in Little Endian Style  : LSB in lower position
  k <- 1
  for(i in length(intPT)){
    for(j in seq(8)){
      #Filling the bitstream in intensity values in Row major order 
      row <- ceiling(k/ncol(intensities))
      col <- k%%ncol(intensities)
      print(paste(row,col,sep = " "))
      if(col==0){
        col <- ncol(intensities)
      }
      if(toBits[i,j]==1){
        intensities[row,col] = bitwOr(intensities[row,col],1)#(8-bit intensity)|00000001
      }else{
        intensities[row,col] = bitwAnd(intensities[row,col],254)#(8-bit intensity)&11111110
      }
      k <- k+1
    }
  }
  return(intensities)
}
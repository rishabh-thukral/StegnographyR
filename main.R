rm(list = ls())
library("png")
library("colorspace")
library("magick")
library("svDialogs")
source(paste0(getwd(),"/EncryptStegnography.R"))
source(paste0(getwd(),"/DecryptStegnography.R"))

#Get file location
winDialog("ok","Choose Image File to encrypt")
fileDirectory <-  file.choose()

#Get input Image
inputImage <- image_read(fileDirectory)
imageAttributes <- image_info(inputImage)
height <- as.numeric(imageAttributes[2])
width <- as.numeric(imageAttributes[3])
imageAttributes

#Convert to PNG and Grayscale
imageGrey <- image_quantize(inputImage,colorspace = "gray")
imageGrey <- image_convert(imageGrey,format = "png")

#Save a temp file 
tmpName <- tempfile(pattern = "stegImg",fileext = ".png")
image_write(imageGrey,path = tmpName)

#read the temp file into matrix
intensityMatrix <- readPNG(tmpName)
intensityMatrix <- round(255*intensityMatrix)
image(intensityMatrix ,col = gray(0:255 / 256))

#Extract original LSB
zeros = vector(mode = "numeric",length = ncol(intensityMatrix))
b1 <- zeros+1
bit1 <- NULL#LSB original
for( i in (1:nrow(intensityMatrix))){
  vec <- bitwAnd(intensityMatrix[i,],b1)#lsb
  bit1 <- rbind(bit1,vec)
}
originalLSB <- bit1

#Get Message Input
maxLen <- (height*width)/8
maxLen <- maxLen - 40
plainText <- dlgInput(message = paste0("Enter Message to encypt. Max character limit = ",maxLen), default = "My Message", gui = .GUI)$res
if(nchar(plainText) > maxLen){
  plainText <- substr(plainText,1,maxLen)
}
#Encrypt using Stegnography
intensityMatrix <- encrypt_stegnography(intensities = intensityMatrix,PT = plainText)

#Extract new LSB
bit1 <- NULL#LSB new
for( i in (1:nrow(intensityMatrix))){
  vec <- bitwAnd(intensityMatrix[i,],b1)#lsb
  bit1 <- rbind(bit1,vec)
}
newLSB <- bit1

#compute loss of information
error <- newLSB - originalLSB
changePixels <- sum(colSums(error!=0))
totalPixels <- nrow(error)*ncol(error)
MAPE <- (changePixels*100)/(totalPixels)
winDialog(type = "ok",message = paste0("Encyption Successful with ",MAPE,"% Information Loss."))

#write file
writePNG(intensityMatrix/255,target = tmpName)
cipherImage <- image_read(path = tmpName)
saveDirectory <- dlgSave(title = "Save Image to")$res
image_write(cipherImage,path = saveDirectory,format = "png")

#Decryption
#Get file location
winDialog("ok","Choose Image File to Decrypt")
fileDirectory <-  file.choose()

#Get input Image
inputImage <- image_read(fileDirectory)
imageAttributes <- image_info(inputImage)
height <- as.numeric(imageAttributes[2])
width <- as.numeric(imageAttributes[3])
imageAttributes

#Convert to PNG and Grayscale
imageGrey <- image_quantize(inputImage,colorspace = "gray")
imageGrey <- image_convert(imageGrey,format = "png")

#Save a temp file 
tmpName <- tempfile(pattern = "destegImg",fileext = ".png")
image_write(imageGrey,path = tmpName)

#read the temp file into matrix
intensityMatrix <- readPNG(tmpName)
intensityMatrix <- round(255*intensityMatrix)
image(intensityMatrix ,col = gray(0:255 / 256))

#Decrypt Stegnography
plainText <- decrypt_stegnography(intensityMatrix)

#display output
winDialog(type = "ok",message = paste0("After Decryption message is:-\n",plainText))

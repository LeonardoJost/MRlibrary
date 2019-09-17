###main program

source("functions/helpers.R")
source("functions/imageManipulation.R")
source("functions/imageRotate.R")
source("functions/petersBatistaModels.R")
source("functions/customModels.R")

#set parameters
source("functions/parameters.R")

#load blank image
background=image_read(backgroundImage)
background=image_scale(background,imageSize)

###generate petersBatista Models

#generate all models from PetersBatista(2008)
#code timing
startTimeTotal=proc.time()
#loop over all models
for(modelNumber in modelNumbers) {
  #loop over all background colors
  for(backgroundColor in backgroundColors) {
    #fill background with color
    if(backgroundColor!='none')
      background=image_fill(background, backgroundColor, point = "+0+0", fuzz = 100)
    #create directories, if necessary
    baseFolderWithBG=paste(baseFolder,"\\PetersBatista\\",backgroundColor,"_back\\",sep="")
    createDirs(baseFolderWithBG,c("x","y","z","base","combined"))
    #loop over orientations
    for(orientation in orientations) {
      #code timing
      startTimeModelBackgroundOrientation=proc.time()
      #reset base rotation angles
      rotX=rotationAngleXBase
      rotY=rotationAngleYBase
      rotZ=rotationAngleZBase
      #get base model (not in model loop, as orientation changes need to be reversed)
      bottomLeftPoints=centerModel(getModel(modelNumber),centering)
      #adjust length
      bottomLeftPoints=bottomLeftPoints*pixelDiameter
      #get coloring
      pointColors=getColors(modelNumber,colors)
      #mirror, if needed
      if(orientation=="b") { #mirror along yz-plane (x-axis is reversed)
        bottomLeftPoints[1,]=-bottomLeftPoints[1,]
      } else if(orientation=="c") { #mirror along xz-plane (y-axis is reversed)
        bottomLeftPoints[2,]=-bottomLeftPoints[2,]
      } else if(orientation=="d") { #mirror along xy-plane (z-axis is reversed)
        bottomLeftPoints[3,]=-bottomLeftPoints[3,]
      }
      #save base model
      folder=paste(baseFolderWithBG,"base\\",sep="")
      fileName=paste(modelNumber,"_",orientation,sep="")
      drawCubeFigure(bottomLeftPoints,pixelDiameter,pointColors,background,rotX,rotY,rotZ,borderColor,colors,folder,fileName,fileFormat,showOcclusions)
      #loop over angles
      #rotation around y Axis
      for(j in 0:round(360/angleDiff-1)) {
        #calculate rotation angle
        rotY=rotationAngleYBase+j*angleDiff*pi/180
        folder=paste(baseFolderWithBG,"y\\",sep="")
        fileName=paste(modelNumber,"_y_",j*angleDiff,"_",orientation,sep="")
        drawCubeFigure(bottomLeftPoints,pixelDiameter,pointColors,background,rotX,rotY,rotZ,borderColor,colors,folder,fileName,fileFormat,showOcclusions)
      }
      #reset angle
      rotY=rotationAngleYBase
      #rotation around x Axis
      for(j in 0:round(360/angleDiff-1)) {
        #calculate rotation angle
        rotX=rotationAngleXBase+j*angleDiff*pi/180
        folder=paste(baseFolderWithBG,"x\\",sep="")
        fileName=paste(modelNumber,"_x_",j*angleDiff,"_",orientation,sep="")
        drawCubeFigure(bottomLeftPoints,pixelDiameter,pointColors,background,rotX,rotY,rotZ,borderColor,colors,folder,fileName,fileFormat,showOcclusions)
      }
      #reset angle
      rotX=rotationAngleXBase
      #rotation around z axis
      for(j in 0:round(360/angleDiff-1)) {
        #calculate rotation angle
        rotZ=rotationAngleZBase+j*angleDiff*pi/180
        folder=paste(baseFolderWithBG,"z\\",sep="")
        fileName=paste(modelNumber,"_z_",j*angleDiff,"_",orientation,sep="")
        drawCubeFigure(bottomLeftPoints,pixelDiameter,pointColors,background,rotX,rotY,rotZ,borderColor,colors,folder,fileName,fileFormat,showOcclusions)
      }
      #combined
      if(combinedRotations) {
        for(j in 0:round(360/angleDiffCombined-1)) {
          for(l in 0:round(360/angleDiffCombined-1)) {
            for(k in 0:round(360/angleDiffCombined-1)) {
              rotX=rotationAngleXBase+j*angleDiffCombined*pi/180
              rotY=rotationAngleYBase+l*angleDiffCombined*pi/180
              rotZ=rotationAngleZBase+k*angleDiffCombined*pi/180
              folder=paste(baseFolderWithBG,"combined\\",sep="")
              fileName=paste(modelNumber,"_x_",j*angleDiffCombined,"_y_",l*angleDiffCombined,"_z_",k*angleDiffCombined,"_",orientation,sep="")
              drawCubeFigure(bottomLeftPoints,pixelDiameter,pointColors,background,rotX,rotY,rotZ,borderColor,colors,folder,fileName,fileFormat,showOcclusions)
            }
          }
        }
      }
      writeLines(paste("\nTime elapsed for model ", modelNumber, " ", orientation ," ", backgroundColor, ":",sep=""))
      print(proc.time()-startTimeModelBackgroundOrientation)
    }
  }
}
writeLines(paste("\nTime elapsed total",sep=""))
print(proc.time()-startTimeTotal)


# ### calculate occlusions
# #occlusion matrix with 5 rows
# #row 1-3: rotation angles x,y,z
# #row 4: number of front facing corners
# #row 5: number of visible faces
# angleDiff=5
# angles=90/angleDiff+1
# 
# occlusions=matrix(c(rep(0:(angles-1),each=angles),
#                     rep(0,angles*angles),
#                     rep(0:(angles-1),angles),
#                     rep(0,angles*angles*2)
#                     ),nrow=5,byrow=TRUE)*angleDiff
# occlusions=apply(occlusions,2,function(i) {
#   unitCube=getRotatedCube(c(0,0,0),1000,i[1]*pi/180,i[2]*pi/180,i[3]*pi/180)
#   i[4]=length(which(round(unitCube[2,])==round(min(unitCube[2,]))))
#   return(i)
# })
# occlusions[5,]=ifelse(occlusions[4,]==1,3,ifelse(occlusions[4,]==2,2,1))
# occlusions[,which(occlusions[4,]==3)]
# occlusions=occlusions[,which(occlusions[5,]<3)]
# occlusions
# #occlusions occur at x or z multiple of 90 degrees


### testing

### clear old data and stuff for testing
rm(list=ls())
dev.off()
gc()

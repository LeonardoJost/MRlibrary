### Loop to generate images
#     Copyright (C) 2019  Leonardo Jost
# 
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

#generate all Images according to the parameters
generateAllImages=function(){
  #time output
  if (showTimes) {
    #code timing
    startTimeTotal=proc.time()
  }
  #load blank image
  backgroundFromFile=image_read(backgroundImage)
  backgroundFromFile=image_scale(backgroundFromFile,imageSize)
  #loop over all models
  for(modelNumber in modelNumbers) {
    #model processing output
    if (showModels) {
      writeLines(paste("processing Model ",modelNumber, "...",sep=""))
    }
    #loop over all colors of cubes
    for(colors in colorList) {
      colorString=ifelse(length(colors)>1,paste(colors[1],colors[2],sep="-"),colors[1])
      #loop over all background colors
      for(backgroundColor in backgroundColors) {
        #load blank image
        background=backgroundFromFile
        #fill background with color
        if(backgroundColor!='none') {
          background=image_background(background, backgroundColor, flatten=TRUE)
        }
        #create directories, if necessary
        baseFolderWithBG=paste(baseFolder,"\\",backgroundColor,"_back\\",colorString,"\\",sep="")
        createDirs(baseFolderWithBG,c(axes,"base"))
        #loop over orientations
        for(orientation in orientations) {
          #time output
          if (showTimes) {
            #code timing
            startTimeModelBackgroundOrientation=proc.time()
          }
          #reset base rotation angles
          rotX=rotationAngleXBase
          rotY=rotationAngleYBase
          rotZ=rotationAngleZBase
          #get base model (not in model loop, as orientation changes need to be reversed)
          bottomLeftPoints=centerModel(getModel(modelNumber,usePetersBattistaModels),centering)
          #adjust length
          bottomLeftPoints=bottomLeftPoints*pixelDiameter
          #get coloring
          pointColors=getColors(modelNumber,colors,usePetersBattistaModels)
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
          #file generation output
          if(showFiles) {
            writeLines(paste("Output file generated:",folder,fileName,".",fileFormat,sep=""))
          }
          #loop over angles
          #rotation around y Axis
          if ("y" %in% axes) {
            for(j in (1-zeroRotations):ceiling(360/angleDiff-1)) {
              #calculate rotation angle
              rotY=rotationAngleYBase+j*angleDiff*pi/180
              folder=paste(baseFolderWithBG,"y\\",sep="")
              fileName=paste(modelNumber,"_",orientation,"_y_",j*angleDiff+addBaseAngle*rotationAngleYBase,sep="")
              drawCubeFigure(bottomLeftPoints,pixelDiameter,pointColors,background,rotX,rotY,rotZ,borderColor,colors,folder,fileName,fileFormat,showOcclusions)
              #file generation output
              if(showFiles) {
                writeLines(paste("Output file generated:",folder,fileName,".",fileFormat,sep=""))
              }
            }
            #reset angle
            rotY=rotationAngleYBase
          }
          #rotation around x Axis
          if ("x" %in% axes) {
            for(j in (1-zeroRotations):ceiling(360/angleDiff-1)) {
              #calculate rotation angle
              rotX=rotationAngleXBase+j*angleDiff*pi/180
              folder=paste(baseFolderWithBG,"x\\",sep="")
              fileName=paste(modelNumber,"_",orientation,"_x_",j*angleDiff+addBaseAngle*rotationAngleXBase,sep="")
              drawCubeFigure(bottomLeftPoints,pixelDiameter,pointColors,background,rotX,rotY,rotZ,borderColor,colors,folder,fileName,fileFormat,showOcclusions)
              #file generation output
              if(showFiles) {
                writeLines(paste("Output file generated:",folder,fileName,".",fileFormat,sep=""))
              }
            }
            #reset angle
            rotX=rotationAngleXBase
          }
          #rotation around z axis
          if ("z" %in% axes) {
            for(j in (1-zeroRotations):ceiling(360/angleDiff-1)) {
              #calculate rotation angle
              rotZ=rotationAngleZBase+j*angleDiff*pi/180
              folder=paste(baseFolderWithBG,"z\\",sep="")
              fileName=paste(modelNumber,"_",orientation,"_z_",j*angleDiff+addBaseAngle*rotationAngleZBase,sep="")
              drawCubeFigure(bottomLeftPoints,pixelDiameter,pointColors,background,rotX,rotY,rotZ,borderColor,colors,folder,fileName,fileFormat,showOcclusions)
              #file generation output
              if(showFiles) {
                writeLines(paste("Output file generated:",folder,fileName,".",fileFormat,sep=""))
              }
            }
          }
          #combined
          if ("combined" %in% axes) {
            for(j in 0:ceiling(360/angleDiffCombined-1)) {
              for(l in 0:ceiling(360/angleDiffCombined-1)) {
                for(k in 0:ceiling(360/angleDiffCombined-1)) {
                  rotX=rotationAngleXBase+j*angleDiffCombined*pi/180
                  rotY=rotationAngleYBase+l*angleDiffCombined*pi/180
                  rotZ=rotationAngleZBase+k*angleDiffCombined*pi/180
                  folder=paste(baseFolderWithBG,"combined\\",sep="")
                  fileName=paste(modelNumber,"_",orientation,
                                 "_x_",j*angleDiffCombined+addBaseAngle*rotationAngleXBase,
                                 "_y_",l*angleDiffCombined+addBaseAngle*rotationAngleYBase,
                                 "_z_",k*angleDiffCombined+addBaseAngle*rotationAngleZBase,
                                 sep="")
                  drawCubeFigure(bottomLeftPoints,pixelDiameter,pointColors,background,rotX,rotY,rotZ,borderColor,colors,folder,fileName,fileFormat,showOcclusions)
                  #file generation output
                  if(showFiles) {
                    writeLines(paste("Output file generated:",folder,fileName,".",fileFormat,sep=""))
                  }
                }
              }
            }
          }
          #time output
          if (showTimes) {
            writeLines(paste("\nTime elapsed for model ", modelNumber, " ", orientation ," ", backgroundColor, " background, ", colorString, " color:",sep=""))
            print(proc.time()-startTimeModelBackgroundOrientation)
          }
        }
      }
    }
    #model processing output
    if (showModels) {
      writeLines(paste("Model ",modelNumber, " finished!",sep=""))
    }
  }
  #time output
  if (showTimes) {
    writeLines(paste("\nTime elapsed total",sep=""))
    print(proc.time()-startTimeTotal)
  }
}
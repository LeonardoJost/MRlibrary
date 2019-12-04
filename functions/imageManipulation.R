### All functions regarding drawing and rotation of figures and points
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


library(magick)

#add two 3d values
addPoints3d=function(point1,point2) {
  #return(c(round(point1[1]+point2[1]),round(point1[2]+point2[2]),round(point1[3]+point2[3])))
  return(c(point1[1]+point2[1],point1[2]+point2[2],point1[3]+point2[3]))
}

#rotate point around three axes
#careful: order of rotations changes results!
rotatePoint=function(point3d,rotationAngleX,rotationAngleY,rotationAngleZ) {
  point3d=rotatePointX(point3d,rotationAngleX)
  point3d=rotatePointZ(point3d,rotationAngleZ)
  point3d=rotatePointY(point3d,rotationAngleY)
  return(point3d)
}
#single rotation axis 
rotatePointX=function(point3d,rotationAngleX) {
  return(c(point3d[1],
           cos(rotationAngleX)*point3d[2]-sin(rotationAngleX)*point3d[3],
           sin(rotationAngleX)*point3d[2]+cos(rotationAngleX)*point3d[3]))
}
#single rotation axis 
rotatePointY=function(point3d,rotationAngleY) {
  return(c(cos(rotationAngleY)*point3d[1]+sin(rotationAngleY)*point3d[3],
           point3d[2],
           -sin(rotationAngleY)*point3d[1]+cos(rotationAngleY)*point3d[3]))
}
#single rotation axis 
rotatePointZ=function(point3d,rotationAngleZ) {
  return(c(cos(rotationAngleZ)*point3d[1]-sin(rotationAngleZ)*point3d[2],
           sin(rotationAngleZ)*point3d[1]+cos(rotationAngleZ)*point3d[2],
           point3d[3]))
}

#draw Parallelogram from 2d points
drawParallelogram=function(bottomLeft,bottomRight,topRight,topLeft,colorLines,colorFill) {
  xs=c(bottomLeft[1],bottomRight[1],topRight[1],topLeft[1])
  #transfer to 2d
  ys=c(bottomLeft[3],bottomRight[3],topRight[3],topLeft[3])
  polygon(xs,ys,col=colorFill,border=colorLines)
}

#draw line between two 2d points
drawLine=function(point1,point2,colorLines) {
  segments(point1[1],point1[2],point2[1],point2[2],col=colorLines)
}
#draw cube, given bottom left point and distances and angles
drawCubeBottomLeft=function(bottomLeft,distance,rotationAngleX,rotationAngleY,rotationAngleZ,colorLines,colorFill,visibleFaces) {
  #get other corners
  pointsAsMatrix=getRotatedCube(bottomLeft,distance,rotationAngleX,rotationAngleY,rotationAngleZ)
  #draw visible faces of cube
  drawVisibleFacesMatrix(pointsAsMatrix,colorLines,colorFill,visibleFaces)
  if(showDimensionExceed) {
    maximalExtensionXZ=max(abs(pointsAsMatrix[c(1,3),]))
  } else {
    maximalExtensionXZ=0
  }
  return(maximalExtensionXZ)
}
#calculate coordinates of rotated cube
getRotatedCube=function(bottomLeft,distance,rotationAngleX,rotationAngleY,rotationAngleZ) {
  #rotate distance vector
  distanceX=rotatePoint(c(distance,0,0),rotationAngleX,rotationAngleY,rotationAngleZ)
  distanceY=rotatePoint(c(0,distance,0),rotationAngleX,rotationAngleY,rotationAngleZ)
  distanceZ=rotatePoint(c(0,0,distance),rotationAngleX,rotationAngleY,rotationAngleZ)
  #calculate other corners
  bottomRight=addPoints3d(bottomLeft,distanceX)
  topRight=addPoints3d(bottomRight,distanceZ)
  topLeft=addPoints3d(bottomLeft,distanceZ)
  bottomLeftBack=addPoints3d(bottomLeft,distanceY)
  bottomRightBack=addPoints3d(bottomLeftBack,distanceX)
  topRightBack=addPoints3d(bottomRightBack,distanceZ)
  topLeftBack=addPoints3d(bottomLeftBack,distanceZ)
  #return as matrix
  return(matrix(c(bottomLeft,bottomRight,topRight,topLeft,bottomLeftBack,bottomRightBack,topRightBack,topLeftBack),nrow=3))
}
#draw visible faces of a cube
drawVisibleFaces=function(a,b,c,d,e,f,g,h,colorLines,colorFill,visibleFaces) {
  #points as matrix
  pointsAsMatrix=matrix(c(a,b,c,d,e,f,g,h),nrow=3,ncol=8)
  drawVisibleFacesMatrix(pointsAsMatrix,colorLines,colorFill,visibleFaces)
}
#draw visible faces of a cube
drawVisibleFacesMatrix=function(pointsAsMatrix,colorLines,colorFill,visibleFaces) {
  if(missing(visibleFaces)) 
    visibleFaces=getVisibleFacesMatrix(pointsAsMatrix)
  #print(pointsAsMatrix)
  #print(visibleFaces)
  #faces of cube
  #abcd (front)
  #bfgh (left)
  #aehd (right)
  #abfe (bottom)
  #dcgh (top)
  #efgh (back)
  faces=matrix(c(c(1,2,3,4),c(2,6,7,3),c(1,5,8,4),c(1,2,6,5),c(4,3,7,8),c(5,6,7,8)),ncol=6,nrow=4)
  #draw all visible faces
  for(i in visibleFaces){
    #draw face
    drawParallelogram(pointsAsMatrix[,faces[,i][1]],
                      pointsAsMatrix[,faces[,i][2]],
                      pointsAsMatrix[,faces[,i][3]],
                      pointsAsMatrix[,faces[,i][4]],
                      colorLines,colorFill)
  }
}
#calculate visible faces of a cube
getVisibleFaces=function(a,b,c,d,e,f,g,h) {
  #points as matrix
  pointsAsMatrix=matrix(c(a,b,c,d,e,f,g,h),nrow=3,ncol=8)
  return(getVisibleFacesMatrix(pointsAsMAtrix))
}
#calculate visible faces of a cube
getVisibleFacesMatrix=function(pointsAsMatrix) {
  #print(pointsAsMatrix)
  #faces of cube
  #abcd (front)
  #bfgh (left)
  #aehd (right)
  #abfe (bottom)
  #dcgh (top)
  #efgh (back)
  faces=matrix(c(c(1,2,3,4),c(2,6,7,3),c(1,5,8,4),c(1,2,6,5),c(4,3,7,8),c(5,6,7,8)),ncol=6,nrow=4)
  #find foremost corners (y-direction)
  yArray=pointsAsMatrix[2,]
  yMins=which(yArray==min(yArray))
  #find all faces that match all corners in yMins 
  if(length(yMins)==1)
    return(which(apply(faces,2,function(face) yMins %in% face)))
  else
    return(which(colSums(apply(faces,2,function(face) yMins %in% face))==length(yMins)))
}
#draw a figure consisting of cubes and save it
drawCubeFigure=function(bottomLeftPoints,pixelDiameter,pointColors,background, rotX,rotY,rotZ,borderColor,colors,folder,fileName,fileFormat,showOcclusions) {
  #use background image, add limits
  img=image_draw(background,xlim=c(-imageSize/2+1,imageSize/2),ylim=c(-imageSize/2+1,imageSize/2))
  #rotate bottom left points
  bottomLeftPointsRotated=apply(bottomLeftPoints,2,function(point3d) rotatePoint(point3d,rotX,rotY,rotZ))
  #order points according to y axis to avoid occlusion (same y component means no occlusion anyway, order doesn't matter)
  newOrder=order(bottomLeftPointsRotated[2,],decreasing=TRUE)
  bottomLeftPointsRotated=bottomLeftPointsRotated[,newOrder]
  #order colors according to points
  pointColorsNewOrder=pointColors[newOrder]
  #draw points, if no cubes are supposed to be drawn, else draw a cube for each point
  if (pixelDiameter==1)
  {
    #warning if points lie outside of image boundary (botoom left points are all points)
    if(showDimensionExceed) {
      maximalExtensionXZ=max(abs(bottomLeftPointsRotated[c(1,3),]))
      if(round(maximalExtensionXZ)-imageSize/2>0) {
        writeLines(paste("Warning! Some points could not be drawn in file ",folder,fileName,".",fileFormat,
                         "\nMaximal values are ",round(maximalExtensionXZ-imageSize/2)," pixels outside of image border",sep=""))
      }
      if(round(maximalExtensionXZ)-imageSize/2==0) {
        writeLines(paste("Warning! Some points in file ",folder,fileName,".",fileFormat,
                         "\n lie exactly on the image border. Please inspect manually. (Image contains an even number of pixels so center is not symmetric)",sep=""))
      }
    }
    #draw points
    points(bottomLeftPointsRotated[1,],bottomLeftPointsRotated[3,],col=colors[pointColorsNewOrder],type="p",pch=".")
  } else {
    #rotate unit cube to get visible faces (same orientation for all)
    unitCube=getRotatedCube(c(0,0,0),1,rotX,rotY,rotZ)
    visibleFacesUnitCube=getVisibleFacesMatrix(unitCube)
    #if length(visibleFacesUnitCube)<3 -> occlusion occurs
    if(showOcclusions && length(visibleFacesUnitCube)<3) {
      writeLines(paste("\nocclusion occurs, only ",length(visibleFacesUnitCube)," faces visible",
                       "\nrotation Angle X: ", rotX*180/pi,
                       "\nrotation Angle Y: ", rotY*180/pi,
                       "\nrotation Angle Z: ", rotZ*180/pi,
                       "\noutput file is:\n",
                       folder,fileName,".",fileFormat,sep=""))
    }
    #draw cubes
    maximalExtensionXZ=0
    for(i in 1:ncol(bottomLeftPointsRotated)) {
      maximalExtensionXZ=max(maximalExtensionXZ,drawCubeBottomLeft(bottomLeftPointsRotated[,i],pixelDiameter,rotX,rotY,rotZ,borderColor,colors[pointColorsNewOrder[i]],visibleFacesUnitCube))
    }
    #warning if points lie outside of image boundary (inside drawCubeBottomLeft since all corners of the cubes must be checked)
    if(showDimensionExceed && round(maximalExtensionXZ)-imageSize/2>0) {
        writeLines(paste("Warning! Some points could not be drawn in file ",folder,fileName,".",fileFormat,
                         "\nMaximal values are ",round(maximalExtensionXZ-imageSize/2)," pixels outside of image border",sep=""))
    }
    if(showDimensionExceed && round(maximalExtensionXZ)-imageSize/2==0) {
      writeLines(paste("Warning! Some points in file ",folder,fileName,".",fileFormat,
                       "\n lie exactly on the image border. Please inspect manually. (Image contains an even number of pixels so center is not symmetric)",sep=""))
    }
  }
  #save image
  image_write(img, path = paste(folder,fileName,".", fileFormat,sep=""), format = fileFormat)
  #free space for next image
  dev.off()
  gc()
}
#show a cube figure 
showCubeFigure=function(bottomLeftPoints,pixelDiameter,pointColors,background, rotX,rotY,rotZ,borderColor,colors,shift=c(0,0,0)) {
  #use background image, add limits
  img=image_draw(background,xlim=c(-imageSize/2+1,imageSize/2),ylim=c(-imageSize/2+1,imageSize/2))
  #rotate bottom left points
  bottomLeftPointsRotated=apply(bottomLeftPoints,2,function(point3d) rotatePoint(point3d,rotX,rotY,rotZ))
  #order points according to y axis to avoid occlusion (same y component means no occlusion anyway, order doesn't matter)
  newOrder=order(bottomLeftPointsRotated[2,],decreasing=TRUE)
  bottomLeftPointsRotated=bottomLeftPointsRotated[,newOrder]+shift
  pointColorsNewOrder=pointColors[newOrder]
  if (pixelDiameter==1)
  {
    #draw points
    points(bottomLeftPointsRotated[1,],bottomLeftPointsRotated[3,],col=colors[pointColorsNewOrder],type="p",pch=".")
  } else {
    #rotate unit cube to get visible faces (same orientation for all)
    unitCube=getRotatedCube(c(0,0,0),1,rotX,rotY,rotZ)
    visibleFacesUnitCube=getVisibleFacesMatrix(unitCube)
    #if length(visibleFacesUnitCube)<3 -> occlusion occurs
    if(length(visibleFacesUnitCube)<3) {
      writeLines(paste("\nocclusion occurs, only ",length(visibleFacesUnitCube)," faces visible",
                       "\nrotation Angle X: ", rotX*180/pi,
                       "\nrotation Angle Y: ", rotY*180/pi,
                       "\nrotation Angle Z: ", rotZ*180/pi,sep=""))
    }
    #draw cubes
    for(i in 1:ncol(bottomLeftPointsRotated)) {
      drawCubeBottomLeft(bottomLeftPointsRotated[,i],pixelDiameter,rotX,rotY,rotZ,borderColor,colors[pointColorsNewOrder[i]],visibleFacesUnitCube)
    }
  }
  #free space for next image
  dev.off()
  gc()
  return(img)
}
#show a figure, drawing only the given points
showPointFigure=function(pointCoordinates,pointColors,background, rotX,rotY,rotZ,colors,shift=c(0,0,0)) {
  #use background image, add limits
  img=image_draw(background,xlim=c(-imageSize/2+1,imageSize/2),ylim=c(-imageSize/2+1,imageSize/2))
  #rotate bottom left points
  pointsRotated=apply(pointCoordinates,2,function(point3d) rotatePoint(point3d,rotX,rotY,rotZ))
  #order points according to y axis to avoid occlusion (same y component means no occlusion anyway, order doesn't matter)
  newOrder=order(pointsRotated[2,],decreasing=TRUE)
  pointsRotated=pointsRotated[,newOrder]+shift
  pointColorsNewOrder=pointColors[newOrder]
  #draw points
    points(pointsRotated[1,],pointsRotated[3,],col=colors[pointColorsNewOrder],type="p",pch=".")
  #free space for next image
  dev.off()
  gc()
  return(img)
}

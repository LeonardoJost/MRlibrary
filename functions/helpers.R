### Supporting functions, which fit no category
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

#create directory structure
createDirs=function(folder,subfolders) {
  for(subfolder in subfolders) {
    if (!dir.exists(file.path(folder,subfolder))) {
      dir.create(file.path(folder,subfolder),recursive=TRUE)
    }
  }
}

#get matrix of points on a line between two points
#used only for generating custom models
getLineMatrix=function(xs,ys,zs,sinFactor=0,waves=1) {
  maxDiff=max(abs(xs[2]-xs[1]),abs(ys[2]-ys[1]),abs(zs[2]-zs[1]))
  if(maxDiff==0)
    return(NULL)
  lineMatrix=matrix(rep(0,3*(maxDiff+1)),nrow=3)
  lineMatrix[1,]=round(xs[1]+0:maxDiff*(xs[2]-xs[1])/maxDiff)
  lineMatrix[2,]=round(ys[1]+0:maxDiff*(ys[2]-ys[1])/maxDiff)
  lineMatrix[3,]=round(zs[1]+0:maxDiff*(zs[2]-zs[1])/maxDiff)
  if (xs[2]==xs[1])
    lineMatrix[1,]=addSinPerturbation(lineMatrix[1,],sinFactor,waves)
  if (ys[2]==ys[1])
    lineMatrix[2,]=addSinPerturbation(lineMatrix[2,],sinFactor,waves)
  if (zs[2]==zs[1])
    lineMatrix[3,]=addSinPerturbation(lineMatrix[3,],sinFactor,waves)
  return(lineMatrix)
}

#add sine perturbation to a vector
#used only for generating custom models
addSinPerturbation=function(vec,sinFactor,waves=1) {
  vec=vec+sinFactor*sin(0:(length(vec)-1)/(length(vec)-1)*2*pi*waves)
  return(vec)
}

#adds the line connection between points to an existing matrix of points
#used only for generating custom models
addPointsToMatrix=function(gridMatrix,xs,ys,zs,sinFactor=0,waves=1) {
  for(i in 1:length(xs)){
    j=i%%length(xs)+1
    gridMatrix=cbind(gridMatrix,getLineMatrix(c(xs[i],xs[j]),c(ys[i],ys[j]),c(zs[i],zs[j]),sinFactor,waves))
  }
  return(gridMatrix)
}

#adding a face as 3d points, does not work perfectly, but ok for demonstration
#used only for generating custom models
addFaceToMatrix=function(gridMatrix,xs,ys,zs) {
  for(x in min(xs):max(xs)) {
    for(y in min(ys):max(ys)) {
      for(z in min(zs):max(zs)) {
        gridMatrix=cbind(gridMatrix,c(x,y,z))
      }
    }
  }
  return(gridMatrix)
}

#show multiple figures in one image
#only used by customImages.R
#uses parameters, which are set only in customImages.R
showImages=function(){
  #set background color
  img=image_fill(background, backgroundColor, point = "+0+0", fuzz = 100)
  for(i in 1:nrow(pos)){
    #add single Figure to img
    #get base model
    bottomLeftPoints=centerModel(getModel(modelNumber,usePetersBattistaModels),centering)
    #adjust length
    bottomLeftPoints=bottomLeftPoints*pixelDiameter
    #get coloring
    pointColors=getColors(modelNumber,colors,usePetersBattistaModels)
    #angles
    rotX=rotationAngleXBase+angles[i,1]*pi/180
    rotY=rotationAngleYBase+angles[i,2]*pi/180
    rotZ=rotationAngleZBase+angles[i,3]*pi/180
    #mirror, if needed
    orientation=orientations[i]
    if(orientation=="b") { #mirror along yz-plane (x-axis is reversed)
      bottomLeftPoints[1,]=-bottomLeftPoints[1,]
    } else if(orientation=="c") { #mirror along xz-plane (y-axis is reversed)
      bottomLeftPoints[2,]=-bottomLeftPoints[2,]
    } else if(orientation=="d") { #mirror along xy-plane (z-axis is reversed)
      bottomLeftPoints[3,]=-bottomLeftPoints[3,]
    }
    #add shift to position
    img=showCubeFigure(bottomLeftPoints,pixelDiameter,pointColors,img,rotX,rotY,rotZ,borderColor,colors,pos[i,]*pixelDiameter)
  }
  return(img)
}

### Generates models
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


#get the coordinates of the model
getModel=function(number,petersBattista){
  if(petersBattista)
    return(getModelPetersBattista(number))
  if(number==1){
    #custom cube figure
    return(matrix(c(1,1,0,
                    1,0,0,
                    0,0,0,
                    -1,0,0,
                    -2,0,0,
                    -2,0,1,
                    -2,0,2,
                    -2,0,3,
                    -2,-1,3,
                    -2,-2,3,
                    -2,-2,2,
                    -2,-2,1),
                  nrow=3))
  }else if(number==2){
    #custom model for testing purposes: grid figure
    pointModelSize=70
    gridMatrix=NULL
    #foreside
    xs=c(0,1,1,2,2,0)*pointModelSize
    ys=c(0,0,0,0,0,0)*pointModelSize
    zs=c(0,0,-1,-1,1,1)*pointModelSize
    gridMatrix=addPointsToMatrix(gridMatrix,xs,ys,zs)
    #backside
    xsBack=c(0,1,1,2,2,0)*pointModelSize
    ysBack=(c(0,0,0,0,0,0)+1)*pointModelSize
    zsBack=c(0,0,-1,-1,1,1)*pointModelSize
    gridMatrix=addPointsToMatrix(gridMatrix,xsBack,ysBack,zsBack)
    #connecting lines
    for(i in 1:length(xs)){
      gridMatrix=addPointsToMatrix(gridMatrix,c(xs[i],xsBack[i]),c(ys[i],ysBack[i]),c(zs[i],zsBack[i]))
    }
    return(gridMatrix)
  }else if(number==3){
    #custom model for testing purposes: grid figure with sine perturbations
    pointModelSize=70
    gridMatrix=NULL
    #foreside
    xs=c(0,1,1,2,2,0)*pointModelSize
    ys=c(0,0,0,0,0,0)*pointModelSize
    zs=c(0,0,-1,-1,1,1)*pointModelSize
    gridMatrix=addPointsToMatrix(gridMatrix,xs,ys,zs,5,2)
    #backside
    xsBack=c(0,1,1,2,2,0)*pointModelSize
    ysBack=(c(0,0,0,1,-1,0)+1)*pointModelSize
    zsBack=c(0,0,-1,-1,1,1)*pointModelSize
    gridMatrix=addPointsToMatrix(gridMatrix,xsBack,ysBack,zsBack,3,5)
    #connecting lines
    for(i in 1:length(xs)){
      gridMatrix=addPointsToMatrix(gridMatrix,c(xs[i],xsBack[i]),c(ys[i],ysBack[i]),c(zs[i],zsBack[i]))
    }
    #connecting faces
    faceBoundary=c(1,6)
    gridMatrix=addFaceToMatrix(gridMatrix,c(xs[faceBoundary],xsBack[faceBoundary]),
                               c(ys[faceBoundary],ysBack[faceBoundary]),
                               c(zs[faceBoundary],zsBack[faceBoundary]))
    faceBoundary=c(1,2,6)
    gridMatrix=addFaceToMatrix(gridMatrix,c(xs[faceBoundary]),
                               c(ys[faceBoundary]),
                               c(zs[faceBoundary]))
    return(gridMatrix)
  } else {
    return(matrix(c(sample(-3:3,30,replace=T)),
                  nrow=3))
  }
}

#get the colors for the model
getColors=function(number,colors,petersBattista,numberOfPoints=0) {
  if(petersBattista)
    return(getColorsPetersBattista(number,colors))
  if(numberOfPoints==0)
    numberOfPoints=ncol(getModel(number,petersBattista))
  return(c(0:(numberOfPoints-1)%%length(colors)+1))
}

#apply centering to a model
centerModel=function(bottomLeftPoints, type){
  if(type=="none") {
    center=0
  } else if(type=="weight") {
    #by weight
    center=apply(bottomLeftPoints,1,mean)+c(rep(0.5,3))
  } else {
    #optical
    maxs=apply(bottomLeftPoints,1,max)+1 #+1 because of bottomlefts
    mins=apply(bottomLeftPoints,1,min)
    center=(maxs+mins)/2
  }
  return(bottomLeftPoints-center)
}

### this routine is used for creating custom images, sometimes composing of multiple figures, used for all figures in the paper
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

#load all supporting functions
source("functions/helpers.R")
source("functions/mainLoops.R")
source("functions/imageManipulation.R")
source("functions/petersBattistaModels.R")
source("functions/customModels.R")

#set parameters
source("functions/parameters.R")
#change some parameters
baseFolder="figs\\"
centering="none"
backgroundColor='black'
modelNumber=1
pixelDiameter=40
backgroundImage='data\\background.png'
fileFormat="tiff"
imageSize=720
rotationAngleXBase=-30*pi/180
rotationAngleYBase=0*pi/180
rotationAngleZBase=15*pi/180
usePetersBattistaModels=TRUE
colors=c('grey','white')

#load blank image
backgroundFromFile=image_read(backgroundImage)
background=image_scale(backgroundFromFile,imageSize)

### experimental setup
#number of figures should be number of rows in pos and angles and number of elements in orientations
#positions:
pos=matrix(c(c(-2,0,1),
             c(2,0,1),
             c(0,0,-1)),
           nrow=3)
#multiply
pos=pos*3
#shift
pos=pos+c(0,0,0)
pos=t(pos)
angles=t(matrix(c(c(0,0,0),
                  c(0,0,0),
                  c(0,45,0)),
                nrow=3))
orientations=c("a","b","a")
img=showImages()
#show figure
print(img)
#save image
image_write(img, path = paste(baseFolder,"Setup",".", fileFormat,sep=""), format = fileFormat)

### 180 degrees and mirror demo
#number of figures should be number of rows in pos and angles and number of elements in orientations
#positions:
pos=matrix(c(c(-2,0,1),
             c(2,0,1),
             c(0,0,-1)),
           nrow=3)
#multiply
pos=pos*3
#shift
pos=pos+c(0,0,0)
pos=t(pos)
angles=t(matrix(c(c(0,0,0),
                  c(0,0,0),
                  c(0,180,0)),
                nrow=3))
orientations=c("a","b","a")
img=showImages()
#show figure
print(img)
#save image
image_write(img, path = paste(baseFolder,"Setup180y",".", fileFormat,sep=""), format = fileFormat)

### 180 degrees and mirror demo
#number of figures should be number of rows in pos and angles and number of elements in orientations
#positions:
pos=matrix(c(c(-2,0,1),
             c(2,0,1),
             c(0,0,-1)),
           nrow=3)
#multiply
pos=pos*3
#shift
pos=pos+c(0,0,0)
pos=t(pos)
angles=t(matrix(c(c(0,0,0),
                  c(0,0,0),
                  c(0,0,180)),
                nrow=3))
orientations=c("a","b","a")
img=showImages()
#show figure
print(img)
#save image
image_write(img, path = paste(baseFolder,"Setup180z",".", fileFormat,sep=""), format = fileFormat)

### experimental setup alternative A
#number of figures should be number of rows in pos and angles and number of elements in orientations
#positions:
pos=matrix(c(c(-2,0,0),
             c(2,0,0),
             c(0,0,0)),
           nrow=3)
#multiply
pos=pos*3
#shift
pos=pos+c(0,0,0)
pos=t(pos)
angles=t(matrix(c(c(0,0,0),
                  c(0,0,0),
                  c(0,45,0)),
                nrow=3))
orientations=c("a","b","a")
img=showImages()
#show figure
print(img)
#save image
image_write(img, path = paste(baseFolder,"SetupA",".", fileFormat,sep=""), format = fileFormat)

### experimental setup alternative B
#number of figures should be number of rows in pos and angles and number of elements in orientations
#positions:
pos=matrix(c(c(-1,0,1),
             c(-1,0,-1),
             c(1,0,0)),
           nrow=3)
#multiply
pos=pos*3
#shift
pos=pos+c(0,0,0)
pos=t(pos)
angles=t(matrix(c(c(0,0,0),
                  c(0,0,0),
                  c(0,45,0)),
                nrow=3))
orientations=c("a","d","a")
img=showImages()
#show figure
print(img)
#save image
image_write(img, path = paste(baseFolder,"SetupB",".", fileFormat,sep=""), format = fileFormat)

#use centering for combining 4 figures
centering="optical"
###rotational axes
#number of figures should be number of rows in pos and angles and number of elements in orientations
#positions:
pos=matrix(c(c(-1,0,1),
             c(1,0,1),
             c(-1,0,-1),
             c(1,0,-1)),
           nrow=3)
#multiply
pos=pos*5
#shift
pos=pos+c(0,0,0)
pos=t(pos)
angles=t(matrix(c(c(0,0,0),
                  c(45,0,0),
                  c(0,45,0),
                  c(0,0,45)),
                nrow=3))
orientations=c("a","a","a","a")
img=showImages()
#show figure
print(img)
#save image
image_write(img, path = paste(baseFolder,"xyz",".", fileFormat,sep=""), format = fileFormat)

###different mirrorings
#number of figures should be number of rows in pos and angles and number of elements in orientations
#positions:
pos=matrix(c(c(-1,0,1),
             c(1,0,1),
             c(1,0,-1),
             c(-1,0,-1)),
           nrow=3)
#multiply
pos=pos*5
#shift
pos=pos+c(0,0,0)
pos=t(pos)
angles=t(matrix(c(c(0,0,0),
                  c(0,0,0),
                  c(0,0,0),
                  c(0,0,0)),
                nrow=3))
orientations=c("a","b","c","d")
img=showImages()
#show figure
print(img)
#save image
image_write(img, path = paste(baseFolder,"abcd",".", fileFormat,sep=""), format = fileFormat)

###rotational axes and mirrorings next to each other
#number of figures should be number of rows in pos and angles and number of elements in orientations
#positions:
pos=matrix(c(c(-1,0,1),
             c(1,0,1),
             c(-1,0,-1),
             c(1,0,-1)),
           nrow=3)
#multiply
pos=pos*4
#shift
pos=pos+c(0,0,0)
pos=t(pos)
angles=t(matrix(c(c(0,0,0),
                  c(0,0,0),
                  c(180,0,0),
                  c(0,0,180)),
                nrow=3))
orientations=c("a","b","a","a")
img=showImages()
#show figure
print(img)
#save image
image_write(img, path = paste(baseFolder,"abxz",".", fileFormat,sep=""), format = fileFormat)

###figure made of individual pixels instead of cubes
#number of figures should be number of rows in pos and angles and number of elements in orientations
#parameter changes
colors=rep(c('red','blue','yellow','purple','orange','yellow'),each=10)
backgroundColor='white'
modelNumber=3
usePetersBattistaModels=FALSE
pixelDiameter=1
#positions:
pos=matrix(c(c(-1,0,1),
             c(1,0,1),
             c(-1,0,-1),
             c(1,0,-1)),
           nrow=3)
#multiply
pos=pos*210
#shift
pos=pos+c(0,0,0)
pos=t(pos)
angles=t(matrix(c(c(0,0,0),
                  c(0,0,0),
                  c(180,0,0),
                  c(0,0,180)),
                nrow=3))
orientations=c("a","b","a","a")
img=showImages()
#show figure
print(img)
#save image
image_write(img, path = paste(baseFolder,"compoundFigure",".", fileFormat,sep=""), format = fileFormat)

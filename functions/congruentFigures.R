### Compare different figures for congruency
#     Copyright (C) 2020  Leonardo Jost
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
source("functions/parametersDefault.R")
#change some parameters
baseFolder="figs\\comparisons\\"
modelNumber=1
pixelDiameter=20
backgroundImage='data\\background.png'
fileFormat="png"
imageSize=720
rotationAngleXBase=0
rotationAngleYBase=0
rotationAngleZBase=0
usePetersBattistaModels=TRUE
colors=c('grey','white')
centering="optical"
#load blank image
backgroundFromFile=image_read(backgroundImage)
background=image_scale(backgroundFromFile,imageSize)

#use different models to create the same figures
#left: models 1 and 2
#right: models 8, 9, 10, and 11
#positions:
pos=matrix(c(c(-2,0,1),
             c(-2,0,0),
             c(0,0,2),
             c(0,0,1),
             c(0,0,0),
             c(0,0,-1)),
           nrow=3)
#shift
pos=pos+c(0,0,0.5)
#multiply
pos=pos*6
pos=t(pos)
angles=t(matrix(c(c(15,0,15),
                  c(15,95,195),
                  c(15,0,15),
                  c(-105,0,195),
                  c(-105,95,15),
                  c(75,0,195)),
                nrow=3))
orientations=c("a","a","a","b","b","a")
multipleModelsNumber=c(1,2,8,9,10,11) #figures are created from different models
img=showImages(TRUE)
#show figure
print(img)
#save image
image_write(img, path = paste(baseFolder,"12-891011",".", fileFormat,sep=""), format = fileFormat)

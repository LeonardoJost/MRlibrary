### List of parameters for main program
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


## Warning: No Sanity Checks are performed for most parameters
## Bad choices might lead to undesired behavior or infinite loops
## Activate runtime output parameters to check program behavior during runtime

##color Options
#background Colors: for all Elements of backgroundColors, all Stimuli will be created
#if no background coloring is desired, use 'none', the background image will be kept the way it is
backgroundColors=c('white','black')
#color of the borders of the cubes
borderColor='black'
#list of vector of colors (output will be generated for each element of the list)
#c('white','grey') for checkered pattern (more than 2 possible)
#order of colors matters
#colors can also be specified by "#rrggbb"
colorList=list('white',c('white','grey'))


##folders and formats
#base Folder for output relative to working directory
baseFolder="figs\\"
#Use angle differences to base angle or total rotation angle for naming output files?
addBaseAngle=FALSE
#image to use as a starting point for the background
backgroundImage='data\\background.png'
#file format of images, all image types supported by magick should be possible
fileFormat="png"
#width of image (height is adjusted accordingly, use quadratic images for best results)
imageSize=720
#cube diameter in pixels
#use pixelDiameter=1 if only the points are supposed to be drawn
pixelDiameter=70
#calculate rotations by 0 degrees for each axis?
#unrotated base models are always saved, this option saves another copy for every axis
zeroRotations=FALSE

##model parameters
#list of orientations
#a - original
#b - mirrored along yz-plane
#c - mirrored along xz-plane
#d - mirrored along xy-plane
#add all desired orientations to vector
orientations=c("a","b")
#center models in image?
#options: "none","weight","optical"
centering="optical"
#rotation angles of base image (in rad)
rotationAngleXBase=-30*pi/180
rotationAngleYBase=0*pi/180
rotationAngleZBase=15*pi/180
#difference between two angles in single axis rotations in deg
angleDiff=15
#calculate combined rotations?
combinedRotations=TRUE
#difference between two angles in combined condition using all three rotational axes at once
#number of images generated increases by power of 3, at 45° (7 different angles) 7^3=343 images are generated
angleDiffCombined=45
#which models to use
modelNumbers=1:16
#use models similar to the library of Peters and Battista (2008) or custom models?
usePetersBattistaModels=TRUE

##runtime output
#give output whenever occlusions occur?
showOcclusions=FALSE
#show timing
showTimes=TRUE
#show output files as they are generated
showFiles=FALSE
#show which model is being processed
showModels=TRUE
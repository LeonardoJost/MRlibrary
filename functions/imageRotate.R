### Generates picture-plane rotation of given images, not used anymore
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
#generate picture plane rotated images
#of all images in folder
#rotated stepwise by angleDiff
getRotatedBaseImages=function(folder,angleDiff){
  #list of angles to use
  angles=1:ceiling(360/angleDiff-1)
  #get filenames in folder
  fileNames=as.list(dir(path=folder))
  #loop over files
  for(fileName in fileNames) {
    #load base image, set background to avoid white corners when rotating
    baseImage=image_read(paste(folder,"\\",fileName,sep="")) %>%
      image_background("none")
    #loop over angles
    for(angle in angles){
      #always rotate original image, then save image
      angle=angle*angleDiff
      image_rotate(baseImage,angle) %>%
        image_crop("720x720") %>%
        image_write( path = paste(folder,"\\",strsplit(paste(fileName),"\\.")[[1]][1],angle,".",strsplit(paste(fileName),"\\.")[[1]][2],sep=""))
      #force garbage collection, important to prevent slowdown
      gc()
    }
  }
}

### Generates Models as in the library of Peters and Battista (2008)
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
getModelPetersBattista=function(number){
  if(number==1){
    return(matrix(c(1,1,0,
                    1,0,0,
                    0,0,0,
                    -1,0,0,
                    -2,0,0,
                    -2,0,1,
                    -2,0,2,
                    -2,0,3,
                    -2,-1,3,
                    -2,-2,3),
                  nrow=3))
  } else if(number==2) {
    return(matrix(c(1,2,0,
                    1,1,0,
                    1,0,0,
                    0,0,0,
                    -1,0,0,
                    -2,0,0,
                    -2,0,1,
                    -2,0,2,
                    -2,0,3,
                    -2,-1,3),
                  nrow=3))
  } else if(number==3) {
    return(matrix(c(1,0,-1,
                    1,0,0,
                    0,0,0,
                    -1,0,0,
                    -2,0,0,
                    -2,0,1,
                    -2,0,2,
                    -2,0,3,
                    -2,-1,3,
                    -2,-2,3),
                  nrow=3))
  } else if(number==4) {
    return(matrix(c(1,0,-2,
                    1,0,-1,
                    1,0,0,
                    0,0,0,
                    -1,0,0,
                    -2,0,0,
                    -2,0,1,
                    -2,0,2,
                    -2,0,3,
                    -2,-1,3),
                  nrow=3))
  } else if(number==5) {
    return(matrix(c(1,0,-1,
                    1,0,0,
                    0,0,0,
                    -1,0,0,
                    -1,-1,0,
                    -1,-2,0,
                    -1,-3,0,
                    -1,-3,1,
                    -1,-3,2),
                  nrow=3))
  } else if(number==6) {
    return(matrix(c(1,0,-1,
                    1,0,0,
                    0,0,0,
                    -1,0,0,
                    -1,-1,0,
                    -1,-2,0,
                    -1,-3,0,
                    -1,-3,1,
                    -1,-3,2,
                    -1,-3,3),
                  nrow=3))
  } else if(number==7) {
    return(matrix(c(1,0,-3,
                    1,0,-2,
                    1,0,-1,
                    1,0,0,
                    0,0,0,
                    -1,0,0,
                    -1,-1,0,
                    -1,-2,0,
                    -1,-3,0,
                    -1,-3,1),
                  nrow=3))
  } else if(number==8) {
    return(matrix(c(1,2,0,
                    1,1,0,
                    1,0,0,
                    0,0,0,
                    -1,0,0,
                    -1,0,1,
                    -1,0,2,
                    -1,0,3,
                    -1,-1,3,
                    -1,-2,3),
                  nrow=3))
  } else if(number==9) {
    return(matrix(c(1,0,-2,
                    1,0,-1,
                    1,0,0,
                    0,0,0,
                    -1,0,0,
                    -1,-1,0,
                    -1,-2,0,
                    -1,-3,0,
                    -1,-3,1,
                    -1,-3,2),
                  nrow=3))
  } else if(number==10) {
    return(matrix(c(1,0,-2,
                    1,0,-1,
                    1,0,0,
                    0,0,0,
                    -1,0,0,
                    -2,0,0,
                    -2,-1,0,
                    -2,-2,0,
                    -2,-2,1,
                    -2,-2,2),
                  nrow=3))
  } else if(number==11) {
    return(matrix(c(1,3,-2,
                    1,3,-1,
                    1,3,0,
                    1,2,0,
                    1,1,0,
                    1,0,0,
                    0,0,0,
                    -1,0,0,
                    -1,0,1,
                    -1,0,2),
                  nrow=3))
  } else if(number==12) {
    return(matrix(c(1,2,-2,
                    1,2,-1,
                    1,2,0,
                    1,1,0,
                    1,0,0,
                    0,0,0,
                    -1,0,0,
                    -1,0,1,
                    -1,0,2,
                    -1,0,3),
                  nrow=3))
  } else if(number==13) {
    return(matrix(c(1,0,-1,
                    1,0,0,
                    0,0,0,
                    -1,0,0,
                    -2,0,0,
                    -2,0,1,
                    -2,0,2,
                    -2,0,3,
                    -2,0,4,
                    -2,-1,4),
                  nrow=3))
  } else if(number==14) {
    return(matrix(c(2,0,-1,
                    2,0,0,
                    1,0,0,
                    0,0,0,
                    -1,0,0,
                    -2,0,0,
                    -2,0,1,
                    -2,0,2,
                    -2,0,3,
                    -2,-1,3),
                  nrow=3))
  } else if(number==15) {
    return(matrix(c(2,0,-1,
                    2,0,0,
                    1,0,0,
                    0,0,0,
                    -1,0,0,
                    -1,-1,0,
                    -1,-2,0,
                    -1,-3,0,
                    -1,-4,0,
                    -1,-4,1),
                  nrow=3))
  } else if(number==16) {
    return(matrix(c(2,0,-1,
                    2,0,0,
                    1,0,0,
                    0,0,0,
                    -1,0,0,
                    -2,0,0,
                    -2,-1,0,
                    -2,-2,0,
                    -2,-3,0,
                    -2,-3,1),
                  nrow=3))
  }else {
    return(NULL)
  }
}

#get the colors for the model
getColorsPetersBattista=function(number,colors) {
  if (number %in% c(1,2,3,4,6,7,8,9,10,11,12,13,14,15,16))
    return(c(1:10%%length(colors)+1))
  else
    return(c(2:10%%length(colors)+1))
}


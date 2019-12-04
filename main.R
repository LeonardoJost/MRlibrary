###main program
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

##load all supporting functions
source("functions/helpers.R")
source("functions/mainLoops.R")
source("functions/imageManipulation.R")
source("functions/petersBattistaModels.R")
source("functions/customModels.R")

##set parameters
#load default values (if not all values are included in custom values)
source("functions/parametersDefault.R")
#load custom values
source("functions/parameters.R")

##generate all images according to parameters
generateAllImages()


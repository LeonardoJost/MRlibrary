# MRlibrary
This library consists of cube figures, which are commonly used in mental rotation tests. The pregenerated figures are similar to the ones in the library of Peters and Battista (2008). Moreover, the library can be used to selfgenerate different models, angles, colors, etc. Further description can be found in the accompanying paper...

## Usage of pregenerated figures
1. Open the figs folder.
2. There they are. (see Subfolders and naming structure)

## Usage to generate own figures
1. Create R project/set working directory.
2. Set parameters according to own wishes. The parameter file contains comments regarding the usage. While default values are a good baseline for testing as well as experiments, changes are suggested. Running the code with default parameters will just regenerate the pregenerated cube figures.
3. Run the main project file.
4. Wait.
5. The desired figures should now be located in the folder specified in the parameters. (see Subfolders and naming structure)

## Options, Properties, ...

### Subfolders and naming structure
Figures are arranged in a folder by subfolders for colors and for base figures and rotated figures. For each background color a subfolder of the name color_back exists, within which another subfolder containing the colors of the cubes exists for each combination of colors. The color folders are named after the only or the concatenation using "-" of the first two colors used. Within the color subfolders, there are even more subfolders for base figures and rotational axes (base,x,y,z, combined), where you will finally find the images. Each figure is named in the form modelNumber_orientation_rotationAxis_rotationAngle.

### Generate custom cube figures
To add a custom cube figure, open customModels.R and add or edit a return number. Specify all three dimensional coordinates of the bottom left corner of each cube in the returned matrix. The cubes should be ordered in a way that fits the coloring (if using multiple colors). The first cube will be colored in the first color, second in second color, and so on, with colors starting from the first color again after the last color is reached. Custom colorings can be specified in the getColors function. For examples of cube figure coordinates, see custom model 1 or all 16 models in petersBattistaModels.R.

### Generate custom noncube figures
To add custom noncube figures, proceed as with custom cube figures, just specify all points in three dimensions that are supposed to be drawn in the figure. Specify the colors of the points in the order of the points. Set the parameter pixelDiameter to 1 when drawing, otherwise a cube will be added on top of each point.

### Use background images
This one is easy. Specify your desired background image in the parameters and set the backgroundColor to 'none'. Use quadratic images to avoid skewed results.

### Use other angles/colors/orientations/centering...
These can all be modified by the parameters. Experiment with different combinations until you get the desired result. Do not ask for help. You can do it.

## Literature

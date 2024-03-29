# MRlibrary
This library contains cube figures, which are commonly used in mental rotation tests. The pregenerated figures are similar to the ones in the library of Peters and Battista (2008). Moreover, the library can be used to selfgenerate different models, angles, colors, etc. Further description can be found in the accompanying paper (Jost & Jansen, 2020). A linked OSF project is at https://osf.io/dr9mv/.

## Usage of pregenerated figures
The pregenerated figures are available in the linked OSF project as `pregenerated figures.zip` to avoid versioning large/many files on github. (see subfolders and naming structure to locate individual figures)

## Usage to generate own figures
1. Create R project/set working directory. Download/Clone the repository and open it as an R project or use the version control software of your choice to create an R project from this repository. Install magick package (Ooms, 2018) to your R distribution.
2. Set parameters according to own wishes. The parameter file contains comments regarding possible values and effects. While default values are a good baseline for testing as well as experiments, changes are suggested. Running the code with default parameters will just regenerate the pregenerated cube figures.
3. Run the main project file.
4. Wait. Depending on your parameter choices and computing power this might take from a few seconds to a few days.
5. The desired figures should now be located in the folder specified in the parameters. (see subfolders and naming structure)

## Options, Properties, ...

### Subfolders and naming structure
Figures are arranged in a folder by subfolders for colors and for base figures and rotated figures. For each background color a subfolder of the name color_back exists, within which another subfolder containing the colors of the cubes exists for each combination of colors. The color folders are named after the only or the concatenation using "-" of the first two colors used. Within the color subfolders, there are even more subfolders for base figures and rotational axes (base, x, y, z, combined), where you will finally find the images. Each figure is named in the form modelNumber_orientation_rotationAxis_rotationAngle. The rotationAxis_rotationAngle part is repeated 0-3 times as appropriate.

### Generate custom cube figures
To add a custom cube figure, open customModels.R and add or edit a return number. Specify all three dimensional coordinates of the bottom left corner of each cube in the returned matrix. The cubes should be ordered in a way that fits the coloring (if using multiple colors). The first cube will be colored in the first color, second in second color, and so on, with colors starting from the first color again after the last color is reached. Custom colorings can be specified in the getColors function. For examples of cube figure coordinates, see custom model 1 or all 16 models in petersBattistaModels.R. The parameter usePetersBattistaModels must be set to `FALSE`.

### Generate custom noncube figures
To add custom noncube figures, proceed as with custom cube figures, just specify all points in three dimensions that are supposed to be drawn in the figure (base R functions for reading files might be useful here). Specify the colors of the points in the order of the points. Set the parameter pixelDiameter to 1 when drawing, otherwise a cube will be added on top of each point. The parameter usePetersBattistaModels must be set to `FALSE`.

### Use other background images
Specify your desired background image in the parameters. The backgroundColor parameter will only apply to transparent parts of the picture. Use quadratic images to avoid skewed results.

### Use other angles/colors/orientations/centering...
These can all be modified by the parameters. Experiment with different combinations until you get the desired result.

### Advice/Background on Parameter choices
The default background is transparent and should work well for most cases instead of generating every file multiple times for different background colors.

Optical centering is performed by centering the bounding box of the figure. An alternative would be to center the bounding ball, as it is invariant to rotation. For typical figures, where the bounding box is spanned by diagonal elements, or for symmetric figures (e.g. x or + shapes), this makes no difference, but small differences (not necessarily improvements) are possible for very asymmetric figures (e.g. T shapes). Additionally, the bounding box is much easier to compute.

The default parameters differ in some places from the values used in Jost and Jansen (2020). This includes centering, size and base angles, which were chosen in part to be more comparable. Upon reflection, we have drafted these new suggestions as default. Not included in the default values is the additional advice to generate the pictures in the dimensions that are actually used to avoid artifacts from resizing.

### Congruency of figures
Note that some figures can be transformed into one another. This applies at least to figures 1 and 2 as well as 8, 9, 10, and 11 of the original library of Peters and Battista. The transformations between the figures can be recreated using the script congruentFigures.R. This may not be relevant for rotations around one axis but might be relevant for complex rotations and combining multiple models in one image (i.e. structural distractors).

## Other

### Coding Issues
The code works, but includes some questionable choices, needlessly complicated structure. This was mostly done for simplicity or convenience, but some issues shall be mentioned here: The parameters are set as global variables, whereas they could be local and moreover will sometimes appear under the same name as local parameters (although mostly using the same value). The program also relies on a somewhat blank background image, which could also be created in code by r low level graphics. As with all code, we have also included unconventional variable names and added comments where they are useless while omitting them where they would be useful.

### Unused functions
The project also includes some unused functions, which were nevertheless included and will be explained briefly:
#### CustomImages.R
This file was used to generate custom images, e.g. including more than one figure in a single image. The code can be used to recreate all images in Jost and Jansen (2020) or adapted for your own custom images.
#### ImageRotate.R
This function was used to generate picture plane rotations of given images. Where only these rotations are needed and complex models are used, this code will run faster than generating each figure from scratch. Mildly experienced programmers will probably know alternatives (such as imagemagick software, on which the here used magick package is based).

### Adaptation
Some simple adaptations, which can easily be done yourself: 
#### Change the order of rotation
Open ImageManipulation.R and change the order in rotatePoint function.

## Literature
Jost, L., & Jansen, P. (2020). A novel approach to analyzing all trials in chronometric mental rotation and description of a flexible extended library of stimuli. Spatial Cognition & Computation. DOI: 10.1080/13875868.2020.1754833

Ooms, J. (2018). magick: Advanced Graphics and Image-Processing in R. R package version 2.0. https://CRAN.R-project.org/package=magick

Peters, M., & Battista, C. (2008). Applications of mental rotation figures of the Shepard and Metzler type and description of a mental rotation stimulus library. Brain and cognition, 66(3), 260-264.

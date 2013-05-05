#
# Makefile for the Dome.Perimeter
#
# For this we're using processing.make
#

# The $(PWD) get the path of this Makefile. From this
# directory you can navigate to your sketch.
# This implementation is used as default parameter at the
# processing.make if no "SKETCH_DIRECTORY" parameter exist.
SKETCH_DIRECTORY = $(PWD)/DomePerimeter


# Custom export directory
EXPORT_FOLDERNAME = distribution

# Custom MacOSX export folder
EXPORT_MACOSX_FOLDERNAME = mac


include processing.make/processing.make

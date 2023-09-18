#! /bin/bash

DEBIAN_FRONTEND=noninteractive

# Clone Upstream
git clone https://github.com/KhronosGroup/Vulkan-Loader.git
cd Vulkan-Loader
git checkout v1.3.264
cp -rvf ../debian ./

# Get build deps
apt-get update
apt-get build-dep ./ -y

# Build package
# Build package
LOGNAME=root dh_make --createorig -y -l -p vulkan-loader_1.3.264.99pikaos
dpkg-buildpackage --no-sign

# Move the debs to output
cd ../
mkdir -p ./output
mv ./*.deb ./output/

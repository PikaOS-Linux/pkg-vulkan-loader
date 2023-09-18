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
dpkg-buildpackage --no-sign

# Move the debs to output
cd ../
mkdir -p ./output
mv ./*.deb ./output/

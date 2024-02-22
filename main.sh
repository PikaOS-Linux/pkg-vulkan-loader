#! /bin/bash

DEBIAN_FRONTEND=noninteractive

# Clone Upstream
git clone https://github.com/KhronosGroup/Vulkan-Loader.git
cd Vulkan-Loader
git checkout v1.3.278
mkdir vulkan-headers
git clone https://github.com/KhronosGroup/Vulkan-Headers.git ./vulkan-headers
cd vulkan-headers
git checkout v1.3.278
cd ..
rm -rf vulkan-headers/.git
git add -f vulkan-headers
git commit -m "Refresh vulkan-headers to v1.3.278"
cp -rvf ../debian ./
cd ..

# Get build deps
apt-get update
apt-get build-dep ./ -y

# Build package
# Build package
LOGNAME=root dh_make --createorig -y -l -p vulkan-loader_1.3.278.99pikaos
dpkg-buildpackage --no-sign

# Move the debs to output
cd ../
mkdir -p ./output
mv ./*.deb ./output/

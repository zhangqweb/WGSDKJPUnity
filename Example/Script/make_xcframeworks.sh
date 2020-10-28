#!/bin/sh -e

 
WORKING_DIR=$(pwd)

echo "--- path ${WORKING_DIR}"


OUTPUT_DIR="${WORKING_DIR}/xcframework"

rm -rf $OUTPUT_DIR
mkdir -p "${OUTPUT_DIR}"


SIMULATOR_PATH="${WORKING_DIR}/Build/Products/Release-iphonesimulator/WGSDKJPUnity/WGSDKJPUnity.framework"
DEVICE_PATH="${WORKING_DIR}/Build/Products/Release-iphoneos/WGSDKJPUnity/WGSDKJPUnity.framework"
#SIMULATOR_PATH="${WORKING_DIR}/Build/Products/Debug-iphonesimulator/WGSDK/WGSDK.framework"
#DEVICE_PATH="${WORKING_DIR}/Build/Products/Debug-iphoneos/WGSDK/WGSDK.framework"



 
echo "--- SIMULATOR_PATH ${SIMULATOR_PATH}"
echo "--- DEVICE_PATH ${DEVICE_PATH}"

xcodebuild -create-xcframework \
    -framework "${DEVICE_PATH}" \
    -framework "${SIMULATOR_PATH}" \
    -output "${OUTPUT_DIR}/WGSDKJPUnity.xcframework"
    
#lipo -create -output "${OUTPUT_DIR}/WGSDK"\
#    "${DEVICE_PATH}/WGSDK"\
#    "${SIMULATOR_PATH}/WGSDK"
    


open "${OUTPUT_DIR}"

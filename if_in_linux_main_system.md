# install open-jdk-17
sudo apt install openjdk-17-jdk

# build www folder
npm run build

# build android
npx cap add android

# create local.properties
in android folder:

content file is just only:

sdk.dir=/home/user/Android/Sdk

save and exit

# generate apk
sudo ./gradlew assembleDebug

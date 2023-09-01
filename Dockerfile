# Start your image with a node base image
FROM debian:11.7

SHELL ["/bin/bash", "--login", "-c"]
RUN apt-get update && apt-get install -y curl 

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash

RUN nvm install 18.12.1
RUN nvm use 18.12.1

RUN npm install -g @ionic/cli@6.20.6

#RUN apt-get install -y default-jdk
#RUN apt-get -y install default-jre-headless

ENV JAVA_HOME /usr/lib/jvm

# Defina a variável JAVA_HOME
ENV JAVA_HOME=/usr

# Atualize e instale o Java
RUN apt-get update && apt-get install -y openjdk-17-jdk
RUN apt-get -y install default-jre-headless

# Adicione o caminho binário do Java ao PATH (opcional)
ENV PATH=$PATH:$JAVA_HOME/bin

# Instale as dependências necessárias
RUN apt-get update && apt-get install -y \
    wget \
    unzip 

# Baixe e instale o Android SDK
RUN wget https://dl.google.com/android/repository/commandlinetools-linux-7302050_latest.zip -O sdk-tools.zip && \
    unzip sdk-tools.zip -d /usr/local/android-sdk && \
    rm sdk-tools.zip

# Crie o diretório 'latest' dentro de '/usr/local/android-sdk/cmdline-tools/'
RUN cd /usr/local/android-sdk/cmdline-tools/ && \
    mkdir latest && \
    mv bin latest && \
    mv NOTICE.txt latest && \
    mv lib latest && \
    mv source.properties latest 

# Configure as variáveis de ambiente do Android SDK
ENV ANDROID_HOME /usr/local/android-sdk
ENV PATH $PATH:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools


# Aceitar automaticamente as licenças do Android SDK
RUN mkdir -p $ANDROID_HOME/licenses && \
    echo "8933bad161af4178b1185d1a37fbf41ea5269c55" > $ANDROID_HOME/licenses/android-sdk-license && \
    echo "d56f5187479451eabf01fb78af6dfcb131a6481e" > $ANDROID_HOME/licenses/android-sdk-preview-license

# Configure o caminho do SDK do Android
ENV ANDROID_SDK_ROOT=/usr/local/android-sdk

# Instale outras ferramentas e pacotes do Android SDK 
RUN yes | $ANDROID_SDK_ROOT/cmdline-tools/latest/bin/sdkmanager "platform-tools" "build-tools;30.0.2" "platforms;android-30"


RUN apt-get install -y nano
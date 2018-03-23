FROM java:8

# Based on originals from various existing containers:
# https://github.com/inaka/docker-android-sdk
# https://hub.docker.com/r/thedrhax/android-sdk

# Install dependencies
RUN dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -yq git curl unzip libstdc++6:i386 zlib1g:i386 libncurses5:i386 --no-install-recommends && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists /var/cache/apt

# General env vars for Android SDK and Gradle
ENV ANDROID_HOME="/root/android-sdk-linux" \
    SDK_URL="https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip" \
    GRADLE_URL="https://services.gradle.org/distributions/gradle-3.3-all.zip" \
    TERM=dumb \
    JAVA_OPTS="-Xms256m -Xmx512m"

WORKDIR /root

# Install SDK into home
RUN mkdir "$ANDROID_HOME" .android \
 && cd "$ANDROID_HOME" \
 && curl -o sdk.zip $SDK_URL \
 && unzip sdk.zip \
 && rm sdk.zip

# Install Gradle
RUN wget $GRADLE_URL -O gradle.zip \
 && unzip gradle.zip \
 && mv gradle-3.3 gradle \
 && rm gradle.zip \
 && mkdir .gradle

COPY android_sdk_components.env /tmp/android_sdk_components.env
RUN cd /tmp && ${ANDROID_HOME}/tools/bin/sdkmanager --update && \
    yes | ${ANDROID_HOME}/tools/bin/sdkmanager --licenses && \
    ${ANDROID_HOME}/tools/bin/sdkmanager --package_file=android_sdk_components.env && \
    rm -rf /tmp/*
RUN ln -s ${ANDROID_HOME}/platform-tools/adb /usr/local/bin/adb && \
    ln -s /root/gradle/bin/gradle /usr/local/bin/gradle

# ensure that the CircleCI build agent doesn't override the entrypoint
LABEL com.circleci.preserve-entrypoint=true
COPY entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/bin/sh"]

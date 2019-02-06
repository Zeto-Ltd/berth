FROM openjdk:8-jdk-slim-stretch

# Based on originals from various existing containers:
# https://github.com/inaka/docker-android-sdk
# https://hub.docker.com/r/thedrhax/android-sdk

# Install dependencies
RUN apt-get update && \
    apt-get install -yq git curl unzip libstdc++6 zlib1g libncurses5 wget --no-install-recommends && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists /var/cache/apt

COPY entrypoint.sh /docker-entrypoint.sh
COPY android_sdk_components.env /tmp/android_sdk_components.env

# General env vars for Android SDK and Gradle
ENV USERNAME=user \
    USER_HOME="/home/user" \
    ANDROID_HOME="/home/user/android-sdk-linux" \
    SDK_URL="https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip" \
    GRADLE_URL="https://services.gradle.org/distributions/gradle-3.3-all.zip" \
    TERM=dumb \
    JAVA_OPTS="-Xms256m -Xmx512m"

RUN mkdir -p ${USER_HOME} && \
    useradd -d ${USER_HOME} -s /bin/bash ${USERNAME} && \
    chown -R ${USERNAME}:${USERNAME} ${USER_HOME}
WORKDIR ${USER_HOME}
USER ${USERNAME}

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

RUN cd /tmp && ${ANDROID_HOME}/tools/bin/sdkmanager --update && \
    yes | ${ANDROID_HOME}/tools/bin/sdkmanager --licenses && \
    ${ANDROID_HOME}/tools/bin/sdkmanager --package_file=android_sdk_components.env

USER root
# must manually install links to executables to workaround entrypoint overwrite
RUN ln -s ${ANDROID_HOME}/platform-tools/adb /usr/local/bin/adb && \
    ln -s /root/gradle/bin/gradle /usr/local/bin/gradle
USER ${USERNAME}

# ensure that the CircleCI build agent doesn't override the entrypoint
LABEL com.circleci.preserve-entrypoint=true
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/bin/sh"]

FROM ubuntu:14.04
MAINTAINER Ian Sinnott "ian@iansinnott.com"
ENV REFRESHED_AT 2014-10-10
RUN apt-get -yqq update

# Dependencies
RUN apt-get -yqq install ruby ruby-dev make nodejs
RUN gem install --no-rdoc --no-ri jekyll

# NOTE: When defined in a dockerfile volumes are not linked to any directory on
# the host, they just become volumes, meaning:
# 1. They can be shared among containers
# 2. Changes to a olume are made directly
# 3. Changes to a volume will not be included when an image is updated
# 4. These volumes will persist until no image uses them. This is important
#    since images don't need to be running for their volume to exist. Volumes
#    are stored on the underlying Docker somethign or other.. or is it the host?
#    Still learning.
#
# See for more info: https://docs.docker.com/userguide/dockervolumes/

# The /data and /var/www/html directories will become volumes.
VOLUME ["/data", "/var/www/html"]

# Equivalent to doing a `cd` into /data before running the ENTRYPOINT command
WORKDIR /data

# Any site that is present in the mounted directory will be built every time we
# run this image. Running this image normally will only actually run until this
# command is completed, so essentially running the container just builds the
# jekyll site.
ENTRYPOINT ["jekyll", "build", "--destination=/var/www/html"]

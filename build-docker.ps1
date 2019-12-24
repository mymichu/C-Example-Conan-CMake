docker build . -t app-builder:v1

docker run -v ${PWD}:/opt/app --rm -i -t app-builder:v1 /bin/bash " \
&& conan install . --install-folder docker-build \
&& conan build . --build-folder docker-build"
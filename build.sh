#!/bin/sh
conan install . --profile .conan-profile/clang --install-folder build \
&& conan build . --build-folder build
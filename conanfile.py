from conans import ConanFile, CMake

class Calculator(ConanFile):
    name = "Calculator"
    version = "0.1"
    url = "Basic-Calculator"
    description = "<Description of Hello here>"
    settings = "os", "compiler", "build_type", "arch"
    requires = "Catch2/2.11.0@catchorg/stable" # comma-separated list of requirements
    generators = "cmake"
    exports_sources = "src/*", "test/*", "CMakeLists.txt"

    def configure_cmake(self):
        cmake = CMake(self)
        cmake.configure()
        return cmake

    def build(self):
        cmake = CMake(self)
        cmake = self.configure_cmake()
        cmake.build()
        #cmake.test()

    def package(self):
        self.copy("*.h", dst="include", keep_path=False)

    def package_info(self):
        self.cpp_info.libs = ["Calculator"]
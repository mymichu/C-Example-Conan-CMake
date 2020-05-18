from conans import ConanFile, CMake

class Calculator(ConanFile):
    name = "Calculator"
    version = "0.1"
    url = "Basic-Calculator"
    description = "<Description of Hello here>"
    settings = "os", "compiler", "build_type", "arch"
    requires = "Catch2/2.11.0@catchorg/stable" # comma-separated list of requirements
    generators = "cmake", "cmake_paths"
    exports_sources = "src/*", "test/*", "CMakeLists.txt", "cmake/*.cmake", ".clang-format"

    def configure_cmake(self):
        cmake = CMake(self, build_type="Debug")
        cmake.definitions["CMAKE_TOOLCHAIN_FILE"] = "toolchain-clang-linux.cmake"
        cmake.configure()
        return cmake

    def build(self):
        cmake = self.configure_cmake()
        self.run('cmake --build . --target check-format-files')
        cmake.build()
        cmake.test()
        self.run('cmake --build . --target test-report-export-junit')
        self.run('cmake --build . --target coverage-export')

    def package(self):
        self.copy("*.h", dst="include", keep_path=False)
        self.copy("**/coverage-report-*.html", dst="reports", keep_path=False)
        self.copy("**/coverage-report-*.xml", dst="reports", keep_path=False)
        self.copy("**/test-report-junit.xml", dst="reports", keep_path=False)
        self.copy("**/test-report.xml", dst="reports", keep_path=False)


    def package_info(self):
        self.cpp_info.libs = ["Calculator"]
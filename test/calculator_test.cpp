#define CATCH_CONFIG_MAIN  // This tells Catch to provide a main() - only do this in one cpp file
#include "catch2/catch.hpp"
#include "catch2/catch_reporter_sonarqube.hpp"

extern "C" {
#include "utils/calculator.h"
}

TEST_CASE( "Factorials are computed", "[factorial]" ) {
    REQUIRE( addition(-10,15) == 5);
}
#define CATCH_CONFIG_MAIN  // This tells Catch to provide a main() - only do this in one cpp file
#include "catch2/catch.hpp"

extern "C" {
#include "../src/utils/calculator.h"
}

TEST_CASE( "Factorials are computed", "[factorial]" ) {
    REQUIRE( addition(-10,15) == 5);
}

/*
TEST (Calculator, Addition) {
    EXPECT_EQ (5, addition(-10,15));
    EXPECT_EQ (-38, addition(-20,-18));
    EXPECT_EQ (25, addition(10,15));
}

TEST (Calculator, Subtraction) {
    EXPECT_EQ (-25, subtraction(-10,15));
    EXPECT_EQ (-2, subtraction(-20,-18));
    EXPECT_EQ (-5, subtraction(10,15));
}*/
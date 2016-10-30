#!/bin/sh
echo "Building..."
cobc --free AssertContains.cbl
cobc --free AssertNotContains.cbl
cobc --free AssertEquals.cbl
cobc --free AssertNotEquals.cbl
cobc -x --free COBOLTestSuiteTest.cbl
echo "Running test suite..."
./COBOLTestSuiteTest
echo "Finished"

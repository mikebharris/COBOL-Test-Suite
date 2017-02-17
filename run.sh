#!/bin/sh
echo "Building..."
cobc -free AssertContains.cbl
cobc -free AssertNotContains.cbl
cobc -free AssertEquals.cbl
cobc -free AssertNotEquals.cbl
cobc -x --free COBOLTestSuiteTest.cbl
echo "Running test suite..."
./COBOLTestSuiteTest
echo "Running example tests..."
echo "Customers using EVALUATE..."
cd examples/Customer-using-Evaluate
cobc --free -x CustomersTest.cbl ../../AssertNotEquals.cbl ../../AssertEquals.cbl Customers.cbl
./CustomersTest
echo "Customers using ENTRY..."
cd ../Customer-using-Entry
cobc --free -x CustomersTest.cbl ../../AssertNotEquals.cbl ../../AssertEquals.cbl Customers.cbl
./CustomersTest
cd ../..
echo "Finished"

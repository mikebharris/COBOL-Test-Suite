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
cobc -free Customers.cbl
cobc -x -free -L ../.. CustomersTest.cbl
./CustomersTest
echo "Customers using ENTRY..."
cd ../Customer-using-Entry
cobc -free Customers.cbl
cobc -x -free -L ../.. CustomersTest.cbl
./CustomersTest
cd ../..
echo "Finished"

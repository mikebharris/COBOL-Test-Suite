# Suite of sub-programs to help with doing test driven development (TDD) in COBOL
An attempt at a set of routines for doing test driven development with GNU Cobol.

Currently there are four sub-programs:

_AssertEquals(ExpectedResult, ReturnedResult, MessageToDisplay)_ - if ExpectedResult = ReturnedResult then displays "Passed" along with the string specified in __MessageToDisplay__; if they are not equal, then it returns "Failed" and the message.

_AssertNotEquals(ExpectedResult, ReturnedResult, MessageToDisplay)_ - if ExpectedResult != ReturnedResult then displays "Passed" along with the string specified in __MessageToDisplay__; if they are equal, then it returns "Failed" and the message.

_AssertContains(Haystack, Needle, MessageToDisplay)_ - if Needle is in Haystack then displays "Passed" along with the string specified in __MessageToDisplay__; if it is not, then it returns "Failed" and the message.

_AssertNotContains(Haystack, Needle, MessageToDisplay)_ - if Needle is not in Haystack then displays "Passed" along with the string specified in __MessageToDisplay__; if it is, then it returns "Failed" and the message.

To compile them in Gnu COBOL and run the tests, you will need version 1.x or 2.x of GNU Cobol.  Armed with that, do the following:
```
$ cobc --free AssertEquals.cbl 
$ cobc --free AssertNotEquals.cbl 
$ cobc --free AssertContains.cbl 
$ cobc --free AssertNotContains.cbl 
$ cobc -x --free COBOLTestSuiteTest.cbl 
$ ./COBOLTestSuiteTest 
AssertEquals tests:
Passed: integers 5 = 5 should pass
Failed: integers 5 != 6 should fail (expected +0000000006, got +0000000005)
Passed: strings 5 = 5 should pass
Failed: strings 5 != 6 should fail (expected 6, got 5)
Failed: integer 5 = string 5 should fail (expected 5, got +0000000005)
Failed: strings foo = bar should fail (expected bar, got foo)
Passed: strings fubar = fubar should pass
 
AssertNotEquals tests:
Passed: integers 5 != 6 should pass
Failed: integers 5 != 5 should fail
Passed: strings 5 != 6 should pass
Failed: strings 5 != 5 should fail
Passed: string 5 != integer 6 should pass
Passed: foo != bar should pass
Failed: fubar != fubar should fail
 
AssertContains tests:
Passed: 'brown' is in the string
Failed: 'pink' is not in the string ('pink' not contained in 'The quick brown fox jumps over the lazy dog')
Passed: 'OX4 1JS' is in the address
Failed: 'OX5 1JS' is not in the address ('Bristol' not contained in '16 Temple Street                        Oxford                                  OX4 1JS   ')
 
AssertNotContains tests:
Passed: 'pink' is not in the string
Failed: 'brown' is in the string ('brown' is contained in 'The quick brown fox jumps over the lazy dog')
squitty:COBOL-Test-Suite adelayde$ ./COBOLTestSuiteTest 
AssertEquals tests:
Passed: integers 5 = 5 should pass
Failed: integers 5 != 6 should fail (expected +0000000006, got +0000000005)
Passed: strings 5 = 5 should pass
Failed: strings 5 != 6 should fail (expected 6, got 5)
Failed: integer 5 = string 5 should fail (expected 5, got +0000000005)
Failed: strings foo = bar should fail (expected bar, got foo)
Passed: strings fubar = fubar should pass
 
AssertNotEquals tests:
Passed: integers 5 != 6 should pass
Failed: integers 5 != 5 should fail
Passed: strings 5 != 6 should pass
Failed: strings 5 != 5 should fail
Passed: string 5 != integer 6 should pass
Passed: foo != bar should pass
Failed: fubar != fubar should fail
 
AssertContains tests:
Passed: 'brown' is in the string
Failed: 'pink' is not in the string ('pink' not contained in 'The quick brown fox jumps over the lazy dog')
Passed: 'NU1 3QT' is in the address
Failed: 'Wonkyton' is not in the address ('Wonkyton' not contained in '29 Acacia Road                          Nuttytown                               NU1 3QT   ')
 
AssertNotContains tests:
Passed: 'pink' is not in the string
Failed: 'brown' is in the string ('brown' is contained in 'The quick brown fox jumps over the lazy dog')
Passed: 'Wonkyton' is not in the address
Failed: 'NU1 3QT' is in the address ('NU1 3QT' is contained in '29 Acacia Road                          Nuttytown                               NU1 3QT   ')
```

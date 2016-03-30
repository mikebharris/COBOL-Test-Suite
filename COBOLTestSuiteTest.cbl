identification division.
program-id. COBOLTestSuiteTest.

data division.
working-storage section.
01 ResultExpected pic 9.
01 ResultReturned pic 9.

procedure division.

    display "AssertEquals tests"
    display "------------------"
    call "AssertEquals" using 5, 5, "integers 5 = 5 should pass"
    call "AssertEquals" using 5, 6, "integers 5 != 6 should fail"
    call "AssertEquals" using "5", "5", "strings 5 = 5 should pass"
    call "AssertEquals" using "5", "6", "strings 5 != 6 should fail"
    call "AssertEquals" using 5, "5", "integer 5 = string 5 should fail"

    call "AssertEquals" using "foo", "bar", "strings foo = bar should fail"
    call "AssertEquals" using "fubar", "fubar", "strings fubar = fubar should pass"

    display spaces
    display "AssertNotEquals tests"
    display "------------------"
    call "AssertNotEquals" using 5, 6, "integers 5 != 6 should pass"
    call "AssertNotEquals" using 5, 5, "integers 5 != 5 should fail"

    call "AssertNotEquals" using "5", "6", "strings 5 != 6 should pass"
    call "AssertNotEquals" using "5", "5", "strings 5 != 5 should fail"

    call "AssertNotEquals" using "5", 6, "string 5 != integer 6 should pass"

    call "AssertNotEquals" using "foo", "bar", "foo != bar should pass"
    call "AssertNotEquals" using "fubar", "fubar", "fubar != fubar should fail"

    stop run.

end program COBOLTestSuiteTest.

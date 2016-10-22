identification division.
program-id. COBOLTestSuiteTest.

procedure division.

    display "AssertEquals tests:"
    call "AssertEquals" using 5, 5, "integers 5 = 5 should pass"
    call "AssertEquals" using 5, 6, "integers 5 != 6 should fail"
    call "AssertEquals" using "5", "5", "strings 5 = 5 should pass"
    call "AssertEquals" using "5", "6", "strings 5 != 6 should fail"
    call "AssertEquals" using 5, "5", "integer 5 = string 5 should fail"

    call "AssertEquals" using "foo", "bar", "strings foo = bar should fail"
    call "AssertEquals" using "fubar", "fubar", "strings fubar = fubar should pass"

    display spaces
    display "AssertNotEquals tests:"
    call "AssertNotEquals" using 5, 6, "integers 5 != 6 should pass"
    call "AssertNotEquals" using 5, 5, "integers 5 != 5 should fail"

    call "AssertNotEquals" using "5", "6", "strings 5 != 6 should pass"
    call "AssertNotEquals" using "5", "5", "strings 5 != 5 should fail"

    call "AssertNotEquals" using "5", 6, "string 5 != integer 6 should pass"

    call "AssertNotEquals" using "foo", "bar", "foo != bar should pass"
    call "AssertNotEquals" using "fubar", "fubar", "fubar != fubar should fail"

    display spaces
    display "AssertContains tests:"

    call "AssertContains" using "The quick brown fox jumps over the lazy dog", "brown", "'brown' is in the string"
    call "AssertContains" using "The quick brown fox jumps over the lazy dog", "pink", "'pink' is not in the string"

    display spaces
    display "AssertNotContains tests:"

    call "AssertNotContains" using "The quick brown fox jumps over the lazy dog", "pink", "'pink' is not in the string"
    call "AssertNotContains" using "The quick brown fox jumps over the lazy dog", "brown", "'brown' is in the string"

    stop run.

end program COBOLTestSuiteTest.

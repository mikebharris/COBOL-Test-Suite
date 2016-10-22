identification division.
program-id. COBOLTestSuiteTest.

data division.
working-storage section.
01 AddressRecord.
    02 AddressLine1 pic x(20) value spaces.
    02 AddressLine2 pic x(20) value spaces.
    02 City         pic x(20) value spaces.
    02 Country      pic x(20) value spaces.
    02 Postcode     pic x(10) value spaces.

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

    move "29 Acacia Road" to AddressLine1
    move "Nuttytown" to City
    move "NU1 3QT" to Postcode

    call "AssertContains" using AddressRecord, "NU1 3QT", "'NU1 3QT' is in the address"
    call "AssertContains" using AddressRecord, "Wonkyton", "'Wonkyton' is not in the address"

    display spaces
    display "AssertNotContains tests:"

    call "AssertNotContains" using "The quick brown fox jumps over the lazy dog", "pink", "'pink' is not in the string"
    call "AssertNotContains" using "The quick brown fox jumps over the lazy dog", "brown", "'brown' is in the string"

    call "AssertNotContains" using AddressRecord, "Wonkyton", "'Wonkyton' is not in the address"
    call "AssertNotContains" using AddressRecord, "NU1 3QT", "'NU1 3QT' is in the address"

    stop run.

end program COBOLTestSuiteTest.

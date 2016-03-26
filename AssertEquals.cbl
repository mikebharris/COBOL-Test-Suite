identification division.
program-id. AssertEquals is initial.

data division.
linkage section.
01 ResultExpected pic x any length.
01 ResultReturned pic x any length.
01 TestDescription pic x any length.

procedure division using by value ResultReturned,
                         by value ResultExpected,
                         by value TestDescription.

    if ResultReturned equal to ResultExpected then
        display "Passed: " TestDescription
    else
        display "Failed: " TestDescription
    end-if

    goback.

end program AssertEquals.

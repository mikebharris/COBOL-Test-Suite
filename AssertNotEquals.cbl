identification division.
program-id. AssertNotEquals is initial.

data division.
linkage section.
01 ResultExpected any numeric.
01 ResultReturned any numeric.
01 TestDescription any length.

procedure division using ResultReturned,
                         ResultExpected,
                         TestDescription.

    if function trim(ResultReturned) not equal to function trim(ResultExpected) then
        display "Passed: " TestDescription
    else
        display "Failed: " TestDescription
    end-if

    goback.

end program AssertNotEquals.

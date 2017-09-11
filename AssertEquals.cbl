identification division.
program-id. AssertEquals is initial.

data division.
linkage section.
01 ResultExpected any numeric.
01 ResultReturned any numeric.
01 TestDescription any length.

procedure division using ResultReturned,
                         ResultExpected,
                         TestDescription.

    if function trim(ResultReturned) equal to function trim(ResultExpected) then
        display "Passed: " TestDescription
    else
        display "Failed: " TestDescription
        display "  expected: " function trim(ResultExpected)
        display "       got: " function trim(ResultReturned)
    end-if

    goback.

end program AssertEquals.

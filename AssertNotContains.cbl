identification division.
program-id. AssertNotContains is initial.

data division.
working-storage section.
01 CountMatches pic 99 value zero.

linkage section.
01 Needle any numeric.
01 Haystack any numeric.
01 TestDescription any length.

procedure division using Haystack,
                         Needle,
                         TestDescription.

    inspect Haystack tallying CountMatches
        for all Needle

    if CountMatches is equal to zero then
        display "Passed: " TestDescription
    else
        display "Failed: " TestDescription " ('" Needle "' is contained in '" Haystack "')"
    end-if

    goback.

end program AssertNotContains.

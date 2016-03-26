identification division.
program-id. COBOLTestSuiteTest.

procedure division.

    call "AssertEquals" using 5, 5, "5 = 5 should pass"
    call "AssertEquals" using 5, 6, "5 != 6 should fail"

    call "AssertNotEquals" using 5, 6, "5 != 6 should pass"
    call "AssertNotEquals" using 5, 5, "5 != 5 should fail"

    stop run.

end program COBOLTestSuiteTest.

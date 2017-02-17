identification division.
program-id. CustomersTest.

environment division.
configuration section.
    repository.
        function all intrinsic.

data division.
working-storage section.

    copy Customer replacing Customer by CustomerExpected.
    copy Customer replacing Customer by CustomerReturned.

    01 FirstCustomerId  pic 9(4).
    01 SecondCustomerId pic 9(4).
    01 TempCustomerId   pic 9(4).
    01 NumberOfCustomersReturned pic 9(4).

procedure division.

    move "XtreamLab Internet Services" to Name of CustomerExpected
    move "16 Temple Street" to Address1 of CustomerExpected
    move "Oxford" to City of CustomerExpected
    move "OX4 1JS" to Postcode of CustomerExpected
    move "01865430893" to Telephone of CustomerExpected
    move "07811671893" to Mobile of CustomerExpected
    move "Mike Harris" to Contact of CustomerExpected.

    call "Customers" using by content "AddCustomer",
        by content CustomerExpected, by reference FirstCustomerId.
    call "Customers" using by content "GetCustomerById",
        by reference CustomerReturned, by content FirstCustomerId.
    call "AssertEquals" using by content CustomerReturned, by content CustomerExpected
        by content "Result returns the correct details for first customer".

    call "Customers" using by content "GetCustomerId",
        by content CustomerExpected,
        by reference TempCustomerId.
    call "AssertEquals" using by content TempCustomerId,
        by content FirstCustomerId,
        concatenate("Successfully returned 1st id of ", FirstCustomerId).

    move "Alex Stonor" to Contact of CustomerExpected.
    move "Broad Bean Productions" to Name of CustomerExpected
    call "Customers" using by content "AddCustomer",
        by content CustomerExpected, by reference SecondCustomerId.
    call "Customers" using by content "GetCustomerById",
        by reference CustomerReturned, by content SecondCustomerId.
    call "AssertEquals" using by content CustomerReturned, by content CustomerExpected
        by content "Result returns the correct details for 2nd customer".

    call "Customers" using by content "GetCustomerId",
        by content CustomerExpected,
        by reference TempCustomerId.
    call "AssertEquals" using by content TempCustomerId,
        by content SecondCustomerId,
        concatenate("Successfully returned 2nd id of ", SecondCustomerId).

    move "XtreamLab Internet Services" to Name of CustomerExpected
    move "Mike Harris" to Contact of CustomerExpected.
    call "Customers" using by content "GetCustomerId",
        by content CustomerExpected,
        by reference TempCustomerId.
    call "AssertEquals" using by content TempCustomerId,
        by content FirstCustomerId,
        concatenate("Successfully returned 1st id of ", FirstCustomerId).

    move "XtreamLab Internet Services Ltd" to Name of CustomerExpected
    call "Customers" using by content "UpdateCustomerById",
        by content CustomerExpected,
        by content FirstCustomerId.
    call "Customers" using by content "GetCustomerId",
        by content CustomerExpected,
        by reference TempCustomerId.
    call "AssertEquals" using by content TempCustomerId,
        by content FirstCustomerId,
        concatenate("Successfully returned 1st id of ", FirstCustomerId).

    call "Customers" using by content "DeleteCustomerById"
        by content CustomerExpected,
        by content FirstCustomerId.
    call "Customers" using by content "GetCustomerId",
        by content CustomerExpected,
        by reference TempCustomerId.
    call "AssertNotEquals" using by content TempCustomerId,
        by content FirstCustomerId,
        concatenate("Delete successful, id no longer exists").

    call "Customers" using by content "GetNumberOfCustomers",
        by content CustomerExpected,
        by reference TempCustomerId,
        by reference NumberOfCustomersReturned.
    call "AssertEquals" using by content NumberOfCustomersReturned,
        by content 2, by content "Number of customers returned is 2".

    stop run.

end program CustomersTest.

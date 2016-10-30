Example of using COBOL-Test-Suite to build a Customers program. The aim was to make it as object-style as possible within the constrains of using the GNU COBOL which doesn't (yet) support OO-COBOL.

This version uses the COBOL __ENTRY__ reserved word, which I believe is only supported in GNU COBOL version 2.0. 

Using ENTRY gives the program and even more readable and OO-like feeling to it, as you have the instantiator:
```
call "Customers" using CustomersFileName.
```
And then have member methods on the ''object'' created, such as:
```
call "AddCustomer" using by content CustomerExpected, by reference FirstCustomerId
```

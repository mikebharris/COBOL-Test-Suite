identification division.
program-id. Customers.

environment division.
configuration section.
    repository.
        function all intrinsic.

input-output section.
    file-control.
        select optional CustomersFile assign to "Customers.dat"
            organization is relative
            access mode is dynamic
            relative key is CustomerId
            file status is CustomerStatus.

data division.
file section.
    fd CustomersFile.
        copy Customer replacing Customer by
            ==CustomerRecord.
            88 EndOfCustomersFile value high-values==.

working-storage section.
01 CustomerStatus   pic x(2).
    88 Successful   value "00".
    88 RecordExists value "22".
    88 NoSuchRecord value "23".

01 CurrentTime.
    02 filler   pic 9(4).
    02 Seed     pic 9(4).

01 CustomerId   pic 9(4) value zeroes.

linkage section.
01 Command pic x any length.
copy Customer replacing Customer by ThisCustomer.
01 CustomerRecordId pic 9999 value zeroes.
01 NumberOfCustomers pic 9999 value zeroes.

procedure division using Command, ThisCustomer, CustomerRecordId, NumberOfCustomers.

    open i-o CustomersFile
    evaluate trim(Command)
        when "AddCustomer" perform AddCustomer
        when "GetCustomerById" perform GetCustomerById
        when "GetCustomerId" perform GetCustomerIdByName
        when "UpdateCustomerById" perform UpdateCustomerById
        when "DeleteCustomerById" perform DeleteCustomerById
        when "GetNumberOfCustomers" perform GetNumberOfCustomers
        when other display "unknown command " Command
    end-evaluate
    close CustomersFile
    call "C$COPY" using "Customers.dat", "Customers.bak", 0

    goback.

AddCustomer.
    initialize CustomerRecordId
    perform GetCustomerIdByName
    if CustomerRecordId equal to zero
        accept CurrentTime from time
        move ThisCustomer to CustomerRecord
        compute CustomerId = random(Seed)
        compute CustomerId = (random * 9999) + 1
        write CustomerRecord
            invalid key
                if RecordExists
                    display "Record for " Name of ThisCustomer "  already exists"
                else
                    display "Error - status is " CustomerStatus
                end-if
        end-write
        move CustomerId to CustomerRecordId
    end-if
    .
EndAddCustomer.

GetCustomerById.
    move CustomerRecordId to CustomerId
    start CustomersFile
        key is equal to CustomerId
        invalid key
            initialize ThisCustomer
        not invalid key
            read CustomersFile
            move CustomerRecord to ThisCustomer
    end-start
    .

GetCustomerIdByName.
    initialize CustomerRecordId, CustomerId
    read CustomersFile next record
        at end set EndOfCustomersFile to true
    end-read

    perform until EndOfCustomersFile
        or Name of ThisCustomer equal to Name of CustomerRecord
        read CustomersFile next record
            at end set EndOfCustomersFile to true
        end-read
    end-perform

    if Name of ThisCustomer equal to Name of CustomerRecord
        move CustomerId to CustomerRecordId
    end-if
    .

UpdateCustomerById.

    move CustomerRecordId to CustomerId
    start CustomersFile
        key is equal to CustomerId
        invalid key
            if NoSuchRecord
                display "No such record for id of " CustomerRecordId
            end-if
        not invalid key
            move ThisCustomer to CustomerRecord
            rewrite CustomerRecord
    end-start
    .

DeleteCustomerById.
    move CustomerRecordId to CustomerId
    delete CustomersFile record
        invalid key
            display "Invalid customer id; not deleting"
    end-delete
    .

GetNumberOfCustomers.
    initialize NumberOfCustomers
    read CustomersFile next record
        at end set EndOfCustomersFile to true
    end-read
    if not EndOfCustomersFile
        add 1 to NumberOfCustomers
    end-if
    perform with test after until EndOfCustomersFile
        read CustomersFile next record
            at end set EndOfCustomersFile to true
        end-read
        add 1 to NumberOfCustomers
    end-perform
    .

end program Customers.

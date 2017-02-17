identification division.
program-id. Customers.

environment division.
configuration section.
    repository.
        function all intrinsic.

input-output section.
    file-control.
        select optional CustomersFile assign to CustomerFileName
            organization is relative
            access mode is dynamic
            record key is CustomerId
            file status is CustomerStatus.

data division.
file section.
    fd CustomersFile is global.
        copy Customer replacing Customer by
            ==CustomerRecord is global.
            88 EndOfCustomersFile value high-values==.

working-storage section.
    01 CustomerStatus   pic x(2).
        88 Successful   value "00".
        88 RecordExists value "22".
        88 NoSuchRecord value "23".

    01 CurrentTime.
        02 filler   pic 9(4).
        02 Seed     pic 9(4).

    01 CustomerId   pic 9(4) value zeroes is global.

    01 CustomerFileName pic x(20) value "Customers.dat".
    01 BackupFileName   pic x(20) value "Customers.bak".

linkage section.
    01 CustomFileName pic x(20) value spaces.
    copy Customer replacing Customer by ==ThisCustomer is global==.
    01 ThisRecordId pic 9(4) value zeroes is global.
    01 NumberOfCustomers pic 9(4) value zeroes.

procedure division.
    goback.

entry "SetCustomerFileName" using CustomFileName.
    if CustomFileName not equal to spaces
        move CustomFileName to CustomerFileName
        move CustomerFileName to BackupFileName
        inspect BackupFileName replacing all ".dat" by ".bak"
    end-if
    goback.

entry "AddCustomer" using ThisCustomer, ThisRecordId
    call "C$COPY" using CustomerFileName, BackupFileName, 0
    open i-o CustomersFile
    call "GetCustomerIdByName" using ThisCustomer, ThisRecordId
    if ThisRecordId equal to zero
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
        move CustomerId to ThisRecordId
    end-if
    close CustomersFile
    goback.

entry "GetCustomerById" using ThisCustomer, ThisRecordId
    open i-o CustomersFile
    move ThisRecordId to CustomerId
    start CustomersFile
        key is equal to CustomerId
        invalid key
            initialize ThisCustomer
        not invalid key
            read CustomersFile
            move CustomerRecord to ThisCustomer
    end-start
    close CustomersFile
    goback.

entry "GetCustomerIdByName" using ThisCustomer, ThisRecordId
    open i-o CustomersFile
    call "GetCustomerIdByName" using ThisCustomer, ThisRecordId
    close CustomersFile
    goback.

entry "UpdateCustomerById" using ThisCustomer, ThisRecordId
    call "C$COPY" using CustomerFileName, BackupFileName, 0
    open i-o CustomersFile
    move ThisRecordId to CustomerId
    start CustomersFile
        key is equal to CustomerId
        invalid key
            if NoSuchRecord
                display "No such record for id of " ThisRecordId
            end-if
        not invalid key
            move ThisCustomer to CustomerRecord
            rewrite CustomerRecord
    end-start
    close CustomersFile
    goback.

entry "DeleteCustomerById" using ThisRecordId
    call "C$COPY" using CustomerFileName, BackupFileName, 0
    open i-o CustomersFile
    move ThisRecordId to CustomerId
    start CustomersFile
    delete CustomersFile record
        invalid key
            display "Invalid customer id; not deleting"
    end-delete
    close CustomersFile
    goback.

entry "GetNumberOfCustomers" using NumberOfCustomers
    initialize NumberOfCustomers
    open i-o CustomersFile
    read CustomersFile next record
        at end set EndOfCustomersFile to true
    end-read
    perform until EndOfCustomersFile
        add 1 to NumberOfCustomers
        read CustomersFile next record
            at end set EndOfCustomersFile to true
        end-read
    end-perform
    close CustomersFile
    goback.

identification division.
program-id. GetCustomerIdByName.

procedure division using ThisCustomer, ThisRecordId.
    initialize ThisRecordId, CustomerId
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
        move CustomerId to ThisRecordId
    end-if
    goback.
end program GetCustomerIdByName.

end program Customers.

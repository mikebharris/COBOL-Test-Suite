01 Customer.
    02 Name     pic x(50).
    02 StreetAddress.
        03 Address1 pic x(20) value spaces.
        03 Address2 pic x(20) value spaces.
        03 Address3 pic x(20) value spaces.
        03 City     pic x(20) value spaces.
        03 County   pic x(20) value spaces.
        03 Country  pic x(20) value "United Kingdom".
        03 Postcode pic x(10) value spaces.
    02 Telephone    pic 9(12) value zeroes.
    02 Mobile       pic 9(12) value zeroes.
    02 Contact      pic x(20) value spaces.
    02 VAT.
        03 VATRegistered pic a value "Y".
            88 IsVATRegistered value "Y".
            88 IsNotVATRegistered value "N".
        03 VATRate  pic 99V99 value 20.0.
    02 CreditDays   pic 99 value 0.

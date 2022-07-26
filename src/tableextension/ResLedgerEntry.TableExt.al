tableextension 76010 "ResLedgerEntry" extends "Res. Ledger Entry"
{
    fields
    {
        field(487; "Seminar No."; Code[20])
        {
            Caption = 'Seminar No.';
        }
        field(488; "Seminar Registration No."; Code[20])
        {
            Caption = 'Seminar Registration No.';
        }
    }

    var
        myInt: Integer;
}
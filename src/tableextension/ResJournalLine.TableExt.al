tableextension 76020 "ResJournalLine" extends "Res. Journal Line"
{
    fields
    {
        field(960; "Seminar No."; Code[20])
        {
            Caption = 'Seminar No.';
        }
        field(961; "Seminar Registration No."; Code[20])
        {
            Caption = 'Seminar Registration No.';
        }
    }

    var
        myInt: Integer;
}
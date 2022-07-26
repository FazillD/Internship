pageextension 76030 "ResourceLedgerEntries" extends "Resource Ledger Entries"
{
    layout
    {
        addbefore("Job No.")
        {
            field("Seminar No."; "Seminar No.")
            {
                ApplicationArea = All;
            }
            field("Seminar Registration No."; "Seminar Registration No.")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}
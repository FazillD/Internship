pageextension 76030 "ResourceLedgerEntries" extends "Resource Ledger Entries"
{
    layout
    {
        addbefore("Job No.")
        {
            field("Seminar No."; Rec."Seminar No.")
            {
                ApplicationArea = All;
            }
            field("Seminar Registration No."; Rec."Seminar Registration No.")
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
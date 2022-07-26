pageextension 71110 "SourceCodeSetup" extends "Source Code Setup"
{
    layout
    {
        addlast("Cost Accounting")
        {
            group("Seminar Management")
            {
                field(Seminar; Rec.Seminar)
                {
                    Caption = 'Seminar';
                    ApplicationArea = All;
                }
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
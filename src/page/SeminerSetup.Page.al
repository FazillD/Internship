page 70600 "Seminer Setup"
{
    PageType = Card;
    UsageCategory = None;
    SourceTable = "Seminar Setup";
    Caption = 'Seminar Setup';
    DeleteAllowed = false;
    InsertAllowed = false;
    layout
    {
        area(Content)
        {
            group(Numbering)
            {
                field("Seminar Nos."; Rec."Seminar Nos.")
                {
                    ApplicationArea = All;
                }
                field("Seminar Registiration Nos."; Rec."Seminar Registiration Nos.")
                {
                    ApplicationArea = All;
                }
                field("Posted Seminar Reg. No."; Rec."Posted Seminar Reg. No.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;

    trigger OnOpenPage()
    begin
        IF NOT Rec.FINDFIRST THEN
            Rec.INSERT;
    end;
}
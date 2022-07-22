page 77100 "Seminar Details FactBox"
{
    CaptionML = ENU = 'Seminar Details';
    SourceTable = Seminar;
    PageType = CardPart;
    layout
    {
        area(Content)
        {
            field("No."; Rec."No.")
            {
                ApplicationArea = All;

            }
            field(Name; Rec.Name)
            {
                ApplicationArea = All;

            }
            field("Seminar Duration"; Rec."Seminar Duration")
            {
                ApplicationArea = All;

            }
            field("Minimum Participants"; Rec."Minimum Participants")
            {
                ApplicationArea = All;

            }
            field("Maximum Participants"; Rec."Maximum Participants")
            {
                ApplicationArea = All;

            }
            field("Seminar Price"; Rec."Seminar Price")
            {
                ApplicationArea = All;

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
}
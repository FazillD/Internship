page 74000 "Seminar Registration Subform"
{
    CaptionML = ENU = 'Lines';
    SourceTable = "Seminar Registration Line";
    DelayedInsert = true;
    PageType = ListPart;
    AutoSplitKey = true;

    layout
    {
        area(Content)
        {

            repeater(GroupName)
            {
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    ApplicationArea = All;

                }
                field("Participant Contact No."; Rec."Participant Contact No.")
                {
                    ApplicationArea = All;

                }
                field("Participant Name"; Rec."Participant Name")
                {
                    ApplicationArea = All;

                }
                field(Participated; Rec.Participated)
                {
                    ApplicationArea = All;

                }
                field("Registration Date"; Rec."Registration Date")
                {
                    ApplicationArea = All;

                }
                field("Confirmation Date"; Rec."Confirmation Date")
                {
                    ApplicationArea = All;

                }
                field("To Invoice"; Rec."To Invoice")
                {
                    ApplicationArea = All;

                }
                field(Registered; Rec.Registered)
                {
                    ApplicationArea = All;

                }
                field("Seminar Price"; Rec."Seminar Price")
                {
                    ApplicationArea = All;

                }
                field("Line Discount %"; Rec."Line Discount %")
                {
                    ApplicationArea = All;

                }
                field("Line Discount Amount"; Rec."Line Discount Amount")
                {
                    ApplicationArea = All;

                }
                field(Amount; Rec.Amount)
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
}
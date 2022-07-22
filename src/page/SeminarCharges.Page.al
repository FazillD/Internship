page 78000 "Seminar Charges"
{
    CaptionML = ENU = 'Seminar Charges';
    SourceTable = "Seminar Charges";
    PageType = List;
    AutoSplitKey = true;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;

                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;

                }
                field(Quantitiy; Rec.Quantitiy)
                {
                    ApplicationArea = All;

                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;

                }
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    ApplicationArea = All;

                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = All;

                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = All;

                }
                field("Total Price"; Rec."Total Price")
                {
                    ApplicationArea = All;

                }
                field("To Invoice"; Rec."To Invoice")
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
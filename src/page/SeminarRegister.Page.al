page 72100 "Seminar Register"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Seminar Register";
    Editable = false;
    Caption = 'Seminar Register';
    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;

                }
                field("Creation Date"; "Creation Date")
                {
                    ApplicationArea = All;

                }
                field("User ID"; "User ID")
                {
                    ApplicationArea = All;

                }
                field("Source Code"; "Source Code")
                {
                    ApplicationArea = All;

                }
                field("Journal Batch Name"; "Journal Batch Name")
                {
                    ApplicationArea = All;

                }
                field("From Entry No."; "From Entry No.")
                {
                    ApplicationArea = All;

                }
                field("To Entry No."; "To Entry No.")
                {
                    ApplicationArea = All;

                }
            }
        }
        area(FactBoxes)
        {
            systempart("Record Links"; Links)
            {
                ApplicationArea = All;

            }
            systempart(Notes; Notes)
            {
                ApplicationArea = All;

            }
        }
    }

    actions
    {

        area(Processing)
        {
            action("Seminar Ledger")
            {
                ApplicationArea = All;
                RunObject = codeunit "Seminar Reg.-Show Ledger";
                Image = WarrantyLedger;
                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}
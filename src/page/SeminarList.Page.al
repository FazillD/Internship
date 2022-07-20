page 70800 "Seminar List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Seminar;
    Editable = false;
    Caption = 'Seminar List';
    CardPageId = "Seminar Card";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = all;
                }
                field("Seminar Duration"; Rec."Seminar Duration")
                {
                    ApplicationArea = all;
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = all;
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    ApplicationArea = all;
                }
                field("Seminer Price"; Rec."Seminer Price")
                {
                    ApplicationArea = all;
                }
            }
        }
    }


    actions
    {
        area(Processing)
        {
            action("Co&mments")
            {
                ApplicationArea = All;
                Image = Comment;
                RunObject = page "Comment Sheet";
                RunPageLink = "Table Name" = const(Seminar), "No." = field("No.");
                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}
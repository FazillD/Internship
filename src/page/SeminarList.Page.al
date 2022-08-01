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
                field("Seminar Price"; Rec."Seminar Price")
                {
                    ApplicationArea = all;
                }
            }
        }
    }


    actions
    {
        area(Creation)
        {
            group(Seminar)
            {
                action("Seminar Registration")
                {
                    Caption = 'Seminar Registration';
                    RunPageMode = Create;
                    Image = NewTimesheet;
                    Promoted = true;
                    PromotedCategory = New;
                    PromotedIsBig = true;
                    RunObject = page "Seminar Registration";
                    RunPageLink = "Seminar No." = field("No.");
                    ApplicationArea = All;
                }
            }
            action("Ledger Entries")
            {
                Caption = 'Ledger Entries';
                Image = WarrantyLedger;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ShortcutKey = "Ctrl+F7";
                RunObject = page "Seminar Ledger Entries";
                RunPageLink = "Seminar No." = field("No.");
                ApplicationArea = All;
            }
            group("&Registration")
            {
                action(Registration)
                {
                    Image = Timesheet;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = page "Seminar Registration List";
                    RunPageLink = "Seminar No." = field("No.");
                    ApplicationArea = All;
                }
            }

        }
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
            group("Related Information Menu")
            {
                action("&Statistics")
                {
                    ApplicationArea = All;
                    Image = Statistics;
                    RunObject = page "Seminar Statistics";
                }
            }
        }
    }

    var
        myInt: Integer;
}
page 70700 "Seminar Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Seminar;
    Caption = 'Seminar Card';
    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                    trigger OnAssistEdit()
                    begin
                        IF Rec.AssistEdit THEN
                            CurrPage.UPDATE;
                    end;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = all;
                }
                field("Minimum Participants"; Rec."Minimum Participants")
                {
                    ApplicationArea = all;
                }
                field("Maximum Participants"; Rec."Maximum Participants")
                {
                    ApplicationArea = all;
                }
                field("Search Name"; Rec."Search Name")
                {
                    ApplicationArea = all;
                }
                field("Seminar Duration"; Rec."Seminar Duration")
                {
                    ApplicationArea = all;
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = all;
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ApplicationArea = all;
                }
            }

            group(Invoicing)
            {
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
            group("&Seminar")
            {
                action("Seminar Registration")
                {
                    ApplicationArea = All;
                    Caption = 'Seminar Registration';
                    RunPageMode = Create;
                    Image = NewTimesheet;
                    Promoted = true;
                    PromotedCategory = New;
                    PromotedIsBig = true;
                    RunObject = page "Seminar Registration";
                    RunPageLink = "Seminar No." = field("No.");
                }
            }


            action("Ledger Entries")
            {
                ApplicationArea = All;
                Caption = 'Ledger Entries';
                Image = WarrantyLedger;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ShortcutKey = "Ctrl+F7";
                RunObject = page "Seminar Ledger Entries";
                RunPageLink = "Seminar No." = field("No.");
            }
            group("&Registration")
            {
                action(Registration)
                {
                    ApplicationArea = All;
                    Image = Timesheet;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = page "Seminar Registration List";
                    RunPageLink = "Seminar No." = field("No.");
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
        }
    }

    var
        myInt: Integer;
}
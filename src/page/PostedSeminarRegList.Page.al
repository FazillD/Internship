page 71320 "Posted Seminar Reg. List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Posted Seminar Reg. Header";
    CardPageId = "Posted Seminar Registration";
    CaptionML = ENU = 'Posted Seminar Registration List';
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater("Group")
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    ApplicationArea = All;
                }
                field("Seminar No."; Rec."Seminar No.")
                {
                    ApplicationArea = All;
                }
                field("Seminar Name"; Rec."Seminar Name")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Duration"; Rec."Duration")
                {
                    ApplicationArea = All;
                }
                field("Maximum Participants"; Rec."Maximum Participants")
                {
                    ApplicationArea = All;
                }
                field("Room Resource No."; Rec."Room Resource No.")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(FactBoxes)
        {
            part(Factbox; "Seminar Details FactBox")
            {
                SubPageLink = "No." = field("No.");
                ApplicationArea = All;
            }
            systempart(Links; Links)
            {

            }
            systempart(Note; Notes)
            {

            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Co&mments")
            {
                CaptionML = ENU = 'Co&mments';
                ApplicationArea = All;
                RunObject = page "Seminar Comment Sheet";
                RunPageView = where("Document Type" = const(1));
                RunPageLink = "No." = field("No.");
                Image = Comment;
                trigger OnAction()
                begin

                end;
            }
            action("&Charges")
            {
                CaptionML = ENU = '&Charges';
                RunObject = page "Posted Seminar Charges";
                RunPageLink = "Document No." = field("No.");
                Image = Cost;
                ApplicationArea = All;
            }
        }
    }

    var
        myInt: Integer;
}
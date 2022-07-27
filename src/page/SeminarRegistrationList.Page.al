page 75000 "Seminar Registration List"
{
    ApplicationArea = All;
    UsageCategory = Lists;
    Editable = false;
    CaptionML = ENU = 'Seminar Registration List';
    SourceTable = "Seminar Registration Header";
    PageType = List;
    CardPageID = "Seminar Registration";

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
                field(Duration; Rec.Duration)
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
            systempart(Link; Links)
            {
                ApplicationArea = All;

            }
            systempart(Note; Notes)
            {
                ApplicationArea = All;

            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Co&mments")
            {
                CaptionML = ENU = 'Comments';
                ApplicationArea = All;
                RunObject = page "Seminar Comment Sheet";
                //RunPageView = where("No." = const(0));
                //RunPageLink = 
                Image = Comment;
            }
            action("&Charges")
            {
                CaptionML = ENU = 'Charges';
                ApplicationArea = All;
                Image = Costs;
            }
            action("P&ost")
            {
                ApplicationArea = All;
                Caption = 'Post';
                Image = PostDocument;
                Promoted = true;
                PromotedCategory = Process;
                ShortcutKey = F9;
                RunObject = codeunit "Seminar-Post (Yes/No)";
            }
        }
    }

    var
        myInt: Integer;
}
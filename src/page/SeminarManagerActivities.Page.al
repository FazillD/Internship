page 74110 "Seminar Manager Activities"
{
    PageType = CardPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Seminar Cue";

    layout
    {
        area(Content)
        {
            cuegroup(Registration)
            {
                Caption = 'Registration';
                field(Planned; Rec.Planned)
                {
                    ApplicationArea = all;
                    DrillDownPageId = "Seminar Registration List";
                }
                field(Registered; Rec.Registered)
                {
                    ApplicationArea = all;
                    DrillDownPageId = "Seminar Registration List";
                }
                actions
                {
                    action(New)
                    {
                        ApplicationArea = All;
                        Caption = 'New';
                        RunPageMode = Create;
                        RunObject = page "Seminar Registration";
                    }
                }
            }

            cuegroup(Posting)
            {
                Caption = 'For Posting';
                field(Closed; Rec.Closed)
                {
                    ApplicationArea = All;
                    DrillDownPageId = "Seminar Registration List";
                }
            }
        }

    }

    trigger OnOpenPage()
    begin
        Rec.RESET;
        IF NOT Rec.GET THEN BEGIN
            Rec.INIT;
            Rec.INSERT;
        END;
    end;

    var
}
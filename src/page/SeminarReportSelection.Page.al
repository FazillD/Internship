page 74230 "Seminar Report Selection"
{
    PageType = Worksheet;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Seminar Report Selections";
    SaveValues = true;
    Caption = 'Seminar Report Selection';

    layout
    {
        area(Content)
        {
            field(Usage; ReportUsage2)
            {
                Caption = 'Usage';
                OptionCaption = 'Registration';
                ApplicationArea = All;

                trigger OnValidate()
                begin
                    SetUsageFilter();
                    ReportUsage2OnAfterValidate();
                end;
            }
            repeater(GroupName)
            {
                field(Sequence; Rec.Sequence)
                {
                    ApplicationArea = All;

                }
                field("Report ID"; Rec."Report ID")
                {
                    LookupPageId = Objects;
                    ApplicationArea = All;
                }
                field("Report Name"; Rec."Report Name")
                {
                    DrillDown = false;
                    LookupPageId = Objects;
                    ApplicationArea = All;
                }
            }
        }
        area(FactBoxes)
        {
            systempart(RecordLinks; Links)
            {
                Visible = false;
                ApplicationArea = All;
            }
            systempart(Notes; Notes)
            {
                Visible = false;
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
    trigger OnOpenPage()
    begin
    end;

    var
        ReportUsage2: Option "Registration";

    local procedure SetUsageFilter()
    begin
        Rec.FilterGroup(2);
        case ReportUsage2 of
            ReportUsage2::Registration:
                Rec.SetRange(Usage, Rec.Usage::Registration);
        end;
        Rec.FilterGroup(0);
    end;

    local procedure ReportUsage2OnAfterValidate()
    begin
        CurrPage.Update();
    end;
}
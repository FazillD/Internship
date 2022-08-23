page 74120 "My Seminars"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "My Seminar";

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field("Seminar No."; Rec."Seminar No.")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        GetSeminar();
                    end;
                }
                field(Control4; Seminar.Name)
                {
                    ApplicationArea = all;
                    Caption = 'Name';
                }
                field(Control5; Seminar."Seminar Duration")
                {
                    ApplicationArea = All;
                    Caption = 'Duration';
                }
                field(Control6; Seminar."Seminar Price")
                {
                    ApplicationArea = All;
                    Caption = 'Price';
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
                Caption = 'Open';
                Image = Edit;
                ShortcutKey = Return;
                trigger OnAction()
                begin
                    OpenSeminarCard();
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.SETRANGE("User ID", USERID);
    end;

    trigger OnAfterGetRecord()
    begin
        GetSeminar();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Clear(Seminar);
    end;

    var
        Seminar: Record Seminar;

    procedure GetSeminar()
    begin
        CLEAR(Seminar);
        IF Seminar.GET(Rec."Seminar No.") THEN;
    end;

    procedure OpenSeminarCard()
    begin
        IF Seminar.GET(Rec."Seminar No.") THEN
            PAGE.RUN(PAGE::"Seminar Card", Seminar);
    end;
}
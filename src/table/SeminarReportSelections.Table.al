table 74300 "Seminar Report Selections"
{
    CaptionML = ENU = 'Seminar Report Selections';

    fields
    {
        field(1; Usage; Option)
        {
            OptionMembers = "Registration";
            OptionCaption = 'Registration';
            Caption = 'Usage';
        }
        field(2; "Sequence"; Code[10])
        {
            Caption = 'Sequence';
            Numeric = true;
        }
        field(3; "Report ID"; Integer)
        {
            Caption = 'Report ID';
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = const("Report"));
            trigger OnValidate()
            begin
                CalcFields("Report Name");
            end;
        }
        field(4; "Report Name"; Text[80])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(AllObjWithCaption."Object Caption" where("Object Type" = const(Report), "Object ID" = field("Report ID")));
            Caption = 'Report Name';
        }
    }
    keys
    {
        key(PK; Usage, Sequence)
        {
            Clustered = true;
        }
    }

    var
        ReportSelection2: Record "Seminar Report Selections";


    procedure NewRecord()
    begin
        ReportSelection2.SetRange(Usage, Usage);
        if ReportSelection2.Find('+') and (ReportSelection2.Sequence <> '') then
            Sequence := INCSTR(ReportSelection2.Sequence)
        else
            Sequence := '1';
    end;


}
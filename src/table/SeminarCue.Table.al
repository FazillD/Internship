table 74100 "Seminar Cue"
{

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
        }
        field(2; "Planned"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Seminar Registration Header" where(Status = const(Planning)));
        }
        field(3; "Registered"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Seminar Registration Header" where(Status = const(Registration)));
        }
        field(4; "Closed"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Seminar Registration Header" where(Status = const(Closed)));
        }
    }

    keys
    {
        key("Primary Key"; "Primary Key")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}
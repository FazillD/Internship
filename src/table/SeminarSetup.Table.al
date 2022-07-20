table 70400 "Seminar Setup"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Seminar Nos."; Code[10])
        {
            TableRelation = "No. Series";
            DataClassification = ToBeClassified;

        }
        field(3; "Seminar Registiration Nos."; Code[10])
        {
            TableRelation = "No. Series";
            DataClassification = ToBeClassified;
        }
        field(4; "Posted Seminar Reg. No."; Code[10])
        {
            TableRelation = "No. Series";
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(Key1; "Primary Key")
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

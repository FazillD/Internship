table 50183 "Seminar Register"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Integer)
        {
            DataClassification = ToBeClassified;

        }
        field(2; "From Entry No."; Integer)
        {
            DataClassification = ToBeClassified;

        }
        field(3; "To Entry No."; Integer)
        {
            DataClassification = ToBeClassified;

        }
        field(4; "Creation Date"; Date)
        {
            DataClassification = ToBeClassified;

        }
        field(5; "Source Code"; Code[10])
        {
            DataClassification = ToBeClassified;

        }
        field(6; "User ID"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(7; "Journal Batch Name"; Code[10])
        {
            DataClassification = ToBeClassified;

        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; "Creation Date")
        {

        }
        key(Key3; "Source Code", "Creation Date")
        {

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
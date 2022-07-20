table 70500 "Seminar"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                IF "No." <> xRec."No." THEN BEGIN
                    SeminarSetup.GET;
                    NoSeriesMgt.TestManual(SeminarSetup."Seminar Nos.");
                    "No. Series" := '';
                END;
            end;
        }
        field(2; Name; Text[50])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                IF ("Search Name" = UPPERCASE(xRec.Name)) OR ("Search Name" = '') THEN BEGIN
                    "Search Name" := Name;
                END;
            end;
        }
        field(3; "Seminar Duration"; Decimal)
        {
            DecimalPlaces = 0 : 1;
            DataClassification = ToBeClassified;
        }
        field(4; "Minimum Participants"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Maximum Participants"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Search Name"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Blocked"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Last Date Modified"; Date)
        {
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(9; "Comment"; Boolean)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = exist("Comment Line"
            where(
                "Table Name" = const(Seminar),
                "No." = field("No.")
            )
            );
        }
        field(10; "Seminer Price"; Decimal)
        {
            AutoFormatType = 1;
            DataClassification = ToBeClassified;
        }
        field(11; "Gen. Prod. Posting Group"; Code[10])
        {
            TableRelation = "Gen. Product Posting Group";
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                IF xRec."Gen. Prod. Posting Group" <> "Gen. Prod. Posting Group" THEN BEGIN
                    IF
                   GenProdPostingGroup.ValidateVatProdPostingGroup(GenProdPostingGroup, "VAT Prod. Posting Group") THEN BEGIN
                        VALIDATE("VAT Prod. Posting Group", GenProdPostingGroup."Def. VAT Prod. Posting Group");
                    END;
                END;

            end;
        }
        field(12; "VAT Prod. Posting Group"; Code[10])
        {
            TableRelation = "VAT Product Posting Group";
            DataClassification = ToBeClassified;
        }
        field(13; "No. Series"; Code[10])
        {
            Editable = false;
            TableRelation = "No. Series";
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
        key(key2; "Search Name")
        {

        }
    }

    var
        SeminarSetup: Record "Seminar Setup";
        CommentLine: Record "Comment Line";
        Seminar: Record Seminar;
        GenProdPostingGroup: Record "Gen. Product Posting Group";
        NoSeriesMgt: Codeunit NoSeriesManagement;

    trigger OnInsert()
    begin
        IF "No." = '' THEN BEGIN
            SeminarSetup.GET;
            SeminarSetup.TESTFIELD("Seminar Nos.");
            NoSeriesMgt.InitSeries(SeminarSetup."Seminar Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        END;
    end;

    trigger OnModify()
    begin
        "Last Date Modified" := TODAY;
    end;

    trigger OnDelete()
    begin
        CommentLine.RESET;
        CommentLine.SETRANGE("Table Name", CommentLine."Table Name"::Seminar);
        CommentLine.SETRANGE("No.", "No.");
        CommentLine.DELETEALL;
    end;

    trigger OnRename()
    begin
        "Last Date Modified" := TODAY;
    end;

    procedure AssistEdit(): Boolean
    begin
        Seminar := Rec;
        SeminarSetup.GET;
        SeminarSetup.TESTFIELD("Seminar Nos.");
        IF NoSeriesMgt.SelectSeries(SeminarSetup."Seminar Nos.", xRec."No. Series", Seminar."No. Series") THEN BEGIN
            NoSeriesMgt.SetSeries(Seminar."No.");
            Rec := Seminar;
            EXIT(TRUE);
        END;
    end;
}
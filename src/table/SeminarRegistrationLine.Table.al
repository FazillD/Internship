table 72300 "Seminar Registration Line"
{
    DataClassification = ToBeClassified;
    Caption = 'Seminar Registration Line';

    fields
    {
        field(1; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Document No.';
            TableRelation = "Seminar Registration Header";

        }
        field(2; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Line No.';

        }
        field(3; "Bill-to Customer No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Bill-to Customer No.';
            TableRelation = Customer;
            trigger OnValidate()
            var
            begin

                IF "Bill-to Customer No." <> xRec."Bill-to Customer No." THEN BEGIN
                    IF Registered THEN BEGIN
                        ERROR(Text001,
                          FIELDCAPTION("Bill-to Customer No."),
                          FIELDCAPTION(Registered),
                          Registered);
                    END;
                END;
                CreateDim(DATABASE::Customer, "Bill-to Customer No.");
            end;


        }
        field(4; "Participant Contact No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Participant Contact No.';
            TableRelation = Contact;
            trigger OnValidate()
            var
            begin

                IF ("Bill-to Customer No." <> '') AND
                   ("Participant Contact No." <> '')
                THEN BEGIN
                    Contact.GET("Participant Contact No.");
                    ContactBusinessRelation.RESET;
                    ContactBusinessRelation.SETCURRENTKEY("Link to Table", "No.");
                    ContactBusinessRelation.SETRANGE("Link to Table", ContactBusinessRelation."Link to Table"::Customer);
                    ContactBusinessRelation.SETRANGE("No.", "Bill-to Customer No.");
                    IF ContactBusinessRelation.FINDFIRST THEN BEGIN
                        IF ContactBusinessRelation."Contact No." <> Contact."Company No." THEN BEGIN
                            ERROR(Text002, Contact."No.", Contact.Name, "Bill-to Customer No.");
                        END;
                    END;
                END;
                ;
            end;

            trigger OnLookup()
            var
            begin

                ContactBusinessRelation.RESET;
                ContactBusinessRelation.SETRANGE("Link to Table", ContactBusinessRelation."Link to Table"::Customer);
                ContactBusinessRelation.SETRANGE("No.", "Bill-to Customer No.");
                IF ContactBusinessRelation.FINDFIRST THEN BEGIN
                    Contact.SETRANGE("Company No.", ContactBusinessRelation."Contact No.");
                    IF PAGE.RUNMODAL(PAGE::"Contact List", Contact) = ACTION::LookupOK THEN BEGIN
                        "Participant Contact No." := Contact."No.";
                    END;
                END;

                CALCFIELDS("Participant Name");

            end;

        }
        field(5; "Participant Name"; Text[100])
        {
            Caption = 'Participant Name';
            FieldClass = FlowField;
            CalcFormula = Lookup(Contact.Name WHERE("No." = FIELD("Participant Contact No.")));
            Editable = false;

        }
        field(6; "Registration Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Registration Date';
            Editable = false;

        }
        field(7; "To Invoice"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'To Invoice';
            InitValue = true;
        }
        field(8; "Participated"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Participated';

        }
        field(9; "Confirmation Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Confirmation Date';
            Editable = false;

        }
        field(10; "Seminar Price"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Seminar Price';
            AutoFormatType = 2;
            trigger OnValidate()
            var
            begin

                VALIDATE("Line Discount %");


            end;




        }
        field(11; "Line Discount %"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Line Discount';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
            MaxValue = 100;
            trigger OnValidate()
            var
            begin

                IF "Seminar Price" = 0 THEN BEGIN
                    "Line Discount Amount" := 0;
                END ELSE BEGIN
                    GLSetup.GET;
                    "Line Discount Amount" := ROUND("Line Discount %" * "Seminar Price" * 0.01, GLSetup."Amount Rounding Precision");
                END;
                UpdateAmount;

            end;

        }
        field(12; "Line Discount Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Line Discount Amount';
            AutoFormatType = 1;
            trigger OnValidate()
            var
            begin
                IF "Seminar Price" = 0 THEN BEGIN
                    "Line Discount %" := 0;
                END ELSE BEGIN
                    GLSetup.GET;
                    "Line Discount %" := ROUND("Line Discount Amount" / "Seminar Price" * 100, GLSetup."Amount Rounding Precision");
                END;
                UpdateAmount;
            end;

        }
        field(13; "Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Amount';
            AutoFormatType = 1;
            trigger OnValidate()
            var
            begin
                TESTFIELD("Bill-to Customer No.");
                TESTFIELD("Seminar Price");
                GLSetup.GET;
                Amount := ROUND(Amount, GLSetup."Amount Rounding Precision");
                "Line Discount Amount" := "Seminar Price" - Amount;
                IF "Seminar Price" = 0 THEN BEGIN
                    "Line Discount %" := 0;
                END ELSE BEGIN
                    "Line Discount %" := ROUND("Line Discount Amount" / "Seminar Price" * 100, GLSetup."Amount Rounding Precision");
                end;
            end;

        }
        field(14; "Registered"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Registered';
            Editable = false;

        }
        field(51; "Shortcut Dimension 1 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value"."Code" WHERE("Global Dimension No." = CONST(1));
            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(52; "Shortcut Dimension 2 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value"."Code" WHERE("Global Dimension No." = CONST(2));
            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                ShowDimensions;
            end;
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }

    var
        SeminarRegHeader: Record "Seminar Registration Header";
        SeminarRegLine: Record "Seminar Registration Line";
        ContactBusinessRelation: Record 5054;
        Contact: Record 5050;
        GLSetup: Record 98;
        SkipBillToContact: Boolean;
        Text001: TextConst ENU = 'You cannot change the %1, because %2 is %3.';
        Text002: TextConst ENU = 'Contact %1 %2 is related to a different company than customer %3.';
        DimMgt: Codeunit DimensionManagement;

    trigger OnInsert()
    begin
        BEGIN
            GetSeminarRegHeader;
            "Registration Date" := WORKDATE;
            "Seminar Price" := SeminarRegHeader."Seminar Price";
            Amount := SeminarRegHeader."Seminar Price";
        END;
    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin
        BEGIN
            TESTFIELD(Registered, FALSE);
        END;
    end;

    trigger OnRename()
    begin

    end;

    procedure GetSeminarRegHeader();
    BEGIN
        IF SeminarRegHeader."No." <> "Document No." THEN BEGIN
            SeminarRegHeader.GET("Document No.");
        END;
    END;

    procedure CalculateAmount();
    BEGIN
        Amount := ROUND(("Seminar Price" / 100) * (100 - "Line Discount %"));
    END;

    procedure UpdateAmount();
    BEGIN
        GLSetup.GET;
        Amount := ROUND("Seminar Price" - "Line Discount Amount", GLSetup."Amount Rounding Precision");
    END;

    procedure ShowDimensions()
    begin
        "Dimension Set ID" := DimMgt.EditDimensionSet("Dimension Set ID", STRSUBSTNO('%1 %2', "Document No.", "Line No."));
        DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
    end;

    procedure CreateDim(Type1: Integer; No1: Code[20])
    var
        SourceCodeSetup: Record "Source Code Setup";
        TableID: array[10] of Integer;
        No: array[10] of Code[20];
    begin
        SourceCodeSetup.GET;
        TableID[1] := Type1;
        No[1] := No1;
        "Shortcut Dimension 1 Code" := '';
        "Shortcut Dimension 2 Code" := '';
        GetSeminarRegHeader;
        "Dimension Set ID" :=
         DimMgt.GetDefaultDimID(
         TableID, No, SourceCodeSetup.Seminar,
         "Shortcut Dimension 1 Code",
         "Shortcut Dimension 2 Code",
         SeminarRegHeader."Dimension Set ID",
         DATABASE::Seminar);
        DimMgt.UpdateGlobalDimFromDimSetID(
         "Dimension Set ID",
         "Shortcut Dimension 1 Code",
         "Shortcut Dimension 2 Code");
    end;

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;

    procedure LookupShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.LookupDimValueCode(FieldNumber, ShortcutDimCode);
        ValidateShortcutDimCode(FieldNumber, ShortcutDimCode);
    end;

    procedure ShowShortcutDimCode(var ShortcutDimCode: array[8] of Code[20])
    begin
        DimMgt.GetShortcutDimensions("Dimension Set ID", ShortcutDimCode);
    end;

}
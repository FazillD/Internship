table 72500 "Posted Seminar Reg. Line"
{
    DataClassification = ToBeClassified;
    Caption = 'Posted Seminar Reg. Line';

    fields
    {
        field(1; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Document No.';
            TableRelation = "Posted Seminar Reg. Header";

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



        }
        field(4; "Participant Contact No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Participant Contact No.';
            TableRelation = Contact;
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
        }
        field(11; "Line Discount %"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Line Discount';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
            MaxValue = 100;


        }
        field(12; "Line Discount Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Line Discount Amount';
            AutoFormatType = 1;


        }
        field(13; "Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Amount';
            AutoFormatType = 1;


        }
        field(14; "Registered"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Registered';
            Editable = false;

        }
        field(51; "Shortcut Dimension 1 Code"; Code[20])
        {
            TableRelation = "Dimension Value"."Code" where("Global Dimension No." = const(1));
            Caption = 'Shortcut Dimension 1 Code';
            CaptionClass = '1,2,1';
            DataClassification = ToBeClassified;
        }
        field(52; "Shortcut Dimension 2 Code"; Code[20])
        {
            TableRelation = "Dimension Value"."Code" where("Global Dimension No." = const(2));
            Caption = 'Shortcut Dimension 2 Code';
            CaptionClass = '1,2,2';
            DataClassification = ToBeClassified;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            TableRelation = "Dimension Set Entry";
            DataClassification = ToBeClassified;
            trigger OnLookup()
            begin
                ShowDimension;
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
        DimMgt: Codeunit 408;

    procedure ShowDimension()
    begin
        DimMgt.ShowDimensionSet("Dimension Set ID", StrSubstNo('%1 %2', TableCaption, "Document No.", "Line No."));
    end;


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
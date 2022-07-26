table 71130 "Seminar Ledger Entry"
{
    DataClassification = ToBeClassified;
    Caption = 'Seminar Ledger Entry';
    LookupPageId = "Seminar Ledger Entries";
    DrillDownPageId = "Seminar Ledger Entries";

    fields
    {
        field(1; "Entry No."; integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Seminar No."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Seminar;

        }
        field(4; "Posting Date"; Date)
        {
            DataClassification = CustomerContent;

        }
        field(5; "Document Date"; Date)
        {
            DataClassification = CustomerContent;

        }
        field(6; "Entry Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = "Registration","Cancelation";
            OptionCaption = 'Registration,Cancelation';
        }
        field(7; "Document No."; Code[20])
        {
            DataClassification = CustomerContent;

        }
        field(8; "Description"; Text[50])
        {
            DataClassification = CustomerContent;

        }
        field(9; "Bill-to Customer No."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Customer;

        }
        field(10; "Charge Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = "Instructor","Room","Participant","Charge";
            OptionCaption = 'Instructor,Room,Participant,Charge';
        }
        field(11; "Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = "Resource","G/L Account";
            OptionCaption = 'Resource,G/L Account';

        }
        field(12; "Quantity"; Decimal)
        {
            DataClassification = CustomerContent;
            DecimalPlaces = 0 : 5;

        }
        field(13; "Unit Price"; Decimal)
        {
            DataClassification = CustomerContent;
            AutoFormatType = 2;

        }
        field(14; "Total Price"; Decimal)
        {
            DataClassification = CustomerContent;
            AutoFormatType = 1;

        }
        field(15; "Participant Contact No."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Contact;

        }
        field(16; "Participant Name"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(17; "Chargeable"; Boolean)
        {
            DataClassification = CustomerContent;
            InitValue = true;

        }
        field(18; "Room Resource No."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Resource WHERE(Type = CONST(Machine));

        }
        field(19; "Instructor Resource No."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Resource WHERE(Type = CONST(Person));

        }
        field(20; "Starting Date"; Date)
        {
            DataClassification = CustomerContent;

        }
        field(21; "Seminar Registration No."; Code[20])
        {
            DataClassification = CustomerContent;

        }
        field(22; "Res. Ledger Entry No."; Integer)
        {
            DataClassification = CustomerContent;
            TableRelation = "Res. Ledger Entry";

        }
        field(23; "Source Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ","Seminar";
            OptionCaption = ' ,Seminar';

        }
        field(24; "Source No."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = IF ("Source Type" = CONST(Seminar)) Seminar;

        }
        field(25; "Journal Batch Name"; Code[10])
        {
            DataClassification = CustomerContent;

        }
        field(26; "Source Code"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "Source Code";
            Editable = false;

        }
        field(27; "Reason Code"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "Reason Code";

        }
        field(28; "No. Series"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "No. Series";

        }
        field(29; "User ID"; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = User."User Name";
            ValidateTableRelation = false;
            TestTableRelation = false;
        }
        field(51; "Global Dimension 1 Code"; Code[20])
        {
            TableRelation = "Dimension Value"."Code" where("Global Dimension No." = const(1));
            Caption = 'Shortcut Dimension 1 Code';
            CaptionClass = '1,2,1';
            DataClassification = ToBeClassified;
        }
        field(52; "Global Dimension 2 Code"; Code[20])
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
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(key2; "Document No.", "Posting Date", "Seminar No.", "Charge Type", "Chargeable")
        {
            SumIndexFields = "Total Price";
        }
        key(key3; "Bill-to Customer No.", "Participant Contact No.")
        { }
    }

    var
        DimMgt: Codeunit 408;

    procedure ShowDimension()
    begin
        DimMgt.ShowDimensionSet("Dimension Set ID", StrSubstNo('%1 %2', TableCaption, "Entry No."));
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
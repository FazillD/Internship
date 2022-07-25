table 71100 "Seminar Journal Line"
{
    DataClassification = ToBeClassified;
    CaptionML = ENU = 'Seminar Journal Line';
    fields
    {
        field(1; "Journal Template Name"; Code[10])
        {
            DataClassification = ToBeClassified;
            CaptionML = ENU = 'Journal Template Name';
        }
        field(2; "Line No."; integer)
        {
            DataClassification = ToBeClassified;
            CaptionML = ENU = 'Line No.';
        }
        field(3; "Seminar No."; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionML = ENU = 'Seminar No.';
            TableRelation = Seminar;
        }
        field(4; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
            CaptionML = ENU = 'Posting Date';
            trigger OnValidate()
            begin
                Validate("Document Date", "Posting Date");
            end;
        }
        field(5; "Document Date"; Date)
        {
            DataClassification = ToBeClassified;
            CaptionML = ENU = 'Document Date';
        }
        field(6; "Entry Type"; Option)
        {
            DataClassification = ToBeClassified;
            CaptionML = ENU = 'Entry Type';
            OptionCaptionML = ENU = 'Registration,Cancelation';
            OptionMembers = "Registration","CancelationFF";
        }
        field(7; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionML = ENU = 'Document No.';
        }
        field(8; "Description"; Text[50])
        {
            DataClassification = ToBeClassified;
            CaptionML = ENU = 'Description';
        }
        field(10; "Bill-to Customer No."; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionML = ENU = 'Bill-to Customer No.';
            TableRelation = Customer;
        }
        field(11; "Charge Type"; Option)
        {
            DataClassification = ToBeClassified;
            CaptionML = ENU = 'Charge Type';
            OptionCaptionML = ENU = 'Instructor,Room,Participant,Charge';
            OptionMembers = "Instructor","Room","Participant","Charge";
        }
        field(12; "Type"; Option)
        {
            DataClassification = ToBeClassified;
            CaptionML = ENU = 'Type';
            OptionCaptionML = ENU = 'Resource,G/L Account';
            OptionMembers = "Resource","G/L Account";
        }
        field(13; "Quantity"; Decimal)
        {
            DataClassification = ToBeClassified;
            CaptionML = ENU = 'Quantity';
            DecimalPlaces = 0 : 5;
        }
        field(14; "Unit Price"; Decimal)
        {
            DataClassification = ToBeClassified;
            CaptionML = ENU = 'Unit Price';
            AutoFormatType = 2;
        }
        field(15; "Total Price"; Decimal)
        {
            DataClassification = ToBeClassified;
            CaptionML = ENU = 'Total Price';
            AutoFormatType = 1;
        }
        field(16; "Participant Contact No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Contact;
            CaptionML = ENU = 'Participant Contact No.';
        }
        field(17; "Participant Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            CaptionML = ENU = 'Participant Name';
        }
        field(18; "Chargeable"; Boolean)
        {
            DataClassification = ToBeClassified;
            InitValue = true;
            CaptionML = ENU = 'Chargeable';
        }
        field(19; "Room Resource No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Resource WHERE(Type = CONST(Machine));
            CaptionML = ENU = 'Room Resource No.';
        }
        field(20; "Instructor Resource No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Resource WHERE(Type = CONST(Person));
            CaptionML = ENU = 'Instructor Resource No.';
        }
        field(21; "Starting Date"; Date)
        {
            DataClassification = ToBeClassified;
            CaptionML = ENU = 'Starting Date';
        }
        field(22; "Seminar Registration No."; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionML = ENU = 'Seminar Registration No.';
        }
        field(23; "Res. Ledger Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Res. Ledger Entry";
            CaptionML = ENU = 'Res. Ledger Entry No.';
        }
        field(30; "Source Type"; Option)
        {
            DataClassification = ToBeClassified;
            CaptionML = ENU = 'Source Type';
            OptionCaptionML = ENU = ' ,Seminar';
            OptionMembers = " ",Seminar;
        }
        field(31; "Source No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = IF ("Source Type" = CONST(Seminar)) Seminar;
            CaptionML = ENU = 'Source No.';
        }
        field(32; "Journal Batch Name"; code[10])
        {
            DataClassification = ToBeClassified;
            CaptionML = ENU = 'Journal Batch Name';
        }
        field(33; "Source Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Source Code";
            CaptionML = ENU = 'Source Code';
            Editable = false;
        }
        field(34; "Reason Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Reason Code";
            CaptionML = ENU = 'Reason Code';
        }
        field(35; "Posting No. Series"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
            CaptionML = ENU = 'Posting No. Series';
        }
    }

    keys
    {
        key(Key1; "Journal Template Name", "Journal Batch Name", "Line No.")
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

    procedure EmptyLine(): Boolean
    begin
        EXIT(
            ("Seminar No." = '') AND (Quantity = 0));
    end;
}
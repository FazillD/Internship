table 71100 "Seminar Journal Line"
{
    Caption = 'Seminar Journal Line';
    fields
    {
        field(1; "Journal Template Name"; Code[10])
        {

            Caption = 'Journal Template Name';
        }
        field(2; "Line No."; integer)
        {

            Caption = 'Line No.';
        }
        field(3; "Seminar No."; Code[20])
        {

            Caption = 'Seminar No.';
            TableRelation = Seminar;
        }
        field(4; "Posting Date"; Date)
        {

            Caption = 'Posting Date';
            trigger OnValidate()
            begin
                Validate("Document Date", "Posting Date");
            end;
        }
        field(5; "Document Date"; Date)
        {

            Caption = 'Document Date';
        }
        field(6; "Entry Type"; Option)
        {

            Caption = 'Entry Type';
            OptionCaption = 'Registration,Cancelation';
            OptionMembers = "Registration","CancelationFF";
        }
        field(7; "Document No."; Code[20])
        {

            Caption = 'Document No.';
        }
        field(8; "Description"; Text[50])
        {

            Caption = 'Description';
        }
        field(10; "Bill-to Customer No."; Code[20])
        {

            Caption = 'Bill-to Customer No.';
            TableRelation = Customer;
        }
        field(11; "Charge Type"; Option)
        {

            Caption = 'Charge Type';
            OptionCaption = 'Instructor,Room,Participant,Charge';
            OptionMembers = "Instructor","Room","Participant","Charge";
        }
        field(12; "Type"; Option)
        {

            Caption = 'Type';
            OptionCaption = 'Resource,G/L Account';
            OptionMembers = "Resource","G/L Account";
        }
        field(13; "Quantity"; Decimal)
        {

            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;
        }
        field(14; "Unit Price"; Decimal)
        {

            Caption = 'Unit Price';
            AutoFormatType = 2;
        }
        field(15; "Total Price"; Decimal)
        {

            Caption = 'Total Price';
            AutoFormatType = 1;
        }
        field(16; "Participant Contact No."; Code[20])
        {

            TableRelation = Contact;
            Caption = 'Participant Contact No.';
        }
        field(17; "Participant Name"; Text[100])
        {

            Caption = 'Participant Name';
        }
        field(18; "Chargeable"; Boolean)
        {

            InitValue = true;
            Caption = 'Chargeable';
        }
        field(19; "Room Resource No."; Code[20])
        {

            TableRelation = Resource WHERE(Type = CONST(Machine));
            Caption = 'Room Resource No.';
        }
        field(20; "Instructor Resource No."; Code[20])
        {

            TableRelation = Resource WHERE(Type = CONST(Person));
            Caption = 'Instructor Resource No.';
        }
        field(21; "Starting Date"; Date)
        {

            Caption = 'Starting Date';
        }
        field(22; "Seminar Registration No."; Code[20])
        {

            Caption = 'Seminar Registration No.';
        }
        field(23; "Res. Ledger Entry No."; Integer)
        {

            TableRelation = "Res. Ledger Entry";
            Caption = 'Res. Ledger Entry No.';
        }
        field(30; "Source Type"; Option)
        {

            Caption = 'Source Type';
            OptionCaption = ' ,Seminar';
            OptionMembers = " ",Seminar;
        }
        field(31; "Source No."; Code[20])
        {

            TableRelation = IF ("Source Type" = CONST(Seminar)) Seminar;
            Caption = 'Source No.';
        }
        field(32; "Journal Batch Name"; code[10])
        {

            Caption = 'Journal Batch Name';
        }
        field(33; "Source Code"; Code[10])
        {

            TableRelation = "Source Code";
            Caption = 'Source Code';
            Editable = false;
        }
        field(34; "Reason Code"; Code[10])
        {

            TableRelation = "Reason Code";
            Caption = 'Reason Code';
        }
        field(35; "Posting No. Series"; Code[10])
        {

            TableRelation = "No. Series";
            Caption = 'Posting No. Series';
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
            TableRelation = "Dimension Set Entry";
            Editable = false;
            DataClassification = ToBeClassified;
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
tableextension 70000 "Resource" extends "Resource"
{

    fields
    {
        field(1244; "Internel\External"; Option)
        {
            Caption = 'Internal\External';
            OptionMembers = "Internal","External";
            OptionCaption = 'Internal,External';
        }
        field(1245; "Maximum Participants"; Integer)
        {
            Caption = 'Maximum Participants';
        }
        field(1246; "Quantity Per Day"; Decimal)
        {
            Caption = 'Quentity Per Day';
        }
    }
}
pageextension 70100 "ResourceCard" extends "Resource Card"
{
    layout
    {
        addlast(General)
        {
            field("Internel\External"; Rec."Internel\External")
            {
                ApplicationArea = All;
            }
            field("Quantity Per Day"; Rec."Quantity Per Day")
            {
                ApplicationArea = All;
            }
        }
        addlast(content)
        {
            group(Room)
            {
                field("Maximum Participants"; Rec."Maximum Participants")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
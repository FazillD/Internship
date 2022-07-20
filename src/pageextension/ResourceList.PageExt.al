pageextension 70200 "ResourceList" extends "Resource List"
{

    layout
    {
        addafter(Type)
        {
            field("Internel\External"; Rec."Internel\External")
            {
                ApplicationArea = All;
            }
            field("Maximum Participants"; Rec."Maximum Participants")
            {
                ApplicationArea = All;
                Visible = ShowMaxParticipants;
            }
        }
        modify(Type)
        {
            Visible = ShowType;
        }
    }

    var
        [InDataSet]
        ShowType: Boolean;
        ShowMaxParticipants: Boolean;

    trigger OnOpenPage()
    begin
        Rec.FILTERGROUP(3);
        ShowType := Rec.GETFILTER(Type) = '';
        ShowMaxParticipants := Rec.GETFILTER(Type) = FORMAT(Rec.Type::Machine);
        Rec.FILTERGROUP(0);
    end;
}
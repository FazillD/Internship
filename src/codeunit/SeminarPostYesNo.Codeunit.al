codeunit 74030 "Seminar-Post (Yes/No)"
{
    TableNo = "Seminar Registration Header";
    trigger OnRun()
    begin
        SeminarRegHeader.Copy(Rec);
        Code;
        Rec := SeminarRegHeader;
    end;

    var
        SeminarRegHeader: Record "Seminar Registration Header";
        SeminarPost: Codeunit "Seminar-Post";
        Text001: TextConst ENU = 'Do you want to post the Registration?';

    local procedure Code()
    begin
        if not Confirm(Text001, true) then
            exit;
        SeminarPost.Run(SeminarRegHeader);
        Commit();
    end;
}
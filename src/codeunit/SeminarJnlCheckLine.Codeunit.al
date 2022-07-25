codeunit 71100 "Seminar Jnl.-Check Line"
{
    TableNo = "Seminar Journal Line";

    var
        GLSetup: Record "General Ledger Setup";
        UserSetup: Record "User Setup";
        AllowPostingFrom: Date;
        AllowPostingTo: Date;
        text000: TextConst ENU = 'cannot be a closing date.';
        text001: TextConst ENU = 'is not within your range of allowed posting dates';

    procedure RunCheck(var SemJnlLine: Record "Seminar Journal Line")
    begin
        WITH SemJnlLine DO begin
            IF EmptyLine THEN
                EXIT;
            TESTFIELD("Posting Date");
            TESTFIELD("Instructor Resource No.");
            TESTFIELD("Seminar No.");
            CASE "Charge Type" OF
                "Charge Type"::Instructor:
                    TESTFIELD("Instructor Resource No.");
                "Charge Type"::Room:
                    TESTFIELD("Room Resource No.");
                "Charge Type"::Participant:
                    TESTFIELD("Participant Contact No.");
            END;
            IF Chargeable THEN
                TESTFIELD("Bill-to Customer No.");
            IF "Posting Date" = CLOSINGDATE("Posting Date") THEN
                FIELDERROR("Posting Date", Text000);
            IF (AllowPostingFrom = 0D) AND (AllowPostingTo = 0D) THEN BEGIN
                IF USERID <> '' THEN
                    IF UserSetup.GET(USERID) THEN BEGIN
                        AllowPostingFrom := UserSetup."Allow Posting From";
                        AllowPostingTo := UserSetup."Allow Posting To";
                    END;
                IF (AllowPostingFrom = 0D) AND (AllowPostingTo = 0D) THEN BEGIN
                    GLSetup.GET;
                    AllowPostingFrom := GLSetup."Allow Posting From";
                    AllowPostingTo := GLSetup."Allow Posting To";
                END;
                IF AllowPostingTo = 0D THEN
                    AllowPostingTo := 99991231D;
            END;
            IF ("Posting Date" < AllowPostingFrom) OR ("Posting Date" > AllowPostingTo)
            THEN
                FIELDERROR("Posting Date", Text001);
            IF ("Document Date" <> 0D) THEN
                IF ("Document Date" = CLOSINGDATE("Document Date")) THEN
                    FIELDERROR("Document Date", Text000);


        end;

    end;

    trigger OnRun()
    begin
        RunCheck(Rec);
    end;
}
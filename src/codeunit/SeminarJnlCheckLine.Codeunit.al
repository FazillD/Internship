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
        DimMgt: Codeunit DimensionManagement;
        text002: TextConst ENU = 'The combination of dimensions used in %1 %2,%3, %4 is blocked. %5';
        text003: TextConst ENU = 'A dimension used in %1 %2, %3, %4 has caused an error. %5';

    procedure RunCheck(var SemJnlLine: Record "Seminar Journal Line")
    var
        TableID: array[10] of Integer;
        No: array[10] of Code[20];
    begin
        WITH SemJnlLine DO BEGIN
            IF SemJnlLine.EmptyLine THEN
                EXIT;
            SemJnlLine.TESTFIELD("Posting Date");
            SemJnlLine.TESTFIELD("Instructor Resource No.");
            SemJnlLine.TESTFIELD("Seminar No.");
            CASE SemJnlLine."Charge Type" OF
                SemJnlLine."Charge Type"::Instructor:
                    SemJnlLine.TESTFIELD("Instructor Resource No.");
                SemJnlLine."Charge Type"::Room:
                    SemJnlLine.TESTFIELD("Room Resource No.");
                SemJnlLine."Charge Type"::Participant:
                    SemJnlLine.TESTFIELD("Participant Contact No.");
            END;
            IF SemJnlLine.Chargeable THEN
                SemJnlLine.TESTFIELD("Bill-to Customer No.");
            IF SemJnlLine."Posting Date" = CLOSINGDATE(SemJnlLine."Posting Date") THEN
                SemJnlLine.FIELDERROR("Posting Date", Text000);
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
            IF (SemJnlLine."Posting Date" < AllowPostingFrom) OR (SemJnlLine."Posting Date" > AllowPostingTo)
            THEN
                SemJnlLine.FIELDERROR("Posting Date", Text001);
            IF (SemJnlLine."Document Date" <> 0D) THEN
                IF (SemJnlLine."Document Date" = CLOSINGDATE(SemJnlLine."Document Date")) THEN
                    SemJnlLine.FIELDERROR("Document Date", Text000);

            IF NOT DimMgt.CheckDimIDComb("Dimension Set ID") THEN
                ERROR(Text002, TABLECAPTION, "Journal Template Name", "Journal Batch Name", "Line No.", DimMgt.GetDimCombErr);
            TableID[1] := DATABASE::Seminar;
            No[1] := "Seminar No.";
            TableID[2] := DATABASE::Resource;
            No[2] := "Instructor Resource No.";
            TableID[3] := DATABASE::Resource;
            No[3] := "Room Resource No.";
            IF NOT DimMgt.CheckDimValuePosting(TableID, No, "Dimension Set ID") THEN
                IF "Line No." <> 0 THEN
                    ERROR(Text003, TABLECAPTION, "Journal Template Name", "Journal Batch Name", "Line No.", DimMgt.GetDimValuePostingErr)
                ELSE
                    ERROR(DimMgt.GetDimValuePostingErr);
        end;
    end;

    trigger OnRun()
    begin
        RunCheck(Rec);
    end;
}
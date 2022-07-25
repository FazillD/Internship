codeunit 71130 "Seminar Jnl.-Post Line"
{
    TableNo = "Seminar Journal Line";

    var
        SeminarJnlLine: Record "Seminar Journal Line";
        SeminarLedgerEntry: Record "Seminar Ledger Entry";
        SeminarRegister: Record "Seminar Register";
        SeminarJnlCheckLine: Codeunit "Seminar Jnl.-Check Line";
        NextEntryNo: Integer;

    procedure RunWithCheck(var SeminarJnlLine2: Record "Seminar Journal Line")
    begin
        SeminarJnlLine.COPY(SeminarJnlLine2);
        Code();
        SeminarJnlLine2 := SeminarJnlLine;
    end;

    procedure Code()
    begin
        WITH SeminarJnlLine DO BEGIN
            IF EmptyLine THEN
                EXIT;
            SeminarJnlCheckLine.RunCheck(SeminarJnlLine);
            IF NextEntryNo = 0 THEN BEGIN
                SeminarLedgerEntry.LOCKTABLE;
                IF SeminarLedgerEntry.FINDLAST THEN
                    NextEntryNo := SeminarLedgerEntry."Entry No.";
                NextEntryNo := NextEntryNo + 1;
            END;
            IF "Document Date" = 0D THEN
                "Document Date" := "Posting Date";
            IF SeminarRegister."No." = 0 THEN BEGIN
                SeminarRegister.LOCKTABLE;
                IF (NOT SeminarRegister.FINDLAST) OR (SeminarRegister."To Entry No." <> 0)
                THEN BEGIN
                    SeminarRegister.INIT;
                    SeminarRegister."No." := SeminarRegister."No." + 1;
                    SeminarRegister."From Entry No." := NextEntryNo;
                    SeminarRegister."To Entry No." := NextEntryNo;
                    SeminarRegister."Creation Date" := TODAY;
                    SeminarRegister."Source Code" := "Source Code";
                    SeminarRegister."Journal Batch Name" := "Journal Batch Name";
                    SeminarRegister."User ID" := USERID;
                    SeminarRegister.INSERT;
                END;
            END;
            SeminarRegister."To Entry No." := NextEntryNo;
            SeminarRegister.MODIFY;
            SeminarLedgerEntry.INIT;
            SeminarLedgerEntry."Seminar No." := "Seminar No.";
            SeminarLedgerEntry."Posting Date" := "Posting Date";
            SeminarLedgerEntry."Document Date" := "Document Date";
            SeminarLedgerEntry."Entry Type" := "Entry Type";
            SeminarLedgerEntry."Document No." := "Document No.";
            SeminarLedgerEntry.Description := Description;
            SeminarLedgerEntry."Bill-to Customer No." := "Bill-to Customer No.";
            SeminarLedgerEntry."Charge Type" := "Charge Type";
            SeminarLedgerEntry.Type := Type;
            SeminarLedgerEntry.Quantity := Quantity;
            SeminarLedgerEntry."Unit Price" := "Unit Price";
            SeminarLedgerEntry."Total Price" := "Total Price";
            SeminarLedgerEntry."Participant Contact No." := "Participant Contact No.";
            SeminarLedgerEntry."Participant Name" := "Participant Name";
            SeminarLedgerEntry.Chargeable := Chargeable;
            SeminarLedgerEntry."Room Resource No." := "Room Resource No.";
            SeminarLedgerEntry."Instructor Resource No." := "Instructor Resource No.";
            SeminarLedgerEntry."Starting Date" := "Starting Date";
            SeminarLedgerEntry."Seminar Registration No." := "Seminar Registration No.";
            SeminarLedgerEntry."Res. Ledger Entry No." := "Res. Ledger Entry No.";
            SeminarLedgerEntry."Source Type" := "Source Type";
            SeminarLedgerEntry."Source No." := "Source No.";
            SeminarLedgerEntry."Journal Batch Name" := "Journal Batch Name";
            SeminarLedgerEntry."Source Code" := "Source Code";
            SeminarLedgerEntry."Reason Code" := "Reason Code";
            SeminarLedgerEntry."No. Series" := "Posting No. Series";
            SeminarLedgerEntry."User ID" := USERID;
            SeminarLedgerEntry."Entry No." := NextEntryNo;
            SeminarLedgerEntry.INSERT;
            NextEntryNo := NextEntryNo + 1;
        END

    end;

    trigger OnRun()
    begin
        RunWithCheck(Rec);
    end;
}
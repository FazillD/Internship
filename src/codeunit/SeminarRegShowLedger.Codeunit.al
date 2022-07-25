codeunit 73000 "Seminar Reg.-Show Ledger"
{
    TableNo = "Seminar Register";

    var
        SeminarLedgerEntry: Record "Seminar Ledger Entry";

    trigger OnRun()
    begin
        SeminarLedgerEntry.SETRANGE("Entry No.", "From Entry No.", "To Entry No.");
        PAGE.RUN(PAGE::"Seminar Ledger Entries", SeminarLedgerEntry);
    end;
}
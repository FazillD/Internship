pageextension 55100 "DefaultDimensionsMultiple" extends "Default Dimensions-Multiple"
{
    procedure SetMultiSeminar(var Seminar: Record Seminar)
    begin
        SetMultiRecord(Seminar, Seminar.FieldNo("No."));
    end;
}
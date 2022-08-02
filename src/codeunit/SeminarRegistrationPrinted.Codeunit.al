codeunit 77000 "Seminar Registration-Printed"
{
    TableNo = "Seminar Registration Header";
    trigger OnRun()
    begin
        FIND;
        "No. Printed" := "No. Printed" + 1;
        MODIFY;
        COMMIT;
    end;

    var
        myInt: Integer;
}
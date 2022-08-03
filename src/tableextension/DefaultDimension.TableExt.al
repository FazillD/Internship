tableextension 55000 "DefaultDimension" extends "Default Dimension"
{
    fields
    {
        // Add changes to table fields here
    }

    procedure UpdateSeminarGlobalDimCode(var GlobalDimCodeNo: Integer; var SeminarNo: Code[20]; NewDimValue: Code[20])
    var
        Seminar: Record Seminar;
    begin
        IF Seminar.GET(SeminarNo) THEN BEGIN
            CASE GlobalDimCodeNo OF
                1:
                    Seminar."Global Dimension 1 Code" := NewDimValue;
                2:
                    Seminar."Global Dimension 2 Code" := NewDimValue;
                DATABASE::Seminar:
                    UpdateSeminarGlobalDimCode(GlobalDimCodeNo, "No.", NewDimValue);

            END;
        END;


    end;

    var
        myInt: Integer;
}
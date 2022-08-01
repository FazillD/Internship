page 72320 "Seminar Statistics"
{
    PageType = Card;
    LinksAllowed = false;
    SourceTable = Seminar;
    Editable = false;

    layout
    {
        area(Content)
        {
            group("Group")
            {
                fixed("Group1")
                {
                    group("This Period")
                    {
                        field(SeminarDateName1; SeminarDateName[1])
                        {
                            ApplicationArea = All;

                        }
                        field(TotalPrice1; TotalPrice[1])
                        {
                            ApplicationArea = All;

                        }
                        field(TotalPriceNotChargeable1; TotalPriceNotChargeable[1])
                        {
                            ApplicationArea = All;

                        }
                        field(TotalPriceChargeable1; TotalPriceChargeable[1])
                        {
                            ApplicationArea = All;

                        }
                    }
                    group("This Year")
                    {
                        field(SeminarDateName2; SeminarDateName[2])
                        {
                            ApplicationArea = All;

                        }
                        field(TotalPrice2; TotalPrice[2])
                        {
                            ApplicationArea = All;

                        }
                        field(TotalPriceNotChargeable2; TotalPriceNotChargeable[2])
                        {
                            ApplicationArea = All;

                        }
                        field(TotalPriceChargeable2; TotalPriceChargeable[2])
                        {
                            ApplicationArea = All;

                        }
                    }
                    group("Last Year")
                    {
                        field(SeminarDateName3; SeminarDateName[3])
                        {
                            ApplicationArea = All;

                        }
                        field(TotalPrice3; TotalPrice[3])
                        {
                            ApplicationArea = All;

                        }
                        field(TotalPriceNotChargeable3; TotalPriceNotChargeable[3])
                        {
                            ApplicationArea = All;

                        }
                        field(TotalPriceChargeable3; TotalPriceChargeable[3])
                        {
                            ApplicationArea = All;

                        }
                    }
                    group("To Date")
                    {
                        field(SeminarDateName4; SeminarDateName[4])
                        {
                            ApplicationArea = All;

                        }
                        field(TotalPrice4; TotalPrice[4])
                        {
                            ApplicationArea = All;

                        }
                        field(TotalPriceNotChargeable4; TotalPriceNotChargeable[4])
                        {
                            ApplicationArea = All;

                        }
                        field(TotalPriceChargeable4; TotalPriceChargeable[4])
                        {
                            ApplicationArea = All;

                        }
                    }
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin


        Rec.SetRange("No.", Rec."No.");
        if CurrentDate <> WorkDate() then begin
            CurrentDate := WorkDate;
            DateFilterCalc.CreateAccountingPeriodFilter(SeminarDateFilter[1], SeminarDateName[1], CurrentDate, 0);
            DateFilterCalc.CreateFiscalYearFilter(SeminarDateFilter[2], SeminarDateName[2], CurrentDate, 0);
            DateFilterCalc.CreateFiscalYearFilter(SeminarDateFilter[3], SeminarDateName[3], CurrentDate, -1);
        end;
        for i := 1 to 4 do begin
            Rec.SetFilter("Date Filter", SeminarDateFilter[i]);
            Rec.CalcFields("Total Price", "Total Price(Not Chargeable)", "Total Price(Chargeable)");
            TotalPrice[i] := Rec."Total Price";
            TotalPriceNotChargeable[i] := Rec."Total Price(Not Chargeable)";
            TotalPriceChargeable[i] := Rec."Total Price(Chargeable)";
            //Message('%1,%2,%3,%4', i, Rec."Total Price", Rec."Total Price(Chargeable)", Rec."Total Price(Not Chargeable)");
        end;

        Rec.SetRange("Date Filter", 0D, CurrentDate);


    end;

    var
        DateFilterCalc: Codeunit "DateFilter-Calc";
        SeminarDateFilter: Array[4] of Text[30];
        SeminarDateName: Array[4] of Text[30];
        CurrentDate: Date;
        TotalPrice: Array[4] of Decimal;
        TotalPriceNotChargeable: Array[4] of Decimal;
        TotalPriceChargeable: Array[4] of Decimal;
        i: Integer;

}
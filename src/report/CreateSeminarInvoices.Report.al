report 67891 "Create Seminar Invoices"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;
    Caption = 'Create Seminar Invoices';
    DefaultRenderingLayout = LayoutName;
    dataset
    {
        dataitem("Seminar Ledger Entry"; "Seminar Ledger Entry")
        {
            DataItemTableView = sorting("Bill-to Customer No.", "Document No.", "Charge Type", "Participant Contact No.");
            RequestFilterFields = "Bill-to Customer No.", "Seminar No.", "Posting Date";
            trigger OnPreDataItem()
            begin
                IF PostingDateReq = 0D THEN
                    ERROR(Text000);
                IF DocDateReq = 0D THEN
                    ERROR(Text001);
                Window.OPEN(
                 Text002 +
                 Text003 +
                 Text004);
            end;

            trigger OnAfterGetRecord()
            begin
                IF "Bill-to Customer No." <> Customer."No." THEN
                    Customer.GET("Bill-to Customer No.");
                IF Customer.Blocked IN [Customer.Blocked::All, Customer.Blocked::Invoice] THEN BEGIN
                    NoOfSalesInvErrors := NoOfSalesInvErrors + 1;
                END
                ELSE BEGIN
                    IF "Seminar Ledger Entry"."Bill-to Customer No." <> SalesHeader."Bill-to Customer No." THEN BEGIN
                        Window.UPDATE(1, "Bill-to Customer No.");
                        IF SalesHeader."No." <> '' THEN
                            FinalizeSalesInvoiceHeader;
                        InsertSalesInvoiceHeader;
                    END;
                    Window.UPDATE(2, "Seminar Registration No.");
                    CASE Type OF
                        Type::Resource:
                            BEGIN
                                SalesLine.Type := SalesLine.Type::Resource;
                                CASE "Charge Type" OF
                                    "Charge Type"::Instructor:
                                        SalesLine."No." := "Instructor Resource No.";
                                    "Charge Type"::Room:
                                        SalesLine."No." := "Room Resource No.";
                                    "Charge Type"::Participant:
                                        SalesLine."No." := "Instructor Resource No.";
                                END;
                            END;
                    END;
                    SalesLine."Document Type" := SalesHeader."Document Type";
                    SalesLine."Document No." := SalesHeader."No.";
                    SalesLine."Line No." := NextLineNo;
                    SalesLine.VALIDATE("No.");
                    Seminar.GET("Seminar No.");
                    IF "Seminar Ledger Entry".Description <> '' THEN
                        SalesLine.Description := "Seminar Ledger Entry".Description
                    ELSE
                        SalesLine.Description := Seminar.Name;
                    SalesLine."Unit Price" := "Unit Price";
                    IF SalesHeader."Currency Code" <> '' THEN BEGIN
                        SalesHeader.TESTFIELD("Currency Factor");
                        SalesLine."Unit Price" := ROUND(CurrencyExchRate.ExchangeAmtLCYToFCY(WORKDATE, SalesHeader."Currency Code", SalesLine."Unit Price", SalesHeader."Currency Factor"));
                    END;
                    SalesLine.VALIDATE(Quantity, Quantity);
                    SalesLine.INSERT;
                    NextLineNo := NextLineNo + 10000;
                END;
            end;

            trigger OnPostDataItem()
            begin
                Window.CLOSE;
                IF SalesHeader."No." = '' THEN BEGIN
                    MESSAGE(Text007);
                END
                ELSE BEGIN
                    FinalizeSalesInvoiceHeader;
                    IF NoOfSalesInvErrors = 0 THEN
                        MESSAGE(Text005, NoOfSalesInv)
                    ELSE
                        MESSAGE(Text006, NoOfSalesInvErrors);
                END;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    field(PostingDateReq; PostingDateReq)
                    {
                        ApplicationArea = All;
                    }
                    field(DocDateReq; DocDateReq)
                    {
                        ApplicationArea = All;
                    }
                    field(CalcInvoiceDiscount; CalcInvoiceDiscount)
                    {
                        ApplicationArea = All;
                    }
                    field(PostInvoices; PostInvoices)
                    {
                        ApplicationArea = All;
                    }
                }
            }
        }
        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
        trigger OnOpenPage()
        begin
            if PostingDateReq = 0D then
                PostingDateReq := WorkDate();
            if DocDateReq = 0D then
                DocDateReq := WorkDate();
            SalesSetup.Get();
            CalcInvoiceDiscount := SalesSetup."Calc. Inv. Discount";
        end;


    }

    rendering
    {
        layout(LayoutName)
        {
            Type = RDLC;
            LayoutFile = 'mylayout.rdl';
        }
    }

    var
        CurrencyExchRate: Record "Currency Exchange Rate";
        Customer:
                            Record Customer;
        GLSetup:
                            Record "General Ledger Setup";
        SalesHeader:
                            Record "Sales Header";
        SalesLine:
                            Record "Sales Line";
        SalesSetup:
                            Record "Sales & Receivables Setup";
        SalesCalcDiscount:
                            Codeunit "Sales-Calc. Discount";
        SalesPost:
                            Codeunit "Sales-Post";
        CalcInvoiceDiscount:
                            Boolean;
        PostInvoices:
                            Boolean;
        NextLineNo:
                            Integer;
        NoOfSalesInvErrors:
                            Integer;
        NoOfSalesInv:
                            Integer;
        PostingDateReq:
                            Date;
        DocDateReq:
                            Date;
        Window:
                            Dialog;
        Text000:
                            TextConst ENU = 'Please enter the posting date.';
        Text001:
                            TextConst ENU = 'Please enter the document date.';
        Text002:
                            TextConst ENU = 'Creating Seminar Invoices...\\';
        Text003:
                            TextConst ENU = 'Customer No.      #1##########\';
        Text004:
                            TextConst ENU = 'Registration No.   #2##########\';
        Text005:
                            TextConst ENU = 'The number of invoice(s) created is %1.';
        Text006:
                            TextConst ENU = 'Not all the invoices were posted. A total of %1 invoices were not posted.';
        Text007:
                            TextConst ENU = 'There is nothing to invoice.';
        Seminar:
                            Record Seminar;

    LOCAL PROCEDURE FinalizeSalesInvoiceHeader();
    BEGIN
        WITH SalesHeader DO BEGIN
            IF CalcInvoiceDiscount THEN
                SalesCalcDiscount.RUN(SalesLine);
            GET("Document Type", "No.");
            COMMIT;
            CLEAR(SalesCalcDiscount);
            CLEAR(SalesPost);
            NoOfSalesInv := NoOfSalesInv + 1;
            IF PostInvoices THEN BEGIN
                CLEAR(SalesPost);
                IF NOT SalesPost.RUN(SalesHeader) THEN
                    NoOfSalesInvErrors := NoOfSalesInvErrors + 1;
            END;
        END;
    END;

    LOCAL PROCEDURE InsertSalesInvoiceHeader();
    BEGIN
        WITH SalesHeader DO BEGIN
            INIT;
            "Document Type" := "Document Type"::Invoice;
            "No." := '';
            INSERT(TRUE);
            VALIDATE("Sell-to Customer No.", "Seminar Ledger Entry"."Bill-to Customer No.");
            IF "Bill-to Customer No." <> "Sell-to Customer No." THEN
                VALIDATE("Bill-to Customer No.", "Seminar Ledger Entry"."Bill-to Customer No.");
            VALIDATE("Posting Date", PostingDateReq);
            VALIDATE("Document Date", DocDateReq);
            VALIDATE("Currency Code", '');
            MODIFY;
            COMMIT;
            NextLineNo := 10000;
        END;
    END;
}
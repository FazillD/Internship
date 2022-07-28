codeunit 75000 "OnAfterNavigateFindRecords"
{
    [EventSubscriber(ObjectType::Page, Page::Navigate, 'OnAfterNavigateFindRecords', '', false, false)]
    local procedure PageNavigateOnAfterNavigateFindRecordsPost(var DocumentEntry: Record "Document Entry"; DocNoFilter: Text; PostingDateFilter: Text; var NewSourceRecVar: Variant)
    begin
        IF PostedSeminarRegHeader.READPERMISSION THEN BEGIN
            PostedSeminarRegHeader.RESET;
            PostedSeminarRegHeader.SETFILTER("No.", DocNoFilter);
            PostedSeminarRegHeader.SETFILTER("Posting Date", PostingDateFilter);

            DocumentEntry.Init();
            DocumentEntry."Entry No." := DocumentEntry."Entry No." + 1;
            DocumentEntry."Table ID" := DATABASE::"Posted Seminar Reg. Header";
            //DocumentEntry."Document Type" := DocType;
            DocumentEntry."Table Name" := PostedSeminarRegHeader.TABLECAPTION;
            DocumentEntry."No. of Records" := PostedSeminarRegHeader.COUNT;
            DocumentEntry.Insert();
        END;
    end;

    [EventSubscriber(ObjectType::Page, Page::Navigate, 'OnAfterNavigateFindRecords', '', false, false)]
    local procedure PageNavigateOnAfterNavigateFindRecords(var DocumentEntry: Record "Document Entry"; DocNoFilter: Text; PostingDateFilter: Text; var NewSourceRecVar: Variant)
    begin
        IF SeminarLedgEntry.READPERMISSION THEN BEGIN
            SeminarLedgEntry.RESET;
            SeminarLedgEntry.SETFILTER("Document No.", DocNoFilter);
            SeminarLedgEntry.SETFILTER("Posting Date", PostingDateFilter);

            DocumentEntry.Init();
            DocumentEntry."Entry No." := DocumentEntry."Entry No." + 1;
            DocumentEntry."Table ID" := DATABASE::"Seminar Ledger Entry";
            //DocumentEntry."Document Type" := DocType;
            DocumentEntry."Table Name" := SeminarLedgEntry.TABLECAPTION;
            DocumentEntry."No. of Records" := SeminarLedgEntry.COUNT;
            DocumentEntry.Insert();
        END;
    end;

    [EventSubscriber(ObjectType::Page, Page::Navigate, 'OnAfterNavigateShowRecords', '', false, false)]
    local procedure PageNavigateOnAfterNavigateShowRecords(TableID: Integer; DocNoFilter: Text; PostingDateFilter: Text; ItemTrackingSearch: Boolean; var TempDocumentEntry: Record "Document Entry" temporary; SalesInvoiceHeader: Record "Sales Invoice Header"; SalesCrMemoHeader: Record "Sales Cr.Memo Header"; PurchInvHeader: Record "Purch. Inv. Header"; PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr."; ServiceInvoiceHeader: Record "Service Invoice Header"; ServiceCrMemoHeader: Record "Service Cr.Memo Header"; ContactType: Enum "Navigate Contact Type"; ContactNo: Code[250]; ExtDocNo: Code[250])

    begin
        IF SeminarLedgEntry.READPERMISSION THEN BEGIN
            SeminarLedgEntry.RESET;
            SeminarLedgEntry.SETFILTER("Document No.", DocNoFilter);
            SeminarLedgEntry.SETFILTER("Posting Date", PostingDateFilter);
            if SeminarLedgEntry.Count = 0 then
                exit;
        END;
        IF PostedSeminarRegHeader.READPERMISSION THEN BEGIN
            PostedSeminarRegHeader.RESET;
            PostedSeminarRegHeader.SETFILTER("No.", DocNoFilter);
            PostedSeminarRegHeader.SETFILTER("Posting Date", PostingDateFilter);
            if PostedSeminarRegHeader.Count = 0 then
                exit;
        END;
        case TempDocumentEntry."Table ID" of
            DATABASE::"Posted Seminar Reg. Header":
                PAGE.RUN(0, PostedSeminarRegHeader);
            DATABASE::"Seminar Ledger Entry":
                PAGE.RUN(0, SeminarLedgEntry);
        end;
    end;

    var
        PostedSeminarRegHeader: Record "Posted Seminar Reg. Header";
        SeminarLedgEntry: Record "Seminar Ledger Entry";


}
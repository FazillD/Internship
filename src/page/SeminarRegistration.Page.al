page 73000 "Seminar Registration"
{
    ApplicationArea = All;
    Caption = 'Seminar Registration';
    SourceTable = "Seminar Registration Header";
    PageType = Document;
    UsageCategory = Administration;
    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    trigger OnAssistEdit()
                    BEGIN
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    END;
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    ApplicationArea = All;

                }
                field("Seminar No."; Rec."Seminar No.")
                {
                    ApplicationArea = All;

                }
                field("Seminar Name"; Rec."Seminar Name")
                {
                    ApplicationArea = All;

                }
                field("Instructor Resource No."; Rec."Instructor Resource No.")
                {
                    ApplicationArea = All;

                }
                field("Instructor Name"; Rec."Instructor Name")
                {
                    ApplicationArea = All;

                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;

                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;

                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;

                }
                field(Duration; Rec.Duration)
                {
                    ApplicationArea = All;

                }
                field("Minimum Participants"; Rec."Minimum Participants")
                {
                    ApplicationArea = All;

                }
                field("Maximum Participants"; Rec."Maximum Participants")
                {
                    ApplicationArea = All;

                }
            }
            part(SeminarRegistrationLines; "Seminar Registration Subform")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "Document No." = FIELD("No.");
            }
            group("Seminar Room")
            {
                field("Room Resource No."; Rec."Room Resource No.")
                {
                    ApplicationArea = All;

                }
                field("Room Name"; Rec."Room Name")
                {
                    ApplicationArea = All;

                }
                field("Room Address"; Rec."Room Address")
                {
                    ApplicationArea = All;

                }
                field("Room Address 2"; Rec."Room Address 2")
                {
                    ApplicationArea = All;

                }
                field("Room Post Code"; Rec."Room Post Code")
                {
                    ApplicationArea = All;

                }
                field("Room City"; Rec."Room City")
                {
                    ApplicationArea = All;

                }
                field("Room Country/Reg. Code"; Rec."Room Country/Reg. Code")
                {
                    ApplicationArea = All;

                }
                field("Room County"; Rec."Room County")
                {
                    ApplicationArea = All;

                }
            }
            group(Invoicing)
            {
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = All;

                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    ApplicationArea = All;

                }
                field("Seminar Price"; Rec."Seminar Price")
                {
                    ApplicationArea = All;

                }
            }
        }
        area(FactBoxes)
        {
            part("Seminar Details FactBox"; "Customer Details FactBox")
            {
                ApplicationArea = All;
                Provider = SeminarRegistrationLines;
                SubPageLink = "No." = field("Bill-to Customer No.");
            }
            systempart(Links; Links)
            {
                ApplicationArea = All;

            }
            systempart(Notes; Notes)
            {
                ApplicationArea = All;

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

    var
        myInt: Integer;
}
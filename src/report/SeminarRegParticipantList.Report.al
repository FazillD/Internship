report 67890 "Seminar Reg.-Participant List"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = RDLLayout;
    //DefaultLayout = RDLC;
    //RDLCLayout = 'reportlayout\MyRDLReport.rdl';
    Caption = 'Seminar Reg.-Participant List';
    dataset
    {
        dataitem(RegistrationHeader; "Seminar Registration Header")
        {

            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.", "Seminar No.";


            column(No_; "No.")
            {
                IncludeCaption = true;
            }
            column(Seminar_No_; "Seminar No.")
            {
                IncludeCaption = true;
            }
            column(Seminar_Name; "Seminar Name")
            {
                IncludeCaption = true;
            }
            column(Starting_Date; "Starting Date")
            {
                IncludeCaption = true;
            }
            column(Duration; Duration)
            {
                IncludeCaption = true;
            }
            column(Instructor_Name; "Instructor Name")
            {
                IncludeCaption = true;
            }
            column(Room_Name; "Room Name")
            {
                IncludeCaption = true;
            }
            dataitem(RegistrationLine; "Seminar Registration Line")
            {
                DataItemTableView = sorting("Document No.", "Line No.");
                DataItemLinkReference = RegistrationHeader;
                DataItemLink = "Document No." = field("No.");
                column(Bill_to_Customer_No_; "Bill-to Customer No.")
                {
                    IncludeCaption = true;
                }
                column(Participant_Contact_No_; "Participant Contact No.")
                {
                    IncludeCaption = true;
                }
                column(Participant_Name; "Participant Name")
                {
                    IncludeCaption = true;
                }
            }
            trigger OnAfterGetRecord()
            begin
                CALCFIELDS("Instructor Name");
            end;
        }


        dataitem(Number; Integer)
        {
            DataItemTableView = where(Number = const(1));
            column(CompanyInformation_Name; CompanyInformation.Name)
            {
                IncludeCaption = true;
            }
            trigger OnPreDataItem()
            begin
                CompanyInformation.Get();
            end;
        }
    }


    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(HideDetails; HideDetails)
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

    }


    rendering
    {
        layout(RDLLayout)
        {
            Type = RDLC;
            LayoutFile = 'reportlayout\MyRDLReport.rdl';
        }
    }
    labels
    {
        LabelName = 'Seminar Registration Header', Comment = 'Seminar Registration Header';
    }

    var
        HideDetails: Boolean;
        CompanyInformation: Record "Company Information";
}
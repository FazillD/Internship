page 74100 "Seminar Manager Role Center"
{
    PageType = RoleCenter;
    Caption = 'Seminar Manager Role Center';
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {

        area(RoleCenter)
        {

            part("Page Part"; "Seminar Manager Activities")
            {
                ApplicationArea = All;
            }
            systempart("System Part"; Outlook)
            {
                ApplicationArea = Basic, Suite;
            }


            part(Page1; "My Seminars")
            {
                ApplicationArea = All;
            }
            part(Page2; "My Customers")
            {
                ApplicationArea = Basic, Suite;
            }
            systempart(MyNotes; MyNotes)
            {
                ApplicationArea = Basic, Suite;
            }

        }
    }

    actions
    {

        area(Processing)
        {
            group(HomeItems)
            {
                Caption = 'HomeItems';
                action(SeminarRegistration)
                {
                    ApplicationArea = all;
                    Caption = 'Seminar Registration';
                    RunObject = page "Seminar Registration List";
                }
                action(Seminars)
                {
                    ApplicationArea = All;
                    Caption = 'Seminars';
                    RunObject = page "Seminar List";
                }
                action(Instructors)
                {
                    ApplicationArea = all;
                    Caption = 'Instructors';
                    RunObject = page "Resource List";
                    RunPageView = where(type = const(Person));
                }
                action(Rooms)
                {
                    ApplicationArea = All;
                    Caption = 'Rooms';
                    RunObject = page "Resource List";
                    RunPageView = where(type = const(Machine));
                }
                action(Customers)
                {
                    ApplicationArea = All;
                    Caption = 'Customers';
                    RunObject = page "Customer List";
                }
                action(Contacts)
                {
                    ApplicationArea = All;
                    Caption = 'Contacts';
                    RunObject = page "Contact List";

                }
            }
            group(ActivityButtons)
            {
                Caption = 'Posted Documents';
                Image = RegisteredDocs;
                action(PostedSeminarRegistration)
                {
                    ApplicationArea = All;
                    Caption = 'Posted Seminar Registration';
                    RunObject = page "Posted Seminar Reg. List";
                }
                action(PostedSalesInvoices)
                {
                    ApplicationArea = All;
                    Caption = 'Posted Sales Invoices';
                    RunObject = page "Posted Sales Invoice";
                }
                action(Registers)
                {
                    ApplicationArea = All;
                    Caption = 'Registers';
                    RunObject = page "Seminar Register";
                }
            }
            group(NewDocumentItems)
            {
                action(seminarreg)
                {
                    ApplicationArea = all;
                    Caption = 'Seminar Registration';
                    Image = NewTimesheet;
                    RunPageMode = Create;
                    RunObject = page "Seminar Registration";
                }
                action(SalesInvoices)
                {
                    ApplicationArea = all;
                    Caption = 'Sales Invoices';
                    Image = NewInvoice;
                    RunPageMode = Create;
                    RunObject = page "Sales Invoice";
                }
            }
            group(General)
            {
                action(CreateInvoices)
                {
                    ApplicationArea = All;
                    Caption = 'Create Invoices';
                    Image = CreateJobSalesInvoice;
                    RunObject = report "Create Seminar Invoices";
                }
                action(Navigate)
                {
                    ApplicationArea = All;
                    Caption = 'Navigate';
                    Image = Navigate;
                    RunObject = page Navigate;
                }
            }
        }
        area(Reporting)
        {
            action(ParticipantList)
            {
                ApplicationArea = All;
                Caption = 'Participant List';
                Image = Report;
                RunObject = report "Seminar Reg.-Participant List";
            }
        }

    }

    var
        myInt: Integer;
}
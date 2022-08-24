page 74000 "Seminar Registration Subform"
{
    CaptionML = ENU = 'Lines';
    SourceTable = "Seminar Registration Line";
    DelayedInsert = true;
    PageType = ListPart;
    AutoSplitKey = true;

    layout
    {
        area(Content)
        {

            repeater(GroupName)
            {
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        ShowShortcutDimCode(ShortcutDimCode);
                        SetDimensionsVisibility();
                    end;

                }
                field("Participant Contact No."; Rec."Participant Contact No.")
                {
                    ApplicationArea = All;

                }
                field("Participant Name"; Rec."Participant Name")
                {
                    ApplicationArea = All;

                }
                field(Participated; Rec.Participated)
                {
                    ApplicationArea = All;

                }
                field("Registration Date"; Rec."Registration Date")
                {
                    ApplicationArea = All;

                }
                field("Confirmation Date"; Rec."Confirmation Date")
                {
                    ApplicationArea = All;

                }
                field("To Invoice"; Rec."To Invoice")
                {
                    ApplicationArea = All;

                }
                field(Registered; Rec.Registered)
                {
                    ApplicationArea = All;

                }
                field("Seminar Price"; Rec."Seminar Price")
                {
                    ApplicationArea = All;

                }
                field("Line Discount %"; Rec."Line Discount %")
                {
                    ApplicationArea = All;

                }
                field("Line Discount Amount"; Rec."Line Discount Amount")
                {
                    ApplicationArea = All;

                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;

                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the code for Shortcut Dimension 1, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                    Visible = Dimvisible1;
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the code for Shortcut Dimension 2, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                    Visible = Dimvisible2;
                }
                field(ShortcutDimCode3; ShortcutDimCode[3])
                {
                    Visible = Dimvisible3;
                    ApplicationArea = Dimensions;
                    CaptionClass = '1,2,3';
                    TableRelation = "Dimension Value"."Code" WHERE("Global Dimension No." = CONST(3),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));

                    trigger OnValidate()
                    begin
                        ValidateShortcutDimCode(3, ShortcutDimCode[3]);
                    end;
                }
                field(ShortcutDimCode4; ShortcutDimCode[4])
                {
                    Visible = Dimvisible4;
                    ApplicationArea = Dimensions;
                    CaptionClass = '1,2,4';
                    TableRelation = "Dimension Value"."Code" WHERE("Global Dimension No." = CONST(4),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));

                    trigger OnValidate()
                    begin
                        ValidateShortcutDimCode(4, ShortcutDimCode[4]);
                    end;
                }
                field(ShortcutDimCode5; ShortcutDimCode[5])
                {
                    Visible = Dimvisible5;
                    ApplicationArea = Dimensions;
                    CaptionClass = '1,2,5';
                    TableRelation = "Dimension Value"."Code" WHERE("Global Dimension No." = CONST(5),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));

                    trigger OnValidate()
                    begin
                        ValidateShortcutDimCode(5, ShortcutDimCode[5]);
                    end;
                }
                field(ShortcutDimCode6; ShortcutDimCode[6])
                {
                    Visible = Dimvisible6;
                    ApplicationArea = Dimensions;
                    CaptionClass = '1,2,6';
                    TableRelation = "Dimension Value"."Code" WHERE("Global Dimension No." = CONST(6),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));

                    trigger OnValidate()
                    begin
                        ValidateShortcutDimCode(6, ShortcutDimCode[6]);
                    end;
                }
                field(ShortcutDimCode7; ShortcutDimCode[7])
                {
                    Visible = Dimvisible7;
                    ApplicationArea = Dimensions;
                    CaptionClass = '1,2,7';
                    TableRelation = "Dimension Value"."Code" WHERE("Global Dimension No." = CONST(7),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));

                    trigger OnValidate()
                    begin
                        ValidateShortcutDimCode(7, ShortcutDimCode[7]);
                    end;
                }
                field(ShortcutDimCode8; ShortcutDimCode[8])
                {
                    Visible = Dimvisible8;
                    ApplicationArea = Dimensions;
                    CaptionClass = '1,2,8';
                    TableRelation = "Dimension Value"."Code" WHERE("Global Dimension No." = CONST(8),
                                                                  "Dimension Value Type" = CONST(Standard),
                                                                  Blocked = CONST(false));

                    trigger OnValidate()
                    begin
                        ValidateShortcutDimCode(8, ShortcutDimCode[8]);
                    end;
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

            group(Line)
            {
                action(Dimensions)
                {
                    Image = Dimensions;
                    ShortcutKey = 'Shift+Ctrl+D';
                    trigger OnAction()
                    begin
                        ShowDimensions;
                    end;
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        ShowShortcutDimCode(ShortcutDimCode);
    end;

    trigger OnOpenPage()
    begin
        SetDimensionsVisibility();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        CLEAR(ShortcutDimCode);
    end;

    var
        ShortcutDimCode: array[8] of Code[20];
        Dimvisible1: Boolean;
        Dimvisible2: Boolean;
        Dimvisible3: Boolean;
        Dimvisible4: Boolean;
        Dimvisible5: Boolean;
        Dimvisible6: Boolean;

        Dimvisible7: Boolean;
        Dimvisible8: Boolean;

    local procedure SetDimensionsVisibility()
    var
        DimMgt: Codeunit DimensionManagement;
    begin
        DimVisible1 := false;
        DimVisible2 := false;
        DimVisible3 := false;
        DimVisible4 := false;
        DimVisible5 := false;
        DimVisible6 := false;
        DimVisible7 := false;
        DimVisible8 := false;

        DimMgt.UseShortcutDims(
          DimVisible1, DimVisible2, DimVisible3, DimVisible4, DimVisible5, DimVisible6, DimVisible7, DimVisible8);

        Clear(DimMgt);

    end;

}
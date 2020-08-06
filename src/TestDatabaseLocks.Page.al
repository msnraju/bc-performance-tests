page 50100 "Test Database Locks"
{
    PageType = NavigatePage;
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'DEMO | LOCKING SENARIOS';
    Editable = false;

    layout
    {
        area(Content)
        {
            group(General)
            {
                ShowCaption = false;
                InstructionalText = 'CLICK THE LINK TO REPLICATE:';

                group("Row Version")
                {
                    ShowCaption = false;
                    InstructionalText = 'The changes to the Customer record cannot be saved because some information on the page is not up-to-date.';

                    field("Row Version - Bad Code"; 'Execute - Bad Code')
                    {
                        ShowCaption = false;

                        trigger OnDrillDown()
                        begin
                            RowVersionBadCode.TryModifications();
                        end;
                    }

                    field("Row Version - Good Code"; 'Execute - Good Code')
                    {
                        ShowCaption = false;

                        trigger OnDrillDown()
                        begin
                            RowVersionGoodCode.TryModifications();
                        end;
                    }
                }

                group("Blocks")
                {
                    ShowCaption = false;
                    InstructionalText = 'Blocking transactions by long running processes.';

                    field("Locks - Bad Code"; 'Execute - Bad Code')
                    {
                        ShowCaption = false;

                        trigger OnDrillDown()
                        begin
                            LockTimeoutCode.BadCode();
                        end;
                    }

                    field("Locks - Good Code"; 'Execute - Good Code')
                    {
                        ShowCaption = false;

                        trigger OnDrillDown()
                        begin
                            LockTimeoutCode.GoodCode();
                        end;
                    }
                }
            }
        }
    }


    var
        RowVersionBadCode: Codeunit "Row Version - Bad Code";
        RowVersionGoodCode: Codeunit "Row Version - Good Code";
        LockTimeoutCode: Codeunit "Lock Timeout - Code";

        RowVersionLinkTxt: Label 'The changes to the Customer record cannot be saved because some information on the page is not up-to-date.';
}
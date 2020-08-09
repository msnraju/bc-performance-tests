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
            group("Concurrency")
            {
                ShowCaption = false;
                InstructionalText = 'CONCURRENCY CHECK';

                group("Row Version")
                {
                    ShowCaption = false;
                    InstructionalText = 'Code that tries to overwrite the sames record in different functions.';

                    field("Concurrency Error"; 'Click here to run the code that throws the concurrency error.')
                    {
                        ShowCaption = false;

                        trigger OnDrillDown()
                        begin
                            RowVersionBadCode.ModifyCustomer();
                        end;
                    }

                    field("No Concurrency Error"; 'Click here to run the code that doesn''t thow the concurrency error.')
                    {
                        ShowCaption = false;

                        trigger OnDrillDown()
                        begin
                            RowVersionGoodCode.TryModifications();
                        end;
                    }

                    group("Concurrency - Error")
                    {
                        ShowCaption = false;
                        InstructionalText = 'Error Message: "The changes to the Customer record cannot be saved because some information on the page is not up-to-date."';
                    }
                }
            }

            group("Dead Locks")
            {
                ShowCaption = false;
                InstructionalText = 'DEADLOCKS';

                group("How to Execute")
                {
                    ShowCaption = false;
                    InstructionalText = 'Open this page in two tabs, and click the links at the same time (within 5 secs)';
                }

                group("Dead Locks - Links")
                {
                    ShowCaption = false;
                    InstructionalText = 'If you click the first and the second links, one of the transactions will fail, and will re-execute. If you click the first and the third/the second and the third links, there should not be any problem.';

                    field("Transaction One"; 'Click here to run the code that locks the Sales Line first and the Sales Header later.')
                    {
                        ShowCaption = false;

                        trigger OnDrillDown()
                        begin
                            DeadLocksCode.LockingSequence1();
                        end;
                    }

                    field("Transactio Two"; 'Click here to run the code that locks the Sales Header first and the Sales Line later.')
                    {
                        ShowCaption = false;

                        trigger OnDrillDown()
                        begin
                            DeadLocksCode.LockingSequence2();
                        end;
                    }

                    field("Transactio Three"; 'Click here to run the code that forcefully locks the Sales Line table before the Sales Header table without changing rest of the logic.')
                    {
                        ShowCaption = false;

                        trigger OnDrillDown()
                        begin
                            DeadLocksCode.LockingSequence2Fixed();
                        end;
                    }
                }
            }

            group("Database Locks | Blocks")
            {
                ShowCaption = false;
                InstructionalText = 'DATABASE LOCKS | BLOCKS';

                group("Database Locks | Blocks - How to Execute")
                {
                    ShowCaption = false;
                    InstructionalText = 'Open this page in two tabs, and click the links at the same time (within 5 secs)';
                }

                group("Database Locks | Blocks - Links")
                {
                    ShowCaption = false;
                    InstructionalText = 'If you click the first link in two tabs at the same time, you will get the locking error message after 10 secs. If you click the second link in two tabs, you will not get any Locking Error message.';

                    field("Database Locks | Blocks - Single Transaction"; 'Click here to run the code that will run for atleast 20 secs. in a single Transaction.')
                    {
                        ShowCaption = false;

                        trigger OnDrillDown()
                        begin
                            LockTimeoutCode.First();
                        end;
                    }

                    field("Database Locks | Blocks - Multiple Transactions"; 'Click here to run the code that splits the same above Trasaction into smaller Transactions.')
                    {
                        ShowCaption = false;

                        trigger OnDrillDown()
                        begin
                            LockTimeoutCode.Second();
                        end;
                    }
                }

                group("Database Locks | Blocks - Error")
                {
                    ShowCaption = false;
                    InstructionalText = 'Error Message: "The operation could not complete because a record in the Integration Record table was locked by another user. Please retry the activity."';
                }

            }
        }
    }


    var
        RowVersionBadCode: Codeunit "Row Version - Bad Code";
        RowVersionGoodCode: Codeunit "Row Version - Good Code";
        LockTimeoutCode: Codeunit "Lock Timeout - Code";
        DeadLocksCode: Codeunit "DeadLocks - Code";

        RowVersionLinkTxt: Label 'The changes to the Customer record cannot be saved because some information on the page is not up-to-date.';
}
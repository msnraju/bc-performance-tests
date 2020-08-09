codeunit 50102 "Lock Timeout - Code"
{
    procedure First()
    var
        SalesLine: Record "Sales Line";
        Window: Dialog;
        x: Integer;
    begin
        Window.Open('#1##########');
        Window.Update(1, 'Waiting ...');
        SalesLine.FindSet();
        repeat
            x += 1;
            Window.Update(1, StrSubstNo('Processing - %1', SalesLine."No."));
            SalesLine.Modify();
            Sleep(1000);
        until (SalesLine.Next() = 0) or (x > 15);
        Window.Close();
        Message('Execution completed successfully.');
    end;

    procedure Second()
    var
        SalesLine: Record "Sales Line";
        Window: Dialog;
        x: Integer;
    begin
        Window.Open('#1##########');
        Window.Update(1, 'Waiting ...');
        SalesLine.FindSet();
        repeat
            x += 1;
            Window.Update(1, StrSubstNo('Processing - %1', SalesLine."No."));
            SalesLine.Modify();
            Sleep(1000);

            Commit();             // To generate a new Transaction
            Sleep(10);            // Allow blocked Transactions to get priority
        until (SalesLine.Next() = 0) or (x > 15);
        Window.Close();
        Message('Execution completed successfully.');
    end;
}
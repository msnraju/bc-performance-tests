codeunit 50102 "Lock Timeout - Code"
{
    procedure BadCode()
    var
        SalesLine: Record "Sales Line";
        Window: Dialog;
        x: Integer;
    begin
        Window.Open('#1##########');
        Window.Update(1, 'Started');
        SalesLine.FindSet();
        repeat
            x += 1;
            Window.Update(1, x);
            SalesLine.Modify();
            Sleep(1000);          // To mimic bigger logic that takes a sec time
        until (SalesLine.Next() = 0) or (x > 20);
        Window.Close();
    end;

    procedure GoodCode()
    var
        SalesLine: Record "Sales Line";
        Window: Dialog;
        x: Integer;
    begin
        Window.Open('#1##########');
        Window.Update(1, 'Started');
        SalesLine.FindSet();
        repeat
            x += 1;
            Window.Update(1, x);
            SalesLine.Modify();
            Sleep(1000);          // To mimic bigger logic that takes a sec time

            Commit();             // To generate a new Transaction
            Sleep(10);            // Allow blocked Transactions to get priority
        until (SalesLine.Next() = 0) or (x > 20);
        Window.Close();
    end;
}
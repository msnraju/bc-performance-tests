codeunit 50103 "DeadLocks - Code"
{
    procedure LockingSequence1()
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
    begin
        Counter1 += 1;
        SalesLine.LockTable();
        SalesLine.FindFirst();

        Sleep(5000);
        if (Counter1 > 1) then
            Message('The code with the "Sales Line, Sales Header" locking sequance has been executed more than once.');

        SalesHeader.LockTable();
        SalesHeader.FindFirst();

        Counter1 := 0;
        Message('Executed successfully.');
    end;

    procedure LockingSequence2()
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
    begin
        Counter2 += 1;
        SalesHeader.LockTable();
        SalesHeader.FindFirst();
        Sleep(5000);
        if (Counter2 > 1) then
            Message('The code with the "Sales Header, Sales Line" locking sequance has been executed more than once.');
        SalesLine.LockTable();
        SalesLine.FindFirst();

        Counter2 := 0;
        Message('Executed successfully.');
    end;

    procedure LockingSequence2Fixed()
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
    begin
        Counter3 += 1;
        SalesLine.LockTable();
        SalesLine.FindFirst();

        SalesHeader.LockTable();
        SalesHeader.FindFirst();
        Sleep(5000);

        if (Counter3 > 1) then
            Message('The code with the "Sales Line*, Sales Header" locking sequance has been executed more than once.');

        SalesLine.LockTable();
        SalesLine.FindFirst();

        Counter3 := 0;
        Message('Executed successfully.');
    end;

    var
        Counter1, Counter2, Counter3 : Integer;
}
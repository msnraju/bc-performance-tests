codeunit 50100 "Row Version - Bad Code"
{
    procedure TryModifications()
    var
        Customer: Record Customer;
    begin
        Customer.FindFirst();
        SetName(Customer);
        SetEMail(Customer);
        Message('Name: %1, E-Mail: %2', Customer.Name, Customer."E-Mail");
    end;

    local procedure SetName(Cust: Record Customer)
    begin
        Cust.Name := StrSubstNo('Customer - %1', Format(Random(10000)));
        Cust.Modify();
    end;

    local procedure SetEMail(Cust: Record Customer)
    begin
        Cust."E-Mail" := StrSubstNo('cust.%1@test.com', Format(Random(10000)));
        Cust.Modify();
    end;
}
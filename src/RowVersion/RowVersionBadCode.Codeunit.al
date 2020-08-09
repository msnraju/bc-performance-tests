codeunit 50100 "Row Version - Bad Code"
{
    procedure ModifyCustomer()
    var
        Customer: Record Customer;
    begin
        Customer.FindFirst();
        SetName(Customer);
        SetEMail(Customer);
        Message('Name: %1, E-Mail: %2', Customer.Name, Customer."E-Mail");
    end;

    local procedure SetName(Customer: Record Customer)
    begin
        Customer.Name := StrSubstNo('Customer - %1', Format(Random(10000)));
        Customer.Modify();
    end;

    local procedure SetEMail(Customer: Record Customer)
    var
        JObject: JsonObject;
    begin
        Customer."E-Mail" := StrSubstNo('cust.%1@test.com', Format(Random(10000)));
        Customer.Modify();
    end;
}
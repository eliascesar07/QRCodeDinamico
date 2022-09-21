program WorkshopPix;

uses
  Forms,
  PDV in 'PDV.pas' {frPDV},
  Config in 'Config.pas' {frConfig},
  Pagamento in 'Pagamento.pas' {frPagamento},
  PagamentoPIX in 'PagamentoPIX.pas' {frPagamentoPIX};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrPDV, frPDV);
  Application.Run;
end.

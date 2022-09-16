program WorkshopPIX;

uses
  Forms,
  PDV in 'PDV.pas' {frPDV},
  Pagamento in 'Pagamento.pas' {frPagamento},
  Config in 'Config.pas' {frConfig};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrPDV, frPDV);
  Application.Run;
end.

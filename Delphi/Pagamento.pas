unit Pagamento;

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Buttons,
  ActnList;

type

  { TfrPagamento }

  TfrPagamento = class(TForm)
    aCancelar: TAction;
    aDinheiro: TAction;
    aDebito: TAction;
    aCredito: TAction;
    aPIX: TAction;
    ActionList1: TActionList;
    pnPagamento: TPanel;
    btCartaoCredito: TSpeedButton;
    btPIX: TSpeedButton;
    btDinheiro: TSpeedButton;
    btCartaoDebito: TSpeedButton;
    procedure aCancelarExecute(Sender: TObject);
    procedure aFormaPagtoExecute(Sender: TObject);
    procedure aPIXExecute(Sender: TObject);
  private

  public

  end;

implementation

uses PagamentoPIX;

{$R *.dfm}

{ TfrPagamento }

procedure TfrPagamento.aFormaPagtoExecute(Sender: TObject);
begin
  ModalResult := mrOK;
end;

procedure TfrPagamento.aCancelarExecute(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfrPagamento.aPIXExecute(Sender: TObject);
var
  wPix: TfrPagamentoPIX;
begin
  wPix := TfrPagamentoPIX.Create(Self);

  if wPix.CriarCobranca and (wPix.ShowModal = mrOK) then
    ModalResult := mrOK;
end;

end.


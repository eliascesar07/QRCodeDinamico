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
    ActionList1: TActionList;
    pnPagamento: TPanel;
    btCartaoCredito: TSpeedButton;
    btDinheiro: TSpeedButton;
    btCartaoDebito: TSpeedButton;
    procedure aCancelarExecute(Sender: TObject);
    procedure aFormaPagtoExecute(Sender: TObject);
  private

  public

  end;

implementation

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

end.


unit PDV;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  Buttons, ACBrPIXCD, Grids, ActnList;

type

  TVendaDados = record
    ClienteDoc: String;
    ClienteNome: String;
    Total: Currency;
    UltPagamento_E2E: String;
    UltPagamento_Valor: Currency;
  end;

  { TfrPDV }

  TfrPDV = class(TForm)
    aConfigurar: TAction;
    aIncluirItem: TAction;
    aExcluirItem: TAction;
    aEfetuarPagamento: TAction;
    alAcoesPDV: TActionList;
    btEfetuarPagamento: TSpeedButton;
    edClienteDoc: TEdit;
    edClienteNome: TEdit;
    edItemDescricao: TEdit;
    edItemEAN: TEdit;
    edItemValor: TEdit;
    gbCliente: TGroupBox;
    gbItens: TGroupBox;
    gbStatus: TGroupBox;
    gbTotal: TGroupBox;
    gdItens: TStringGrid;
    lbTitulo: TLabel;
    lbClienteDoc: TLabel;
    lbClienteNome: TLabel;
    lbItemDescricao: TLabel;
    lbItemEAN: TLabel;
    lbItemValor: TLabel;
    pnOpcoes: TPanel;
    pnHeader: TPanel;
    pnItemRodape: TPanel;
    pnBackground: TPanel;
    pnCliente: TPanel;
    pnDadosItem: TPanel;
    pnRodape: TPanel;
    pnStatus: TPanel;
    pnTotalStr: TPanel;
    btItemIncluir: TSpeedButton;
    btItemExcluir: TSpeedButton;
    btConfiguracao: TSpeedButton;
    procedure aConfigurarExecute(Sender: TObject);
    procedure aEfetuarPagamentoExecute(Sender: TObject);
    procedure aExcluirItemExecute(Sender: TObject);
    procedure aIncluirItemExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    fVendaDados: TVendaDados;

    procedure AtualizarTotal;  
    procedure IniciarNovaVenda;
    procedure AvaliarInterface;
    procedure LimparInterface;
    procedure ExcluirItemGrid(aIndex: Integer);
    procedure AtualizarStatus(aStatus: String; aCor: TColor);
    procedure AdicionarItemGrid(aEan, aDescricao: String; aValor: Double);
  public
    property VendaDados: TVendaDados read fVendaDados;
  end;

var
  frPDV: TfrPDV;

implementation

uses
  Config, Pagamento,
  ACBrUtil.Base;

{$R *.lfm}

{ TfrPDV }

procedure TfrPDV.FormCreate(Sender: TObject);
begin
  IniciarNovaVenda;
end;

procedure TfrPDV.aEfetuarPagamentoExecute(Sender: TObject);
var
  wP: TfrPagamento;
begin
  fVendaDados.ClienteDoc := edClienteDoc.Text;
  fVendaDados.ClienteNome := edClienteNome.Text;

  if NaoEstaVazio(fVendaDados.ClienteNome) and EstaVazio(fVendaDados.ClienteDoc) then
  begin
    ShowMessage('Necessário preencher o CPF/CNPJ do cliente');
    edClienteDoc.SetFocus;
    Exit;
  end;

  AtualizarStatus('PAGANDO', $0000D3D9);
  try
    wP := TfrPagamento.Create(Self);
    if (wP.ShowModal = mrOK) then
      IniciarNovaVenda;
  finally
    AtualizarStatus('VENDENDO', $00FFBF80);
  end;
end;

procedure TfrPDV.aConfigurarExecute(Sender: TObject);
var
  wC: TfrConfig;
begin
  wC := TfrConfig.Create(Self);
  wC.ShowModal;
end;

procedure TfrPDV.aExcluirItemExecute(Sender: TObject);
begin
  if (MessageDlg('Deseja realmente excluir o Item?', mtConfirmation, mbOKCancel, 0) = mrNo) then
    Exit;

  ExcluirItemGrid(gdItens.Row);
  AtualizarTotal;
end;

procedure TfrPDV.aIncluirItemExecute(Sender: TObject);
begin
  if EstaVazio(edItemDescricao.Text) then
  begin
    ShowMessage('Informe a Descrição do Item');
    edItemDescricao.SetFocus;
  end
  else if EstaVazio(edItemEAN.Text) then
  begin
    ShowMessage('Informe o Código EAN do Item');
    edItemEAN.SetFocus;
  end
  else
  begin
    AdicionarItemGrid(
      Trim(edItemEAN.Text),
      Trim(edItemDescricao.Text),
      StrToFloatDef(edItemValor.Text, 1));

    AtualizarTotal;
  end;
end;

procedure TfrPDV.AtualizarTotal;
var
  I: Integer;
begin
  fVendaDados.Total := 0;
  for I := 1 to Pred(gdItens.RowCount) do
    fVendaDados.Total := fVendaDados.Total +
      StrToCurrDef(StringReplace(gdItens.Cells[2, I], '.', '', []), 0);
  AvaliarInterface;
end;

procedure TfrPDV.IniciarNovaVenda;
begin
  fVendaDados.Total := 0;
  fVendaDados.ClienteDoc := EmptyStr;
  fVendaDados.ClienteNome := EmptyStr;
  LimparInterface;

  AtualizarTotal;
end;

procedure TfrPDV.AvaliarInterface;
begin
  aExcluirItem.Enabled := (fVendaDados.Total > 0);
  aEfetuarPagamento.Enabled := (fVendaDados.Total > 0);
  aEfetuarPagamento.Visible := (fVendaDados.Total > 0);
  pnTotalStr.Caption := FormatFloatBr(fVendaDados.Total, 'R$ ,0.00');
end;

procedure TfrPDV.LimparInterface;
begin
  edItemEAN.Clear;
  edItemValor.Clear;
  edItemDescricao.Clear;
  edClienteDoc.Clear;
  edClienteNome.Clear;

  with gdItens do
  begin
    RowCount := 1;
    ColWidths[0] := 130;
    ColWidths[1] := 200;
    ColWidths[2] := 130;

    Cells[0,0] := 'EAN';
    Cells[1,0] := 'Descrição';
    Cells[2,0] := 'Valor';
  end;
end;

procedure TfrPDV.ExcluirItemGrid(aIndex: Integer);
var
  I, J: Integer;
begin
  with gdItens do
  begin
    for I := aIndex to RowCount - 2 do
      for J := 0 to ColCount - 1 do
        Cells[J, I] := Cells[J, I+1];

    RowCount := RowCount - 1
  end;
end;

procedure TfrPDV.AtualizarStatus(aStatus: String; aCor: TColor);
begin
  pnStatus.Color := aCor;
  pnStatus.Caption := aStatus;
end;

procedure TfrPDV.AdicionarItemGrid(aEan, aDescricao: String; aValor: Double);
begin
  with gdItens do
  begin
    RowCount := RowCount + 1;
    Cells[0, RowCount-1] := aEAN;
    Cells[1, RowCount-1] := aDescricao;
    Cells[2, RowCount-1] := FormatFloatBr(aValor);
  end;
end;

end.


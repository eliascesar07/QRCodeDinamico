unit PagamentoPIX;

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  ComCtrls, Buttons, ActnList, ACBrPIXCD, ACBrPIXBase, ACBrPIXPSPBancoDoBrasil,
  ACBrPIXPSPItau, ACBrBase;

type

  TCobrancaDados = record
    E2E: String;
    txID: String;
    location: String;
    CopiaECola: String;
    Status: TACBrPIXStatusCobranca;
    EmErro: Boolean;
  end;

  { TfrPagamentoPIX }

  TfrPagamentoPIX = class(TForm)
    ACBrPixCD1: TACBrPixCD;
    ACBrPSPBancoDoBrasil1: TACBrPSPBancoDoBrasil;
    ACBrPSPItau1: TACBrPSPItau;
    aTentarNovamente: TAction;
    aCancelarCobranca: TAction;
    aFechar: TAction;
    alPagamentoPIX: TActionList;
    btCopiaECola: TSpeedButton;
    edCopiaECola: TEdit;
    imQRCodePIX: TImage;
    lbCopiaECola: TLabel;
    pnConsultarErro: TPanel;
    pbAguardarPagto: TProgressBar;
    pnBody: TPanel;
    pnCopiaECola: TPanel;
    pnCobrancaInfo: TPanel;
    pnStatusCobranca: TPanel;
    btTentarNovamente: TSpeedButton;
    bt: TSpeedButton;
    tmConsultarCobranca: TTimer;
    procedure aCancelarCobrancaExecute(Sender: TObject);
    procedure aFecharExecute(Sender: TObject);
    procedure aTentarNovamenteExecute(Sender: TObject);
    procedure btCopiaEColaClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure tmConsultarCobrancaTimer(Sender: TObject);
  private
    fCobrancaDados: TCobrancaDados;

    procedure AvaliarInterface;
    procedure HabilitarInterface(Liberado: Boolean);
  public
    procedure Clear;

    function CriarCobranca: Boolean;
    function CancelarCobranca: Boolean;
    function ConsultarCobranca: Boolean;
    function EstornarPagamento(aE2e: String; aValor: Currency): Boolean;

    property CobrancaDados: TCobrancaDados read fCobrancaDados write fCobrancaDados;
  end;

implementation

uses
  PDV, Config, Clipbrd, ACBrUtil.Base, ACBrImage,
  ACBrDelphiZXingQRCode;

{$R *.dfm}

{ TfrPagamentoPIX }

procedure TfrPagamentoPIX.FormCreate(Sender: TObject);
var
  wConfig: TPDVConfig;
begin
  Clear;

  wConfig := TPDVConfig.Create;
  try
    wConfig.LerConfig;
    ACBrPixCD1.Recebedor.Nome := wConfig.RecebedorNome;
    ACBrPixCD1.Recebedor.Cidade := wConfig.RecebedorCidade;

    ACBrPSPBancoDoBrasil1.ChavePIX := wConfig.ChavePix;
    ACBrPSPBancoDoBrasil1.ClientID := wConfig.ClientID;
    ACBrPSPBancoDoBrasil1.ClientSecret := wConfig.ClientSecret;
    ACBrPSPBancoDoBrasil1.DeveloperApplicationKey := wConfig.DeveloperAppKey;

    ACBrPSPItau1.ChavePIX := wConfig.ChavePix;
    ACBrPSPItau1.ClientID := wConfig.ClientID;
    ACBrPSPItau1.ClientSecret := wConfig.ClientSecret;
    ACBrPSPItau1.ArquivoCertificado := wConfig.ArqCertificado;
    ACBrPSPItau1.ArquivoChavePrivada := wConfig.ArqChavePrivada;
  finally
    wConfig.Free;
  end;
end;

procedure TfrPagamentoPIX.tmConsultarCobrancaTimer(Sender: TObject);
begin
  tmConsultarCobranca.Enabled := False;
  try
    ConsultarCobranca;
  finally
    if (CobrancaDados.Status = stcATIVA) and (not CobrancaDados.EmErro) then
      tmConsultarCobranca.Enabled := True;
  end;
end;

procedure TfrPagamentoPIX.AvaliarInterface;

  procedure AtualizarStatusCobranca(aStatus: String; aCor: TColor);
  begin
    pnStatusCobranca.Caption := aStatus;
    pnStatusCobranca.Color := aCor;
  end;

begin
  pnCobrancaInfo.Enabled := (CobrancaDados.Status = stcATIVA) and (not CobrancaDados.EmErro);
  pbAguardarPagto.Visible := (CobrancaDados.Status = stcATIVA);
  pnConsultarErro.Visible := CobrancaDados.EmErro;

  if CobrancaDados.EmErro then
  begin
    AtualizarStatusCobranca('ERRO AO CONSULTAR COBRANÇA', clRed);
    Exit;
  end;

  case CobrancaDados.Status of
    stcATIVA: AtualizarStatusCobranca('AGUARDANDO PAGAMENTO...', $0000D3D9);
    stcREMOVIDA_PELO_USUARIO_RECEBEDOR: AtualizarStatusCobranca('COBRANÇA CANCELADA', $000600EA);
    stcREMOVIDA_PELO_PSP: AtualizarStatusCobranca('REMOVIDA PELO PSP', $000600EA);

    stcCONCLUIDA:
    begin
      AtualizarStatusCobranca('PAGAMENTO CONCLUÍDO', $0009E31F);

      with frPDV.VendaDados do
      begin
        UltPagamento_E2E := CobrancaDados.E2E;
        UltPagamento_Valor := frPDV.VendaDados.Total;
      end;
    end
  else
    AtualizarStatusCobranca('SEM COBRANÇA', $000600EA);
  end;
end;

procedure TfrPagamentoPIX.HabilitarInterface(Liberado: Boolean);
begin
  pnCobrancaInfo.Enabled := Liberado;
  pnConsultarErro.Enabled := Liberado;
end;

procedure TfrPagamentoPIX.btCopiaEColaClick(Sender: TObject);
begin
  Clipboard.AsText := Trim(edCopiaECola.Text);
end;

procedure TfrPagamentoPIX.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if (CobrancaDados.Status = stcATIVA) then
    CanClose := (MessageDlg('Cobrança está pendente. Deseja cancelar?',
                  mtConfirmation, [mbYes,mbNo], 0) = mrYes) and CancelarCobranca
  else if (CobrancaDados.Status = stcCONCLUIDA) then
    ModalResult := mrOK;
end;

procedure TfrPagamentoPIX.aFecharExecute(Sender: TObject);
begin
  if (CobrancaDados.Status = stcCONCLUIDA) then
    ModalResult := mrOK
  else
    ModalResult := mrAbort;
end;

procedure TfrPagamentoPIX.aCancelarCobrancaExecute(Sender: TObject);
begin
  CancelarCobranca;
end;

procedure TfrPagamentoPIX.aTentarNovamenteExecute(Sender: TObject);
begin
  if ConsultarCobranca and (CobrancaDados.Status = stcATIVA) then
    tmConsultarCobranca.Enabled := True;
end;

procedure TfrPagamentoPIX.Clear;
begin
  fCobrancaDados.txID := EmptyStr;
  fCobrancaDados.location := EmptyStr;
  fCobrancaDados.CopiaECola := EmptyStr;
  fCobrancaDados.Status := stcNENHUM;
  fCobrancaDados.EmErro := False;
end;

function TfrPagamentoPIX.CriarCobranca: Boolean;
begin
  HabilitarInterface(False);
  try
    with ACBrPixCD1.PSP.epCob.CobSolicitada do
    begin
      chave := ACBrPixCD1.PSP.ChavePIX;
      valor.original := frPDV.VendaDados.Total;
      devedor.nome := frPDV.VendaDados.ClienteNome;
      calendario.expiracao := 300;

      if (Length(frPDV.VendaDados.ClienteDoc) > 11) then
        devedor.cnpj := frPDV.VendaDados.ClienteDoc
      else
        devedor.cpf := frPDV.VendaDados.ClienteDoc;
    end;

    Result := ACBrPixCD1.PSP.epCob.CriarCobrancaImediata;

    if Result then
    begin
       fCobrancaDados.txID := Trim(ACBrPixCD1.PSP.epCob.CobGerada.txId);
       fCobrancaDados.location := Trim(ACBrPixCD1.PSP.epCob.CobGerada.location);
       fCobrancaDados.CopiaECola := Trim(ACBrPixCD1.PSP.epCob.CobGerada.pixCopiaECola);

       if EstaVazio(CobrancaDados.CopiaECola) then
         fCobrancaDados.CopiaECola := ACBrPixCD1.GerarQRCodeDinamico(CobrancaDados.location);

       edCopiaECola.Text := CobrancaDados.CopiaECola;
       PintarQRCode(CobrancaDados.CopiaECola, imQRCodePIX.Picture.Bitmap, qrUTF8BOM);

       ConsultarCobranca;
       tmConsultarCobranca.Enabled := True;
    end
    else
      ShowMessage('Erro ao criar cobrança');
  finally
    HabilitarInterface(True);
  end;
end;

function TfrPagamentoPIX.CancelarCobranca: Boolean;
begin
  HabilitarInterface(False);
  try
    Result := False;

    if EstaVazio(CobrancaDados.txID) then
    begin
      ShowMessage('Nenhuma cobrança para ser cancelada');
      Exit;
    end;

    ACBrPixCD1.PSP.epCob.CobRevisada.status := stcREMOVIDA_PELO_USUARIO_RECEBEDOR;
    Result := ACBrPixCD1.PSP.epCob.RevisarCobrancaImediata(CobrancaDados.txID);

    if (not Result) then
      ShowMessage('Falha ao Cancelar Cobrança');
  finally
    HabilitarInterface(True);
  end;
end;

function TfrPagamentoPIX.ConsultarCobranca: Boolean;
begin
  HabilitarInterface(False);
  try
    Result := False;
    if EstaVazio(CobrancaDados.txID) then
    begin
      ShowMessage('Nenhuma cobrança para ser consultada');
      Exit;
    end;

    Result := ACBrPixCD1.PSP.epCob.ConsultarCobrancaImediata(CobrancaDados.txID);
    fCobrancaDados.EmErro := (not Result);

    if Result then
    begin
      fCobrancaDados.Status := ACBrPixCD1.PSP.epCob.CobCompleta.status;

      if (ACBrPixCD1.PSP.epCob.CobCompleta.pix.Count > 0) then
        fCobrancaDados.E2E := ACBrPixCD1.PSP.epCob.CobCompleta.pix[0].endToEndId;
    end
    else
    begin
      fCobrancaDados.Status := stcNENHUM;
      ShowMessage('Erro ao consultar cobrança');
    end;

    AvaliarInterface;
  finally
    HabilitarInterface(True);
  end;
end;

function TfrPagamentoPIX.EstornarPagamento(aE2e: String; aValor: Currency): Boolean;
var
  wIDDevolucao: String;
begin
  Result := False;
  if (MessageDlg('Deseja realmente estornar o pagamento?', mtConfirmation, [mbYes,mbNo], 0) = mrNo) then
    Exit;

  if EstaVazio(aE2e) then
  begin
    ShowMessage('E2E não informado');
    Exit;
  end;

  with ACBrPixCD1.PSP.epPix do
  begin
    DevolucaoSolicitada.Clear;
    DevolucaoSolicitada.valor := aValor;
    DevolucaoSolicitada.natureza := ndORIGINAL;
    DevolucaoSolicitada.descricao := 'Cancelamento de Venda';

    wIDDevolucao := StringReplace(aE2e, 'E', 'D', [rfReplaceAll]);
    Result := SolicitarDevolucaoPix(aE2e, wIDDevolucao);

    if Result then
      ShowMessage('Solicitação do Estorno efetuada com sucesso')
    else
      ShowMessage('Erro ao estornar Pagamento');
  end;
end;

end.


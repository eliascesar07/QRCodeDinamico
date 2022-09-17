unit Config;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Buttons;

type

  { TPDVConfig }

  TPDVConfig = class
  private
    fArqCertificado: String;
    fArqChavePrivada: String;
    fChavePix: String;
    fCidade: String;
    fClientID: String;
    fClientSecret: String;
    fDeveloperAppKey: String;
    fLogArquivo: String;
    fLogNivel: Integer;
    fRecebedorNome: String;
    function GetNomeArquivoConfig: String;

  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;

    procedure LerConfig;
    procedure GravarConfig;

    property NomeArquivoConfig: String read GetNomeArquivoConfig;

    // Log
    property LogNivel: Integer read fLogNivel write fLogNivel;
    property LogArquivo: String read fLogArquivo write fLogArquivo;

    // Recebedor
    property RecebedorNome: String read fRecebedorNome write fRecebedorNome;
    property RecebedorCidade: String read fCidade write fCidade;

    // PSP
    property ChavePix: String read fChavePix write fChavePix;
    property ClientID: String read fClientID write fClientID;
    property ClientSecret: String read fClientSecret write fClientSecret;

    // Banco do Brasil
    property DeveloperAppKey: String read fDeveloperAppKey write fDeveloperAppKey;

    // PSP Itaú
    property ArqCertificado: String read fArqCertificado write fArqCertificado;
    property ArqChavePrivada: String read fArqChavePrivada write fArqChavePrivada;
  end;

  { TfrConfig }

  TfrConfig = class(TForm)
    btCancelar: TSpeedButton;
    btSalvar: TSpeedButton;
    cbLogNivel: TComboBox;
    edLogArquivo: TEdit;
    edRecebedorCidade: TEdit;
    edRecebedorNome: TEdit;
    gbLog: TGroupBox;
    gbRecebedor: TGroupBox;
    lbLogArquivo: TLabel;
    lbLogNivel: TLabel;
    lbRecebedorCidade: TLabel;
    lbRecebedorNome: TLabel;
    pnRecebedor: TPanel;
    pnLog: TPanel;
    pnConfigHeader: TPanel;
    pnConfigPIX: TPanel;
    pnRodape: TPanel;
    procedure btCancelarClick(Sender: TObject);
    procedure btSalvarClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    fPDVConfig: TPDVConfig;
    function GetPDVConfig: TPDVConfig;
    procedure ValidarCampos;

  public
    property PDVConfig: TPDVConfig read GetPDVConfig;
  end;

var
  frConfig: TfrConfig;

implementation

uses
  PDV, IniFiles, ACBrUtil.Base;

{$R *.lfm}

{ TPDVConfig }

function TPDVConfig.GetNomeArquivoConfig: String;
begin
  Result := ChangeFileExt(ApplicationName, '.ini');
end;

constructor TPDVConfig.Create;
begin
  Clear;
end;

destructor TPDVConfig.Destroy;
begin
  inherited Destroy;
end;

procedure TPDVConfig.Clear;
begin
  fLogNivel := 0;
  fChavePix := EmptyStr;
  fCidade := EmptyStr;
  fClientID := EmptyStr;
  fClientSecret := EmptyStr;
  fDeveloperAppKey := EmptyStr;
  fLogArquivo := EmptyStr;
  fRecebedorNome := EmptyStr;
  fArqCertificado := EmptyStr;
  fArqChavePrivada := EmptyStr;
end;

procedure TPDVConfig.LerConfig;
var
  wIni: TIniFile;
begin
  wIni := TIniFile.Create(NomeArquivoConfig);
  try
    RecebedorNome := wIni.ReadString('Recebedor', 'Nome', '');
    RecebedorCidade := wIni.ReadString('Recebedor', 'Cidade', '');

    LogArquivo := wIni.ReadString('Log', 'Arquivo', '');
    LogNivel := wIni.ReadInteger('Log', 'Nivel', 1);

    // PSP
    ChavePix := wIni.ReadString('PSP', 'ChavePIX', '');
    ClientID := wIni.ReadString('PSP', 'ClientID', '');
    ClientSecret := wIni.ReadString('PSP', 'ClientSecret', '');

    // Banco do Brasil
    DeveloperAppKey := wIni.ReadString('BancoBrasil', 'DeveloperApplicationKey', '');

    // Itaú
    ArqCertificado := wIni.ReadString('Itau', 'ArqCertificado', '');
    ArqChavePrivada := wIni.ReadString('Itau', 'ArqChavePrivada', '');
  finally
    wIni.Free;
  end;
end;

procedure TPDVConfig.GravarConfig;
var
  wIni: TIniFile;
begin
  wIni := TIniFile.Create(NomeArquivoConfig);
  try
    wIni.WriteString('Recebedor', 'Nome', RecebedorNome);
    wIni.WriteString('Recebedor', 'Cidade', RecebedorCidade);

    wIni.WriteString('Log', 'Arquivo', LogArquivo);
    wIni.WriteInteger('Log', 'Nivel', LogNivel);

    wIni.WriteString('PSP', 'ChavePIX', ChavePix);
    wIni.WriteString('PSP', 'ClientID', ClientID);
    wIni.WriteString('PSP', 'ClientSecret', ClientSecret);

    // Banco do Brasil
    wIni.WriteString('BancoBrasil', 'DeveloperApplicationKey', DeveloperAppKey);

    // Itaú
    wIni.WriteString('Itau', 'ArqCertificado', ArqCertificado);
    wIni.WriteString('Itau', 'ArqChavePrivada', ArqChavePrivada);
  finally
    wIni.Free;
  end;
end;

{ TfrConfig }

procedure TfrConfig.btCancelarClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfrConfig.btSalvarClick(Sender: TObject);
begin
  ValidarCampos;

  PDVConfig.RecebedorNome := edRecebedorNome.Text;
  PDVConfig.RecebedorCidade := edRecebedorCidade.Text;

  PDVConfig.LogNivel := cbLogNivel.ItemIndex;
  PDVConfig.LogArquivo := edLogArquivo.Text;

  PDVConfig.GravarConfig;
  ModalResult := mrOK;
end;

procedure TfrConfig.FormDestroy(Sender: TObject);
begin
  if Assigned(fPDVConfig) then
    fPDVConfig.Free;
end;

procedure TfrConfig.FormShow(Sender: TObject);
begin
  PDVConfig.LerConfig;

  edRecebedorNome.Text := PDVConfig.RecebedorNome;
  edRecebedorCidade.Text := PDVConfig.RecebedorCidade;

  cbLogNivel.ItemIndex := PDVConfig.LogNivel;
  edLogArquivo.Text := PDVConfig.LogArquivo;
end;

function TfrConfig.GetPDVConfig: TPDVConfig;
begin
  if (not Assigned(fPDVConfig)) then
    fPDVConfig := TPDVConfig.Create;

  Result := fPDVConfig;
end;

procedure TfrConfig.ValidarCampos;
var
  wErros: TStringList;

  procedure ValidarCampo(aNomeCampo: String; aEdit: TEdit);
  begin
    if EstaVazio(aEdit.Text) then
      wErros.Add(' - ' + aNomeCampo + ' não pode ser vazio');
  end;

begin
  wErros := TStringList.Create;
  try
    ValidarCampo('Nome do Recebedor', edRecebedorNome);
    ValidarCampo('Cidade do Recebedor', edRecebedorCidade);

    if (wErros.Count > 0) then
    begin
      wErros.Insert(0, ' Verifique os erros antes de Gravar:' + sLineBreak);
      ShowMessage(wErros.Text);
      Abort;
    end;
  finally
    wErros.Free;
  end;
end;

end.


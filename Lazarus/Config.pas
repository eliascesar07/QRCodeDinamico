unit Config;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Buttons;

type

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
    procedure FormShow(Sender: TObject);
  private
    procedure ValidarCampos;

  public

  end;

var
  frConfig: TfrConfig;

implementation

uses
  PDV, ACBrUtil.Base;

{$R *.lfm}

{ TfrConfig }

procedure TfrConfig.btCancelarClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfrConfig.btSalvarClick(Sender: TObject);
begin
  ValidarCampos;

  //

  ModalResult := mrOK;
end;

procedure TfrConfig.FormShow(Sender: TObject);
begin
  //
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


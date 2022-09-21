object frConfig: TfrConfig
  Left = 415
  Top = 152
  AutoSize = True
  BorderStyle = bsDialog
  Caption = 'Configura'#231#245'es'
  ClientHeight = 644
  ClientWidth = 700
  Color = 16510433
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poOwnerFormCenter
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnConfigPIX: TPanel
    Left = 0
    Top = 0
    Width = 700
    Height = 595
    Align = alClient
    Anchors = []
    AutoSize = True
    BevelOuter = bvNone
    TabOrder = 0
    object gbPSPBancoDoBrasil: TGroupBox
      Left = 0
      Top = 131
      Width = 700
      Height = 179
      Align = alTop
      Caption = 'PSP Banco do Brasil'
      TabOrder = 1
      object pnBancoDoBrasil: TPanel
        Left = 2
        Top = 15
        Width = 696
        Height = 162
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        DesignSize = (
          696
          162)
        object lbBBChavePIX: TLabel
          Left = 15
          Top = 10
          Width = 51
          Height = 13
          Caption = 'Chave PIX'
          Color = clBtnFace
          ParentColor = False
        end
        object lbBBClientID: TLabel
          Left = 331
          Top = 10
          Width = 40
          Height = 13
          Anchors = [akLeft, akBottom]
          Caption = 'Client ID'
          Color = clBtnFace
          ParentColor = False
        end
        object lbBBClientSecret: TLabel
          Left = 15
          Top = 58
          Width = 60
          Height = 13
          Caption = 'Client Secret'
          Color = clBtnFace
          ParentColor = False
        end
        object lbBBDevAppKey: TLabel
          Left = 15
          Top = 106
          Width = 125
          Height = 13
          Caption = 'Developer Application Key'
          Color = clBtnFace
          ParentColor = False
        end
        object edBBChavePIX: TEdit
          Left = 15
          Top = 25
          Width = 296
          Height = 21
          TabOrder = 0
        end
        object edBBClientID: TEdit
          Left = 331
          Top = 25
          Width = 290
          Height = 21
          PasswordChar = '*'
          TabOrder = 1
        end
        object edBBClientSecret: TEdit
          Left = 15
          Top = 73
          Width = 606
          Height = 21
          PasswordChar = '*'
          TabOrder = 2
        end
        object edBBDevAppKey: TEdit
          Left = 15
          Top = 121
          Width = 606
          Height = 21
          PasswordChar = '*'
          TabOrder = 3
        end
      end
    end
    object pnConfigHeader: TPanel
      Left = 0
      Top = 0
      Width = 700
      Height = 131
      Align = alTop
      AutoSize = True
      BevelOuter = bvNone
      TabOrder = 0
      object gbLog: TGroupBox
        Left = 383
        Top = 0
        Width = 317
        Height = 131
        Align = alRight
        Caption = 'Log'
        TabOrder = 1
        object pnLog: TPanel
          Left = 2
          Top = 15
          Width = 313
          Height = 114
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 0
          object lbLogArquivo: TLabel
            Left = 8
            Top = 58
            Width = 36
            Height = 13
            Caption = 'Arquivo'
            Color = clBtnFace
            ParentColor = False
          end
          object lbLogNivel: TLabel
            Left = 8
            Top = 10
            Width = 26
            Height = 13
            Caption = 'N'#237'vel'
            Color = clBtnFace
            ParentColor = False
          end
          object edLogArquivo: TEdit
            Left = 8
            Top = 73
            Width = 290
            Height = 21
            TabOrder = 1
          end
          object cbLogNivel: TComboBox
            Left = 8
            Top = 25
            Width = 290
            Height = 21
            Style = csDropDownList
            ItemHeight = 13
            ItemIndex = 2
            TabOrder = 0
            Text = 'Normal'
            Items.Strings = (
              'Nenhum'
              'Baixo'
              'Normal'
              'Alto'
              'Muito Alto')
          end
        end
      end
      object gbRecebedor: TGroupBox
        Left = 0
        Top = 0
        Width = 383
        Height = 131
        Align = alClient
        Caption = 'Recebedor'
        TabOrder = 0
        object pnRecebedor: TPanel
          Left = 2
          Top = 15
          Width = 379
          Height = 114
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 0
          DesignSize = (
            379
            114)
          object lbRecebedorNome: TLabel
            Left = 15
            Top = 10
            Width = 28
            Height = 13
            Caption = 'Nome'
            Color = clBtnFace
            ParentColor = False
          end
          object lbRecebedorCidade: TLabel
            Left = 15
            Top = 63
            Width = 33
            Height = 13
            Caption = 'Cidade'
            Color = clBtnFace
            ParentColor = False
          end
          object edRecebedorNome: TEdit
            Left = 15
            Top = 25
            Width = 296
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            TabOrder = 0
          end
          object edRecebedorCidade: TEdit
            Left = 15
            Top = 78
            Width = 296
            Height = 21
            TabOrder = 1
          end
        end
      end
    end
    object gbPSPItau: TGroupBox
      Left = 0
      Top = 310
      Width = 700
      Height = 227
      Align = alTop
      Caption = 'PSP Ita'#250
      TabOrder = 2
      object pnPSPItau: TPanel
        Left = 2
        Top = 15
        Width = 696
        Height = 210
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        DesignSize = (
          696
          210)
        object lbItauChavePIX: TLabel
          Left = 15
          Top = 10
          Width = 51
          Height = 13
          Caption = 'Chave PIX'
          Color = clBtnFace
          ParentColor = False
        end
        object lbItauClientID: TLabel
          Left = 331
          Top = 10
          Width = 40
          Height = 13
          Anchors = [akLeft, akBottom]
          Caption = 'Client ID'
          Color = clBtnFace
          ParentColor = False
        end
        object lbItauClientSecret: TLabel
          Left = 15
          Top = 58
          Width = 60
          Height = 13
          Caption = 'Client Secret'
          Color = clBtnFace
          ParentColor = False
        end
        object lbItauArqChavePrivada: TLabel
          Left = 15
          Top = 106
          Width = 109
          Height = 13
          Caption = 'Arquivo Chave Privada'
          Color = clBtnFace
          ParentColor = False
        end
        object lbItauArqCertificado: TLabel
          Left = 15
          Top = 154
          Width = 89
          Height = 13
          Caption = 'Arquivo Certificado'
          Color = clBtnFace
          ParentColor = False
        end
        object btArqChavePrivada: TSpeedButton
          Left = 597
          Top = 121
          Width = 24
          Height = 23
          Hint = 'Abrir Arquivo de Log'
          Flat = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Glyph.Data = {
            36040000424D3604000000000000360000002800000010000000100000000100
            2000000000000004000064000000640000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0005000000430000005500000055000000550000005500000055000000550000
            0055000000550000005500000055000000400000000400000000000000000000
            0031000000F6000000FF000000FF000000FF000000FF000000FF000000FF0000
            00FF000000FF000000FF000000FF000000F30000002E00000000000000000000
            0038000000FF000000C000000071000000710000007100000071000000710000
            00710000007100000071000000C0000000FF0000003800000000000000000000
            0038000000FF0000008E00000000000000000000000000000000000000000000
            000000000000000000000000008E000000FF0000003800000000000000000000
            0038000000FF0000008E00000000000000000000000000000000000000000000
            000000000000000000000000008E000000FF0000003800000000000000000000
            0038000000FF0000008E00000000000000000000000000000000000000000000
            000000000000000000000000008E000000FF0000003800000000000000000000
            0038000000FF0000008E00000000000000000000000000000000000000000000
            000000000000000000000000008E000000FF0000003800000000000000000000
            0038000000FF000000A700000038000000380000003800000038000000380000
            00380000003800000038000000A7000000FF0000003800000000000000000000
            0038000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
            00FF000000FF000000FF000000FF000000FA0000003300000000000000000000
            0038000000FF000000FF000000FF000000FF000000FF000000FF000000D60000
            008E0000008E0000008E0000008E000000680000000800000000000000000000
            002F000000F3000000FF000000FF000000FF000000FF000000CF000000160000
            0000000000000000000000000000000000000000000000000000000000000000
            00040000003D0000005500000055000000550000005500000019000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000}
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          OnClick = btArqChavePrivadaClick
        end
        object btArqCertificado: TSpeedButton
          Left = 597
          Top = 169
          Width = 24
          Height = 23
          Hint = 'Abrir Arquivo de Log'
          Flat = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Glyph.Data = {
            36040000424D3604000000000000360000002800000010000000100000000100
            2000000000000004000064000000640000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0005000000430000005500000055000000550000005500000055000000550000
            0055000000550000005500000055000000400000000400000000000000000000
            0031000000F6000000FF000000FF000000FF000000FF000000FF000000FF0000
            00FF000000FF000000FF000000FF000000F30000002E00000000000000000000
            0038000000FF000000C000000071000000710000007100000071000000710000
            00710000007100000071000000C0000000FF0000003800000000000000000000
            0038000000FF0000008E00000000000000000000000000000000000000000000
            000000000000000000000000008E000000FF0000003800000000000000000000
            0038000000FF0000008E00000000000000000000000000000000000000000000
            000000000000000000000000008E000000FF0000003800000000000000000000
            0038000000FF0000008E00000000000000000000000000000000000000000000
            000000000000000000000000008E000000FF0000003800000000000000000000
            0038000000FF0000008E00000000000000000000000000000000000000000000
            000000000000000000000000008E000000FF0000003800000000000000000000
            0038000000FF000000A700000038000000380000003800000038000000380000
            00380000003800000038000000A7000000FF0000003800000000000000000000
            0038000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
            00FF000000FF000000FF000000FF000000FA0000003300000000000000000000
            0038000000FF000000FF000000FF000000FF000000FF000000FF000000D60000
            008E0000008E0000008E0000008E000000680000000800000000000000000000
            002F000000F3000000FF000000FF000000FF000000FF000000CF000000160000
            0000000000000000000000000000000000000000000000000000000000000000
            00040000003D0000005500000055000000550000005500000019000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000}
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          OnClick = btArqCertificadoClick
        end
        object edItauChavePIX: TEdit
          Left = 15
          Top = 25
          Width = 296
          Height = 21
          TabOrder = 0
        end
        object edItauClientID: TEdit
          Left = 331
          Top = 25
          Width = 290
          Height = 21
          PasswordChar = '*'
          TabOrder = 1
        end
        object edItauClientSecret: TEdit
          Left = 15
          Top = 73
          Width = 606
          Height = 21
          PasswordChar = '*'
          TabOrder = 2
        end
        object edItauArqChavePrivada: TEdit
          Left = 15
          Top = 121
          Width = 582
          Height = 21
          TabOrder = 3
        end
        object edItauArqCertificado: TEdit
          Left = 15
          Top = 169
          Width = 582
          Height = 21
          TabOrder = 4
        end
      end
    end
  end
  object pnRodape: TPanel
    Left = 0
    Top = 595
    Width = 700
    Height = 49
    Align = alBottom
    BevelOuter = bvNone
    Color = 15914423
    TabOrder = 1
    object btSalvar: TSpeedButton
      Left = 360
      Top = 0
      Width = 170
      Height = 49
      Caption = '&Salvar'
      Flat = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000064000000640000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000005000000390000007F000000A3000000A20000
        007B000000360000000300000000000000000000000000000000000000000000
        00000000000000000018000000AC000000F6000000FF000000FF000000FF0000
        00FF000000F4000000A400000014000000000000000000000000000000000000
        000000000018000000CE000000FF000000FF000000FF000000FF000000FF0000
        00FF000000FF000000FF000000C6000000120000000000000000000000000000
        0005000000AC000000FF000000FF000000FF000000DD000000F9000000FF0000
        00FF000000FF000000FF000000FF000000A00000000300000000000000000000
        0039000000F6000000FF000000FF000000B70000001800000078000000FC0000
        00FF000000FF000000FF000000FF000000F20000003000000000000000000000
        007F000000FF000000FF000000B9000000170000003E0000000C0000007C0000
        00FB000000FF000000FF000000FF000000FF0000007000000000000000000000
        00A3000000FF000000C20000001100000062000000F20000009E000000070000
        007C000000FC000000FF000000FF000000FF0000009600000000000000000000
        00A2000000FF000000CB0000006F000000FA000000FF000000FF0000009E0000
        000C00000078000000F9000000FF000000FF0000009400000000000000000000
        007B000000FF000000FF000000FF000000FF000000FF000000FF000000FD0000
        009B0000000E00000078000000FC000000FF0000006D00000000000000000000
        0036000000F4000000FF000000FF000000FF000000FF000000FF000000FF0000
        00FD0000009B0000000C000000A2000000F00000002C00000000000000000000
        0003000000A4000000FF000000FF000000FF000000FF000000FF000000FF0000
        00FF000000FD000000B2000000EF000000980000000200000000000000000000
        000000000014000000C6000000FF000000FF000000FF000000FF000000FF0000
        00FF000000FF000000FF000000BD0000000E0000000000000000000000000000
        00000000000000000012000000A0000000F2000000FF000000FF000000FF0000
        00FF000000F0000000980000000E000000000000000000000000000000000000
        0000000000000000000000000003000000300000007000000095000000940000
        006D0000002C0000000200000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000}
      OnClick = btSalvarClick
    end
    object btCancelar: TSpeedButton
      Left = 530
      Top = 0
      Width = 170
      Height = 49
      Caption = 'Cancelar'
      Flat = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000064000000640000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000005000000390000007F000000A3000000A20000
        007C000000360000000400000000000000000000000000000000000000000000
        00000000000000000019000000AC000000F6000000FF000000FF000000FF0000
        00FF000000F4000000A500000014000000000000000000000000000000000000
        000000000019000000CF000000FF000000FF000000FF000000FF000000FF0000
        00FF000000FF000000FF000000C6000000130000000000000000000000000000
        0005000000AC000000FF000000FE000000DA000000FC000000FF000000FF0000
        00FB000000DB000000FE000000FF000000A00000000300000000000000000000
        0039000000F6000000FF000000DA0000001C0000008E000000FC000000FB0000
        008300000020000000E2000000FF000000F20000003000000000000000000000
        007F000000FF000000FF000000FC0000008E000000100000008E000000820000
        001000000099000000FD000000FF000000FF0000007100000000000000000000
        00A3000000FF000000FF000000FF000000FC0000008E0000000B0000000B0000
        009A000000FD000000FF000000FF000000FF0000009600000000000000000000
        00A2000000FF000000FF000000FF000000FB000000820000000B0000000B0000
        008E000000FC000000FF000000FF000000FF0000009400000000000000000000
        007C000000FF000000FF000000FB00000083000000100000009A0000008E0000
        00100000008E000000FC000000FF000000FF0000006E00000000000000000000
        0036000000F4000000FF000000DB0000002000000099000000FD000000FC0000
        008E00000024000000E3000000FF000000F00000002C00000000000000000000
        0004000000A5000000FF000000FE000000E2000000FD000000FF000000FF0000
        00FC000000E3000000FE000000FF000000990000000200000000000000000000
        000000000014000000C7000000FF000000FF000000FF000000FF000000FF0000
        00FF000000FF000000FF000000BE0000000F0000000000000000000000000000
        00000000000000000013000000A0000000F2000000FF000000FF000000FF0000
        00FF000000F0000000990000000F000000000000000000000000000000000000
        0000000000000000000000000003000000300000007100000095000000940000
        006E0000002C0000000200000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000}
      OnClick = btCancelarClick
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 152
    Top = 16
  end
end

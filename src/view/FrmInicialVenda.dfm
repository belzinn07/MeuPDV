object FormInicialVenda: TFormInicialVenda
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Iniciar Venda - MeuPDV'
  ClientHeight = 510
  ClientWidth = 1108
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  TextHeight = 15
  object pnlBox: TPanel
    Left = 0
    Top = 0
    Width = 1108
    Height = 510
    Align = alClient
    BevelOuter = bvNone
    Color = 16513528
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 0
    object Label1: TLabel
      Left = 56
      Top = 157
      Width = 54
      Height = 21
      Caption = 'Cliente'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object pnlCabecalho: TPanel
      Left = 0
      Top = 0
      Width = 1108
      Height = 60
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Iniciar Venda'
      Color = 10838318
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -19
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 0
      ExplicitWidth = 500
    end
    object cbxSelecionarCliente: TComboBox
      Left = 56
      Top = 184
      Width = 417
      Height = 29
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object edtFatura: TLabeledEdit
      Left = 56
      Top = 112
      Width = 417
      Height = 29
      EditLabel.Width = 48
      EditLabel.Height = 21
      EditLabel.Caption = 'Fatura'
      EditLabel.Font.Charset = DEFAULT_CHARSET
      EditLabel.Font.Color = clWindowText
      EditLabel.Font.Height = -16
      EditLabel.Font.Name = 'Segoe UI'
      EditLabel.Font.Style = [fsBold]
      EditLabel.ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      Text = ''
    end
    object btnConfirmar: TBitBtn
      Left = 95
      Top = 244
      Width = 120
      Height = 40
      Caption = '&Confirmar'
      Kind = bkYes
      NumGlyphs = 2
      TabOrder = 3
      OnClick = btnConfirmarClick
    end
    object btnCancelar: TBitBtn
      Left = 311
      Top = 244
      Width = 120
      Height = 40
      Caption = 'Cancelar'
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 4
    end
  end
  object pnlContainer: TPanel
    Left = 0
    Top = 0
    Width = 1108
    Height = 510
    Align = alClient
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 1
    ExplicitWidth = 500
    ExplicitHeight = 700
  end
end

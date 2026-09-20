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
  KeyPreview = True
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  TextHeight = 15
  object pnlContainer: TPanel
    AlignWithMargins = True
    Left = 200
    Top = 100
    Width = 708
    Height = 310
    Margins.Left = 200
    Margins.Top = 100
    Margins.Right = 200
    Margins.Bottom = 100
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 706
    ExplicitHeight = 302
    object pnlBox: TPanel
      Left = 1
      Top = 1
      Width = 706
      Height = 308
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
      ExplicitWidth = 704
      ExplicitHeight = 300
      object lblCodigoCliente: TLabel
        Left = 160
        Top = 157
        Width = 55
        Height = 21
        Caption = 'C'#243'digo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblCliente: TLabel
        Left = 256
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
        Width = 706
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
        ExplicitWidth = 704
      end
      object cbxSelecionarCliente: TComboBox
        Left = 256
        Top = 184
        Width = 321
        Height = 29
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnChange = cbxSelecionarClienteChange
      end
      object edtFatura: TLabeledEdit
        Left = 160
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
        OnExit = edtFaturaExit
        OnKeyDown = edtFaturaKeyDown
      end
      object btnConfirmar: TBitBtn
        Left = 199
        Top = 244
        Width = 120
        Height = 40
        Caption = '&Confirmar'
        ModalResult = 6
        NumGlyphs = 2
        TabOrder = 3
        OnClick = btnConfirmarClick
      end
      object btnCancelar: TBitBtn
        Left = 415
        Top = 244
        Width = 120
        Height = 40
        Caption = 'Cancelar'
        Kind = bkCancel
        NumGlyphs = 2
        TabOrder = 4
        OnClick = btnCancelarClick
      end
      object edtIdCliente: TEdit
        Left = 160
        Top = 184
        Width = 81
        Height = 29
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        OnExit = edtIdClienteExit
        OnKeyDown = edtIdClienteKeyDown
      end
    end
  end
end

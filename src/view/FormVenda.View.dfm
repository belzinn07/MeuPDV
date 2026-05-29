object frmVendas: TfrmVendas
  Left = 0
  Top = 0
  BorderStyle = bsSizeToolWin
  Caption = 'MeuPDV - Venda'
  ClientHeight = 730
  ClientWidth = 1124
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poDesktopCenter
  WindowState = wsMaximized
  TextHeight = 15
  object pnlContainer: TPanel
    Left = 0
    Top = 0
    Width = 1124
    Height = 730
    Align = alClient
    BevelOuter = bvNone
    Color = clWhite
    ParentBackground = False
    TabOrder = 0
    ExplicitWidth = 1122
    ExplicitHeight = 722
    object pnlCabecalho: TPanel
      Left = 0
      Top = 0
      Width = 1124
      Height = 81
      Align = alTop
      BevelOuter = bvNone
      Color = 9063714
      ParentBackground = False
      TabOrder = 0
      ExplicitWidth = 1122
      object Label1: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 10
        Width = 1118
        Height = 68
        Margins.Top = 10
        Align = alClient
        Alignment = taCenter
        Caption = 'Caixa Aberto'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -32
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitWidth = 196
        ExplicitHeight = 45
      end
    end
    object pnlRodape: TPanel
      Left = 0
      Top = 648
      Width = 1124
      Height = 82
      Align = alBottom
      BevelOuter = bvNone
      Color = 9063714
      FullRepaint = False
      Padding.Left = 50
      Padding.Top = 10
      Padding.Bottom = 10
      ParentBackground = False
      TabOrder = 1
      ExplicitTop = 640
      ExplicitWidth = 1122
      object pnlFecharVenda: TPanel
        AlignWithMargins = True
        Left = 60
        Top = 10
        Width = 120
        Height = 62
        Margins.Left = 10
        Margins.Top = 0
        Margins.Bottom = 0
        Align = alLeft
        BevelOuter = bvNone
        Color = 9063714
        ParentBackground = False
        TabOrder = 0
        object Shape1: TShape
          Left = 0
          Top = 0
          Width = 120
          Height = 62
          Align = alClient
          Brush.Color = 16513528
          Pen.Style = psClear
          Shape = stRoundRect
          ExplicitLeft = 296
          ExplicitTop = 16
          ExplicitWidth = 65
          ExplicitHeight = 65
        end
        object btnFecharVenda: TSpeedButton
          Left = 0
          Top = 0
          Width = 120
          Height = 62
          Align = alClient
          Caption = 'Fechar Venda'
          Flat = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = -1
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          ExplicitLeft = 40
          ExplicitTop = 24
          ExplicitWidth = 23
          ExplicitHeight = 22
        end
      end
      object pnlCancelarVenda: TPanel
        AlignWithMargins = True
        Left = 193
        Top = 10
        Width = 120
        Height = 62
        Margins.Left = 10
        Margins.Top = 0
        Margins.Bottom = 0
        Align = alLeft
        BevelOuter = bvNone
        Color = 9063714
        ParentBackground = False
        TabOrder = 1
        object Shape7: TShape
          Left = 0
          Top = 0
          Width = 120
          Height = 62
          Align = alClient
          Brush.Color = 16513528
          Pen.Style = psClear
          Shape = stRoundRect
          ExplicitLeft = 296
          ExplicitTop = 16
          ExplicitWidth = 65
          ExplicitHeight = 65
        end
        object btnCancelarVenda: TSpeedButton
          Left = 0
          Top = 0
          Width = 120
          Height = 62
          Align = alClient
          Caption = 'Cancelar Venda'
          Flat = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = -1
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          ExplicitLeft = 40
          ExplicitTop = 24
          ExplicitWidth = 23
          ExplicitHeight = 22
        end
      end
      object pnlConfirmarProduto: TPanel
        AlignWithMargins = True
        Left = 326
        Top = 10
        Width = 120
        Height = 62
        Margins.Left = 10
        Margins.Top = 0
        Margins.Bottom = 0
        Align = alLeft
        BevelOuter = bvNone
        Color = 9063714
        ParentBackground = False
        TabOrder = 2
        object Shape8: TShape
          Left = 0
          Top = 0
          Width = 120
          Height = 62
          Align = alClient
          Brush.Color = 16513528
          Pen.Style = psClear
          Shape = stRoundRect
          ExplicitLeft = 296
          ExplicitTop = 16
          ExplicitWidth = 65
          ExplicitHeight = 65
        end
        object btnConfirmarProduto: TSpeedButton
          Left = 0
          Top = 0
          Width = 120
          Height = 62
          Align = alClient
          Caption = 'Confirmar Produto'
          Flat = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = -1
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          ExplicitLeft = 40
          ExplicitTop = 24
          ExplicitWidth = 23
          ExplicitHeight = 22
        end
      end
    end
    object pnlLateral: TPanel
      Left = 724
      Top = 81
      Width = 400
      Height = 567
      Align = alRight
      BevelOuter = bvNone
      Color = 16513528
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 7568383
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      Padding.Top = 5
      Padding.Bottom = 20
      ParentBackground = False
      ParentFont = False
      TabOrder = 2
      ExplicitLeft = 722
      ExplicitHeight = 559
      object pnlTotalCompra: TPanel
        AlignWithMargins = True
        Left = 3
        Top = 474
        Width = 394
        Height = 70
        Align = alBottom
        BevelOuter = bvNone
        Color = 16513528
        ParentBackground = False
        TabOrder = 0
        ExplicitTop = 466
        object Shape4: TShape
          Left = 0
          Top = 19
          Width = 394
          Height = 51
          Align = alClient
          Brush.Color = 9063714
          Pen.Style = psClear
          Shape = stRoundRect
          ExplicitLeft = 296
          ExplicitTop = 16
          ExplicitWidth = 65
          ExplicitHeight = 65
        end
        object lblTotalCompra: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 0
          Width = 391
          Height = 19
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alTop
          Caption = 'Total de Compra'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ExplicitWidth = 119
        end
        object pnledtTotalCompra: TPanel
          AlignWithMargins = True
          Left = 3
          Top = 22
          Width = 388
          Height = 45
          Align = alClient
          BevelOuter = bvNone
          Color = 9063714
          ParentBackground = False
          TabOrder = 0
          object lblPrecoTotalCompra: TLabel
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 382
            Height = 39
            Align = alClient
            Alignment = taCenter
            Caption = 'R$ 0,0'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -24
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
            ExplicitWidth = 65
            ExplicitHeight = 32
          end
        end
      end
      object pnlSubtotal: TPanel
        AlignWithMargins = True
        Left = 3
        Top = 398
        Width = 394
        Height = 70
        Align = alBottom
        BevelOuter = bvNone
        Color = 16513528
        ParentBackground = False
        TabOrder = 1
        ExplicitTop = 390
        object Shape2: TShape
          Left = 0
          Top = 19
          Width = 394
          Height = 51
          Align = alClient
          Brush.Color = 9063714
          Pen.Style = psClear
          Shape = stRoundRect
          ExplicitLeft = 296
          ExplicitTop = 16
          ExplicitWidth = 65
          ExplicitHeight = 65
        end
        object lblSubTotal: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 0
          Width = 391
          Height = 19
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alTop
          Caption = 'Sub Total'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ExplicitWidth = 68
        end
        object pnledtSubtotal: TPanel
          AlignWithMargins = True
          Left = 3
          Top = 22
          Width = 388
          Height = 45
          Align = alClient
          BevelOuter = bvNone
          Color = 9063714
          ParentBackground = False
          TabOrder = 0
          object lblPrecoSubTotal: TLabel
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 382
            Height = 39
            Align = alClient
            Alignment = taCenter
            Caption = 'R$ 0,0'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -24
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
            ExplicitWidth = 65
            ExplicitHeight = 32
          end
        end
      end
      object pnlQuantidade: TPanel
        AlignWithMargins = True
        Left = 3
        Top = 322
        Width = 394
        Height = 70
        Align = alBottom
        BevelOuter = bvNone
        Color = 16513528
        ParentBackground = False
        TabOrder = 2
        ExplicitTop = 314
        object Shape3: TShape
          Left = 0
          Top = 19
          Width = 394
          Height = 51
          Align = alClient
          Brush.Color = 9063714
          Pen.Style = psClear
          Shape = stRoundRect
          ExplicitLeft = 296
          ExplicitTop = 16
          ExplicitWidth = 65
          ExplicitHeight = 65
        end
        object lblQuantidade: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 0
          Width = 391
          Height = 19
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alTop
          Caption = 'Quantidade'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ExplicitWidth = 81
        end
        object pnledtQuantidade: TPanel
          AlignWithMargins = True
          Left = 3
          Top = 22
          Width = 388
          Height = 45
          Align = alClient
          BevelOuter = bvNone
          Color = 9063714
          ParentBackground = False
          TabOrder = 0
          object Edit1: TEdit
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 382
            Height = 39
            Align = alClient
            Alignment = taCenter
            BorderStyle = bsNone
            Color = 9063714
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -24
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            Text = '0,0'
          end
        end
      end
      object pnlPreco: TPanel
        AlignWithMargins = True
        Left = 3
        Top = 246
        Width = 394
        Height = 70
        Align = alBottom
        BevelOuter = bvNone
        Color = 16513528
        ParentBackground = False
        TabOrder = 3
        ExplicitTop = 238
        object Shape5: TShape
          Left = 0
          Top = 19
          Width = 394
          Height = 51
          Align = alClient
          Brush.Color = 9063714
          Pen.Style = psClear
          Shape = stRoundRect
          ExplicitLeft = 296
          ExplicitTop = 16
          ExplicitWidth = 65
          ExplicitHeight = 65
        end
        object lblPreco: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 0
          Width = 391
          Height = 19
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alTop
          Caption = 'Pre'#231'o'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ExplicitWidth = 39
        end
        object pnledtPreco: TPanel
          AlignWithMargins = True
          Left = 3
          Top = 22
          Width = 388
          Height = 45
          Align = alClient
          BevelOuter = bvNone
          Color = 9063714
          ParentBackground = False
          TabOrder = 0
          object edtPreco: TEdit
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 382
            Height = 39
            Align = alClient
            Alignment = taCenter
            BorderStyle = bsNone
            Color = 9063714
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -24
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            Text = 'R$ 0,0'
          end
        end
      end
      object pnlProduto: TPanel
        AlignWithMargins = True
        Left = 3
        Top = 170
        Width = 394
        Height = 70
        Align = alBottom
        BevelOuter = bvNone
        Color = 16513528
        ParentBackground = False
        TabOrder = 4
        ExplicitTop = 162
        object Shape6: TShape
          Left = 0
          Top = 19
          Width = 394
          Height = 51
          Align = alClient
          Brush.Color = 9063714
          Pen.Style = psClear
          Shape = stRoundRect
          ExplicitLeft = 296
          ExplicitTop = 16
          ExplicitWidth = 65
          ExplicitHeight = 65
        end
        object lblProduto: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 0
          Width = 391
          Height = 19
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alTop
          Caption = 'Produto'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ExplicitWidth = 56
        end
        object pnledtProduto: TPanel
          AlignWithMargins = True
          Left = 3
          Top = 22
          Width = 388
          Height = 45
          Align = alClient
          BevelOuter = bvNone
          Color = 9063714
          ParentBackground = False
          TabOrder = 0
          object edtProduto: TEdit
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 382
            Height = 39
            Align = alClient
            Alignment = taCenter
            BorderStyle = bsNone
            Color = 9063714
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -24
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            Text = '00000'
          end
        end
      end
    end
    object DBGrid1: TDBGrid
      Left = 0
      Top = 81
      Width = 724
      Height = 567
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 7568383
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'ID'
          Title.Caption = 'C'#211'DIGO'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DESCRICAO'
          Width = 410
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PRECO'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ESTOQUE'
          Visible = True
        end>
    end
  end
end

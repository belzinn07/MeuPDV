object FormConfirmacao: TFormConfirmacao
  Left = 0
  Top = 0
  Caption = 'FormConfirmacao'
  ClientHeight = 166
  ClientWidth = 392
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  TextHeight = 15
  object plnGeral: TPanel
    Left = 0
    Top = 0
    Width = 392
    Height = 166
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 390
    ExplicitHeight = 158
    object lblMensagem: TLabel
      Left = 48
      Top = 80
      Width = 66
      Height = 21
      Caption = 'AAAAAA'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object pnlTopo: TPanel
      Left = 1
      Top = 1
      Width = 390
      Height = 41
      Align = alTop
      Color = 6888724
      ParentBackground = False
      TabOrder = 0
      ExplicitWidth = 388
      object Confirmação: TLabel
        Left = 16
        Top = 2
        Width = 145
        Height = 28
        Caption = 'Confirmar a'#231#227'o'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -20
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object btnSim: TButton
      Left = 200
      Top = 112
      Width = 75
      Height = 33
      Caption = 'Sim'
      TabOrder = 1
    end
    object btnNao: TButton
      Left = 296
      Top = 112
      Width = 75
      Height = 33
      Caption = 'N'#227'o'
      TabOrder = 2
    end
  end
end

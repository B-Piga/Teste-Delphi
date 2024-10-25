object pesquisaCliForm: TpesquisaCliForm
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'pesquisaCliForm'
  ClientHeight = 229
  ClientWidth = 528
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 528
    Height = 169
    Align = alTop
    DataSource = Dm.DS_Cliente
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = 'Segoe UI Semibold'
    TitleFont.Style = []
    OnDblClick = DBGrid1DblClick
  end
  object Panel1: TPanel
    Left = 0
    Top = 169
    Width = 528
    Height = 60
    Align = alClient
    TabOrder = 1
    object Label1: TLabel
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 520
      Height = 17
      Align = alTop
      Alignment = taCenter
      Caption = 'Pesquise pelo nome do cliente'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI Semibold'
      Font.Style = []
      ParentFont = False
      ExplicitWidth = 185
    end
    object editNome: TEdit
      AlignWithMargins = True
      Left = 4
      Top = 27
      Width = 520
      Height = 21
      Align = alTop
      Alignment = taCenter
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Segoe UI Semibold'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnChange = editNomeChange
    end
  end
end

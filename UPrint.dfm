object frmPrint: TfrmPrint
  Left = 192
  Top = 107
  BorderStyle = bsDialog
  Caption = 'Print'
  ClientHeight = 182
  ClientWidth = 269
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object gbPrinter: TGroupBox
    Left = 3
    Top = 0
    Width = 265
    Height = 57
    Caption = 'Printer'
    TabOrder = 0
    object lblName: TLabel
      Left = 12
      Top = 22
      Width = 35
      Height = 13
      AutoSize = False
      Caption = 'Name'
    end
    object cbPrinter: TComboBox
      Left = 48
      Top = 18
      Width = 209
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 0
      OnChange = cbPrinterChange
    end
  end
  object gbPreview: TGroupBox
    Left = 3
    Top = 64
    Width = 265
    Height = 117
    Caption = 'Preview'
    TabOrder = 1
    object Label1: TLabel
      Left = 179
      Top = 21
      Width = 14
      Height = 17
      AutoSize = False
      Caption = '%'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object lblSize: TLabel
      Left = 80
      Top = 24
      Width = 49
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Size'
    end
    object imgPreview: TImage
      Left = 8
      Top = 16
      Width = 65
      Height = 41
      AutoSize = True
    end
    object sedtGrand: TSpinEdit
      Left = 136
      Top = 19
      Width = 41
      Height = 22
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Increment = 5
      MaxValue = 100
      MinValue = 10
      ParentFont = False
      TabOrder = 0
      Value = 50
      OnChange = sedtGrandChange
    end
    object btnOk: TButton
      Left = 80
      Top = 85
      Width = 75
      Height = 25
      Caption = '&Ok'
      Default = True
      ModalResult = 1
      TabOrder = 1
      OnClick = btnOkClick
    end
    object btnCancel: TButton
      Left = 182
      Top = 85
      Width = 75
      Height = 25
      Caption = '&Cancel'
      ModalResult = 2
      TabOrder = 2
      OnClick = btnCancelClick
    end
  end
end

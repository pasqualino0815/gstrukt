object frmOptions: TfrmOptions
  Left = 857
  Top = 242
  BorderStyle = bsDialog
  Caption = 'Options'
  ClientHeight = 224
  ClientWidth = 236
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object gbPosition: TGroupBox
    Left = 3
    Top = 1
    Width = 224
    Height = 120
    Caption = 'Position && Font'
    TabOrder = 0
    object lblTop: TLabel
      Left = 5
      Top = 26
      Width = 60
      Height = 15
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Top'
    end
    object lblLeft: TLabel
      Left = 113
      Top = 26
      Width = 57
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Left'
    end
    object lblFont: TLabel
      Left = 5
      Top = 58
      Width = 60
      Height = 13
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Font'
    end
    object edtTop: TEdit
      Left = 72
      Top = 24
      Width = 38
      Height = 21
      MaxLength = 4
      TabOrder = 0
      Text = '20'
    end
    object edtLeft: TEdit
      Left = 176
      Top = 24
      Width = 33
      Height = 21
      MaxLength = 4
      TabOrder = 1
      Text = '20'
    end
    object cbFont: TComboBox
      Left = 72
      Top = 56
      Width = 139
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 2
      Items.Strings = (
        'Courier New'
        'Arial'
        'Verdana')
    end
    object chkReplace: TCheckBox
      Left = 8
      Top = 88
      Width = 209
      Height = 17
      Caption = 'Replace empty sequences '
      Checked = True
      State = cbChecked
      TabOrder = 3
    end
  end
  object btnOk: TButton
    Left = 4
    Top = 192
    Width = 89
    Height = 25
    Caption = '&Ok'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object btnCancel: TButton
    Left = 153
    Top = 192
    Width = 75
    Height = 25
    Caption = '&Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object gbLanguage: TGroupBox
    Left = 4
    Top = 128
    Width = 224
    Height = 57
    Caption = 'Language'
    TabOrder = 3
    object cbLanguage: TComboBox
      Left = 8
      Top = 24
      Width = 205
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 0
      OnChange = cbLanguageChange
    end
  end
end

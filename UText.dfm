object frmText: TfrmText
  Left = 588
  Top = 123
  BorderStyle = bsDialog
  Caption = 'Add Text'
  ClientHeight = 158
  ClientWidth = 312
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
  object btnText: TButton
    Left = 8
    Top = 128
    Width = 129
    Height = 25
    Caption = '&Ok'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object memText: TMemo
    Left = 8
    Top = 8
    Width = 297
    Height = 113
    ScrollBars = ssBoth
    TabOrder = 1
    WordWrap = False
    OnChange = memTextChange
  end
  object btnCancel: TButton
    Left = 184
    Top = 128
    Width = 121
    Height = 25
    Caption = '&Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object edtText: TEdit
    Left = 8
    Top = 8
    Width = 297
    Height = 21
    TabOrder = 3
    OnChange = edtTextChange
  end
end

unit UOptions;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IniFiles, Menus, UPrint, UText;

type
  TfrmOptions = class(TForm)
    gbPosition: TGroupBox;
    edtTop: TEdit;
    edtLeft: TEdit;
    lblTop: TLabel;
    lblLeft: TLabel;
    btnOk: TButton;
    btnCancel: TButton;
    cbFont: TComboBox;
    lblFont: TLabel;
    gbLanguage: TGroupBox;
    cbLanguage: TComboBox;
    chkReplace: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure cbLanguageChange(Sender: TObject);
  private
    { Private declarations }
    procedure GetLanguages;
    procedure SetLanguage(S: String);
  public
    { Public declarations }
  end;

var
  frmOptions: TfrmOptions;

implementation

uses UMain;

{$R *.dfm}

procedure TfrmOptions.FormShow(Sender: TObject);
begin
  cbFont.ItemIndex := cbFont.Items.IndexOf(frmMain.pbxStrukt.Canvas.Font.Name);
  //Ausgewählte Schrift ermitteln (vom Main Canvas des Main Forms
end;

procedure TfrmOptions.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  try                   {Feststellen op Offset nicht '' &  < 0 & numerisch ist }
    if(edtTop.Text  = '')
    then edtTop.Text  := '0'
    else if(strtoint(edtTop.Text) < 0)then edtTop.Text := '0';
    if(edtLeft.Text = '')
    then edtLeft.Text := '0'
    else if(strtoint(edtLeft.Text) < 0)then edtLeft.Text := '0';
  except
    ShowMessage('Error Position must be an numeric value!');
    edtTop.Text := inttostr(frmMain.OFSETX);
    edtLeft.Text := inttostr(frmMain.OFSETY);
    CanClose := False;
  end;
end;

procedure TfrmOptions.GetLanguages;
{******************************************************
 * Erstellen der Liste von Sprachen in cbLanguages    *
 * dynamisch nach der in languages\ vorhandenen       *
 * INI-Dateien in denen Dateiname = Name in der Datei *
 ******************************************************}
var
  SR: TSearchRec;
  Path, Language, FileName : String;
  LANG : TIniFile;
begin
  Path := ExtractFilePath(Application.ExeName)+ 'languages\';
  if FindFirst(Path + '*.ini', faAnyFile, SR) = 0
  then begin
    repeat
      if(SR.Attr <> faDirectory)
      then begin
        LANG := TIniFile.Create(Path+SR.Name);
        Language := LANG.ReadString('LANG','NAME','');
        FileName := ChangeFileExt(SR.Name,'');
        FileName[1] := Upcase(FileName[1]);
        if(Language <> '')and(Language = FileName)
        then cbLanguage.Items.Add(Language);
        LANG.Free;
      end;
    until FindNext(SR) <> 0;
    FindClose(SR);
  end;
end;

procedure TfrmOptions.FormCreate(Sender: TObject);
var
  Parameter : TIniFile;
begin
  GetLanguages;
  //Programm Parameter aus der INI-Datei auslesen
  Parameter := TIniFile.Create(ExtractFilePath(Application.ExeName)+'strukt.ini');
  cbLanguage.ItemIndex := cbLanguage.Items.IndexOf(Parameter.ReadString('PROGRAM','Language',''));
  chkReplace.Checked := Parameter.ReadBool('PROGRAM','Replace',True);
  SetLanguage(cbLanguage.Text);
  frmMain.pbxStrukt.Canvas.Font.Name := Parameter.ReadString('PROGRAM','Font','');
  Parameter.Free;
end;

procedure TfrmOptions.SetLanguage(S: String);
var
  Lang : TIniFile;
  I, J : integer;
begin
  while(pos('&',S) <> 0)do delete(S,pos('&',S),1);
  Lang := TIniFile.Create(ExtractFilePath(Application.ExeName)+ '\languages\'+S+'.ini');
  with frmOptions
  do begin                        {Setzen der Captions des Formulars frmOptions}
    gbPosition.Caption := Lang.ReadString('LANG',gbPosition.Name,'');
    btnCancel.Caption  := Lang.ReadString('LANG',btnCancel.Name,'');
    lblFont.Caption    := Lang.ReadString('LANG',lblFont.Name,'');
    lblTop.Caption     := Lang.ReadString('LANG',lblTop.Name,'');
    lblLeft.Caption    := Lang.ReadString('LANG',lblLeft.Name,'');
    chkReplace.Caption := Lang.ReadString('LANG',chkReplace.Name,'');
    S := Lang.ReadString('LANG',frmMain.mmiOptions.Name,'');
    while(pos('&',S) <> 0)        {Löschen der Wildcards von mmiOptions.Name   }
    do delete(S,pos('&',S),1);    {für die Formualr Caption                    }
    Caption            := S;
  end;
  with frmPrint                   {Setzen der Captions des Formulars frmPrint  }
  do begin
    btnCancel.Caption := Lang.ReadString('LANG',btnCancel.Name,'');
    lblSize.Caption := Lang.ReadString('LANG',lblSize.Name,'');
    gbPreview.Caption := Lang.ReadString('LANG',gbPreview.Name,'');
    Caption := Lang.ReadString('LANG',Name,'');
  end;                              {Setzen der Captions des Formulars frmText }
  frmText.Caption := Lang.ReadString('LANG',frmText.Name,'');
  frmText.btnCancel.Caption := Lang.ReadString('LANG',frmOptions.btnCancel.Name,'');
  gbLanguage.Caption := Lang.ReadString('LANG',gbLanguage.Name,'');
  with frmMain                      {Setzen der Captions des Formulars frmMain }
  do begin                          {Setzen der Menuitems Caption's            }
    for I := 0 to mnuMain.Items.Count - 1
    do mnuMain.Items[I].Caption := Lang.ReadString('LANG',mnuMain.Items[I].Name,'');
    for I := 0 to mnuMain.Items.Count - 1
    do begin
      for J := 0 to mnuMain.Items[I].Count - 1
      do mnuMain.Items[I].Items[J].Caption := Lang.ReadString('LANG',mnuMain.Items[I].Items[J].Name,'');
    end;
    for I := 0 to frmMain.tbrToolbar.ButtonCount - 1
    do frmMain.tbrToolbar.Buttons[I].Hint := Lang.ReadString('LANG',frmMain.tbrToolbar.Buttons[I].Name,'');
    pmmTyp.Caption     := Lang.ReadString('LANG',pmmTyp.Name,'');
    pmiWhile.Caption := tbtnWhile.Hint;
    pmiRepeat.Caption   := tbtnRepeat.Hint;
    pmiFor.Caption := tbtnFor.Hint;
    pmiCut.Caption     := mmiCut.Caption;
    pmiPaste.Caption   := mmiPaste.Caption;
    pmiCopy.Caption    := mmiCopy.Caption;
    pmiDelete.Caption  := mmiDelete.Caption;
  end;
  with frmMain.BlockLabels     {Laden der spezifischen Caption's der Strukturen}
  do begin                     {zB. Struktur For = Deutsch = 'zähle von'       }
    Clear;
    Add(Lang.ReadString('LANG','For',''));
    Add(Lang.ReadString('LANG','Repeat',''));
    Add(Lang.ReadString('LANG','While',''));
    Add(Lang.ReadString('LANG','True',''));
    Add(Lang.ReadString('LANG','False',''));
  end;
  Lang.Free;
end;

procedure TfrmOptions.cbLanguageChange(Sender: TObject);
begin
  SetLanguage(cbLanguage.Text); {Laden der gewählten Sprache                   }
  frmMain.ReplaceStruktCaptions;{Ersetzen der Struktur Caption's               }
end;

end.

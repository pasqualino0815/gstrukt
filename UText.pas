unit UText;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfrmText = class(TForm)
    btnText: TButton;
    memText: TMemo;
    btnCancel: TButton;
    edtText: TEdit;
    procedure FormShow(Sender: TObject);
    procedure memTextChange(Sender: TObject);
    procedure edtTextChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmText: TfrmText;

implementation

{$R *.dfm}


procedure TfrmText.FormShow(Sender: TObject);
{**************************************************
 * Focus des sichtbaren Eingabefeldes setzen      *
 **************************************************}
begin
  if(memText.Visible)                            {Formulargrössten anpassen    }
  then begin
    memText.SetFocus;
    memText.SelectAll;
    btnText.Top  := 128;
    btnCancel.Top:= 128;
    frmText.Height := 185;
  end
  else begin
    edtText.SetFocus;
    edtText.SelectAll;
    btnText.Top  := 40;
    btnCancel.Top:= 40;
    frmText.Height := 92;
  end;
end;

procedure TfrmText.memTextChange(Sender: TObject);
{**************************************************
 * Verhindert das Einfügen der                    *
 * Zeichenfolge '%%%' (Zeilenumbruch)             *
 **************************************************}
var
  TMP : TCaption;
begin
  if(pos('%%%',memText.Text) <> 0)            {Existiert die Zeichenfolge '%%%'}
  then begin
    TMP := memText.Text;
    while(pos('%%%',TMP) <> 0)                {Lösche solange bis die Zeichen- }
    do delete(TMP,pos('%%%',TMP),3);          {folge '%%%' nicht mehr existiert}
    memText.Text := TMP;
    memText.SelStart := length(memText.Text); {Cursor zur letzten Position     }
  end;                                        {setzen da sie zurück auf 1 init.}
end;                                          {beim ersetzen von Objekt Text   }

procedure TfrmText.edtTextChange(Sender: TObject);
{**************************************************
 * Verhindert das Einfügen der                    *
 * Zeichenfolge '%%%' (Zeilenumbruch)             *
 **************************************************}
var
  TMP : TCaption;
begin
  if(pos('%%%',edtText.Text) <> 0)            {Existiert die Zeichenfolge '%%%'}
  then begin
    TMP := edtText.Text;
    while(pos('%%%',TMP) <> 0)                {Lösche solange bis die Zeichen- }
    do delete(TMP,pos('%%%',TMP),3);          {folge '%%%' nicht mehr existiert}
    edtText.Text := TMP;
    edtText.SelStart := length(edtText.Text); {Cursor zur letzten Position     }
  end;                                        {setzen da sie zurück auf 1 init.}
end;                                          {beim ersetzen von Objekt Text   }

end.

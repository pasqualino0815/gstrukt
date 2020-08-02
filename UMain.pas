{**********************************************************
 *                                                        *
 * Datum    : 02.02.2006                                  *
 * Programm : Struktogramm Editor                         *
 * Version  : 0.01 Beta                                   *
 * Autor    : Gengoux Pascal                              *
 * Kommentar: Programm zum Erstellen von Struktogrammen   *
 * Formular : Hauptformular                               *
 *                                                        *
 **********************************************************}
unit UMain;
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,  Menus, ImgList, ActnList, Clipbrd, Printers,
  Inifiles, ExtCtrls, ToolWin, ComCtrls, UClasses;

type
  TTabWidth = array[0..100] of integer;
  TfrmMain = class(TForm)
    tbtnCopy              : TToolButton;
    tbtnPaste             : TToolButton;
    tbtnCut               : TToolButton;
    tbtnDelete            : TToolButton;
    tbtnText              : TToolButton;
    tbtnSequenz           : TToolButton;
    tbtnWhile             : TToolButton;
    tbtnRepeat            : TToolButton;
    tbtnSelect            : TToolButton;
    tbtnFor               : TToolButton;
    tbtnIf                : TToolButton;
    tbtnSeperator         : TToolButton;
    dlgOpen               : TOpenDialog;
    dlgSave               : TSaveDialog;
    aclShortCuts          : TActionList;
    scbMainBox            : TScrollBox;
    pmRightClick          : TPopupMenu;
    imgListIcons          : TImageList;
    mnuMain               : TMainMenu;
    mmFile                : TMenuItem;
    mmiNew                : TMenuItem;
    mmiOpen               : TMenuItem;
    mmiSave               : TMenuItem;
    mmiSaveAs             : TMenuItem;
    mmiSeperator          : TMenuItem;
    mmiQuit               : TMenuItem;
    mmEdit                : TMenuItem;
    mmiDelete             : TMenuItem;
    mmiCopy               : TMenuItem;
    mmiCut                : TMenuItem;
    mmiPaste              : TMenuItem;
    pmmTyp                : TMenuItem;
    pmiFor: TMenuItem;
    pmiWhile: TMenuItem;
    pmiRepeat: TMenuItem;
    pmiCopy               : TMenuItem;
    pmiPaste              : TMenuItem;
    pmiCut                : TMenuItem;
    pmiDelete             : TMenuItem;
    pmiText               : TMenuItem;
    pmiSeperator          : TMenuItem;
    mmExtras              : TMenuItem;
    mmiSeperator1         : TMenuItem;
    mmiOptions            : TMenuItem;
    mmiPrint              : TMenuItem;
    mmiExport             : TMenuItem;
    mmiAbout              : TMenuItem;
    mmiUndo               : TMenuItem;
    tbrToolbar            : TToolBar;
    acSelect              : TAction;
    acText                : TAction;
    acSeq                 : TAction;
    acWhile               : TAction;
    acFor                 : TAction;
    acRepeat              : TAction;
    acIF                  : TAction;
    pbxStrukt             : TPaintBox;

    procedure mmiDeleteClick   (Sender: TObject);
    procedure mmiCopyClick     (Sender: TObject);
    procedure mmiPasteClick    (Sender: TObject);
    procedure mmiNewClick      (Sender: TObject);
    procedure mmiOpenClick     (Sender: TObject);
    procedure mmiSaveAsClick   (Sender: TObject);
    procedure mmiSaveClick     (Sender: TObject);
    procedure mmiExportClick   (Sender: TObject);
    procedure mmiOptionsClick  (Sender: TObject);
    procedure mmiQuitClick     (Sender: TObject);
    procedure mmiUndoClick     (Sender: TObject);
    procedure mmiAboutClick    (Sender: TObject);
    procedure mmiPrintClick    (Sender: TObject);
    procedure mmiCutClick      (Sender: TObject);
    procedure tbtnSelectClick  (Sender: TObject);
    procedure pmiForClick  (Sender: TObject);
    procedure pmiWhileClick  (Sender: TObject);
    procedure pmiRepeatClick    (Sender: TObject);
    procedure pmiTextClick     (Sender: TObject);
    procedure pmRightClickPopup    (Sender: TObject);
    procedure FormCreate       (Sender: TObject);
    procedure FormDestroy      (Sender: TObject);
    procedure FormCloseQuery   (Sender: TObject; var CanClose: Boolean);
    procedure FormMouseWheel   (Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure pbxStruktMouseUp  (Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure mmFileMeasureItem(Sender: TObject; ACanvas: TCanvas;
      var Width, Height: Integer);
    procedure pbxStruktMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure pbxStruktPaint(Sender: TObject);
  private
    { Private declarations }
    MaxW   : array[0..100]of integer;
    INDEX    : integer;
    MODE     : integer;
    TX, TY   : integer;
    MyFile   : string;
    NewFile  : boolean;
    MODI     : boolean;
    DragIndex: integer;
    Undo     : TUndo;
    Temp     : TStringList;
    slCopy, slStrukt       : TStringList;
    ilX1, ilX2, ilY1, ilY2 : TIntList;
    {*********************************************
     * Diverse Funktionen und Prozeduren         *
     *********************************************}
    function  Confirm              (S:string)       :TModalResult;
    function  CanDelete            (INDEX : integer):boolean;
    function  GetNearest           (X,Y   : integer):integer;
    function  CompareNum           (S1, S2 : string):boolean;
    function  MaxHeight                             :integer;
    procedure ShowFileNameInTitle  (S:string);
    procedure ButtonsEnabled;
    procedure CalcAndDraw;
    {*********************************************
     * String Funktionen                         *
     *********************************************}
    function GetTyp  (S : string):char;
    function GetTxt  (S : string):string;
    function GetNum  (S : string):string;
    function GetEMP  (S : string):char;
    function SetTyp  (S : string; Typ   : Char  ):string;
    function SetTxt  (S : string; Txt   : string):string;
    function SetNum  (S : string; P     : string):string;
    function SetEMP  (S : string; P     : char  ):string;
    {*********************************************
     * Grössen Funktioen                         *
     *********************************************}
    function CountLines (S : string):integer;
    function SWidth     (S : string):integer;
    function SHeight    (S : string):integer;
    function IFH        (DEBUT:integer; var NewI : integer) : integer;
    {*********************************************
     * Zeichen Prozeduren                        *
     *********************************************}
    procedure DrawSeq     (X1,Y1,X2,Y2 :integer ;  Txt:string;Canvas : TCanvas);
    procedure DrawFor     (X1,Y1,X2,Y2 :integer ;  Txt:string;Canvas : TCanvas);
    procedure DrawWhile   (X1,Y1,X2,Y2 :integer ;  Txt:string;Canvas : TCanvas);
    procedure DrawRepeat  (X1,Y1,X2,Y2 :integer ;  Txt:string;Canvas : TCanvas);
    procedure DrawIF      (X1,Y1,X2,Y2,MX :integer;Txt:string;Canvas : TCanvas);
    procedure Draw        (Canvas : TCanvas);
    procedure DrawAffect  (X,Y:integer;Canvas:TCanvas);
    {*********************************************
     * Berechnungs Prozeduren                    *
     *********************************************}
    function  GetStruktSize(I : integer):integer;
    procedure Calculate;
    procedure CalculateIF(DEBUT,pOFX,pOFY:integer;CanAjust:boolean;var NewI,IFWidth,IFHeight:integer);
    procedure SetMaxWidth(DEBUT,Max,Count : integer;var NewIndex : integer);
  public
    { Public declarations }
    BlockLabels    : TStringList;
    MF             : TMetaFile;
    OFSETX, OFSETY : integer;
    procedure ReplaceStruktCaptions;
  end;

var
  frmMain: TfrmMain;

implementation

uses UText, UOptions, UPrint, UAbout;

{$R *.dfm}

function TfrmMain.MaxHeight : integer;
{*************************************************
 * Funktion zum ermitteln der maximalen Höhe     *
 * welche sich in der IntegerListe ilY2 befindet *
 *************************************************}
var
  I, MAX, Y2 : integer;
begin
  MAX := 0;
  for I := 0 to ilY2.Count - 1
  do begin
    Y2 := ilY2[I];
    if(Y2 > MAX)then MAX := Y2;
  end;
  Result := MAX;
end;

procedure TfrmMain.ShowFileNameInTitle(S:string);
{************************************************
 * Zeigt den Namen des aktuellen Struktogramms  *
 * in der Titelleiste an                        *
 ************************************************}
begin
  frmMain.Caption := 'GStrukt [ '+ExtractFileName(S)+' ]';
  Application.Title := 'GStrukt [ '+ExtractFileName(S)+' ]';
end;

function TfrmMain.Confirm(S:string):TModalResult;
begin
  Result := MessageDlg(S, mtWarning, [mbYes,mbNo,mbCancel], 0);
end;

function TfrmMain.CanDelete(INDEX:integer):boolean;
{************************************************
 * Ermittelt op eine 'Sequence' gelöscht werden *
 * darf                                         *
 ************************************************}
var
  TI,TP,TM, SI, SM, SP, INIT, JT : string;
  NOEMP2, K : integer;
  Check : boolean;
begin
  Result := True;
  TI := slStrukt[INDEX];
  TM := slStrukt[INDEX-1];
  SI := GetNum(TI);
  SM := GetNum(TM);
  if(INDEX < slStrukt.Count - 1)
  then begin
    TP := slStrukt[INDEX+1];
    SP := GetNum(TP);
  end
  else begin
    TP := '';
    SP := '';
  end;
  if((GetEMP(TI) = '1') or (GetEMP(TI) = '2'))
  then begin
    if(GetEMP(TI) = '1')
    then begin
      if(GetTyp(TM) = 'I')and(GetEMP(TP) = '2')
      then Result := False;
    end
    else begin
      Check := True;
      K := INDEX;
      JT := slStrukt[K];
      While(K < slStrukt.Count - 1)
        and(length(GetNum(slStrukt[K])) >= length(GetNum(INIT)))
      do inc(K);
      NOEMP2 := 0;
      INIT := JT;
      While(CHECK)
      do begin
        if(length(GetNum(INIT))=length(GetNum(JT))) and(GetEMP(JT) = '2')
        then inc(NOEMP2);
        CHECK := not((GetTyp(JT) = 'I') and (length(GetNum(JT)) = length(GetNum(INIT))-1));
        dec(K);
        JT := slStrukt[K];
      end;
      if(NOEMP2 <= 1)then Result := False;
    end;
  end
  else begin
    if(GetTyp(TM) in ['W','R','F'])
    then begin
      Delete(SI,length(SI),1);
      Delete(SP,length(SP),1);
      if(SP = SI)
      then begin
        Result := True;
      end
      else Result := False;
    end;
  end;
end;

{----------------------------------------------------
                String Funktionen
       <ID> ; <Platz(1,2)> ; <Typ> ; <Text>
    Bemerkungen:
    ID: Alphabetische Nummerierung (zB. a, aa, b, ba)
    Platz: 1=True Teil IF /// 2 = False Teil IF
    Typ: Q = Linerarer Ablauf
         W = Kopfgesteuerte Schleife
         R = Fussgesteuerte Schleife
         F = Zählschleife
         I = Verzweigung (IF)
    Text: Zeilenumbruch = Zeichenfolge '%%%'
{----------------------------------------------------}

function TfrmMain.GetTyp(S : string):char;
{************************************************
 * Ermittelt den Typ einer Struktur             *
 ************************************************}
begin
  Delete(S,1,pos(';',S));
  Delete(S,1,pos(';',S));
  Result := S[1];
end;

function TfrmMain.GetEMP(S : string):char;
{************************************************
 * Ermittelt den Platz einer Struktur           *
 ************************************************}
begin
  Delete(S,1,pos(';',S));
  If(S[1] = ';')then Result := ' '
  else Result := S[1];
end;

function TfrmMain.GetTxt(S : string):string;
{************************************************
 * Ermittelt den Text einer Struktur            *
 ************************************************}
begin
  Delete(S,1,pos(';',S));
  Delete(S,1,2);
  Delete(S,1,pos(';',S));
  Result := Copy(S,1,length(S));
end;

function TfrmMain.GetNum(S : string):string;
{************************************************
 * Ermittelt die Numerierung einer Struktur     *
 ************************************************}
begin
  Result := Copy(S,1,pos(';',S)-1);
end;

function TfrmMain.CountLines(S : string):integer;
{**************************************************
 * Zählt die Anzahl der Zeilen                    *
 * im Text von einer Struktur                     *
 **************************************************}
begin
  Result := 0;
  repeat
    inc(Result);
    delete(S,1,pos('%%%',S)+2);
  until(pos('%%%',S) = 0);
end;

function TfrmMain.SetTyp(S : string; Typ : Char):string;
{*********************************
 * Setzt den Typ einer Struktur  *
 *********************************}
var I, SEMI : integer;
begin
  I := 1;
  SEMI := 0;
  repeat
    if(S[I] = ';')then inc(SEMI);
    inc(I);
  until(SEMI = 2);
  S[I] := Typ;
  Result := S;
end;

function TfrmMain.SetTxt(S : string; Txt : string):string;
{*********************************
 * Setzt den Text einer Struktur *
 *********************************}
var I, SEMI : integer;
begin
  I := 1;
  SEMI := 0;
  repeat
    if(S[I] = ';')then inc(SEMI);
    inc(I);
  until(SEMI = 3);
  delete(S,I,length(S));
  insert(Txt,S,I+1);
  Result := S;
end;

function TfrmMain.SetNum(S : string; P : string):string;
{****************************************
 * Setzt die Numerierung einer Struktur *
 ****************************************}
begin
  Delete(S,1,pos(';',S)-1);
  Insert(P,S,1);
  Result := S;
end;

function TfrmMain.SetEMP(S:string;P:char):string;
{****************************************
 * Setzt den Platz einer Struktur       *
 ****************************************}
var I, SEMI : integer;
begin
  I := 1;
  SEMI := 0;
  repeat
    if(S[I] = ';')then inc(SEMI);
    inc(I);
  until(SEMI = 1);
  if(S[I] <> ';')then delete(S,I,1);
  insert(P,S,I);
  Result := S;
end;

function TfrmMain.CompareNum(S1, S2 : string):boolean;
{************************************************
 * Ermittelt op Numerierung von S1 mit S2       *
 * übereinstimmt                                *
 ************************************************}
var
  I : integer;
  SAME : boolean;
begin
  SAME := True;
  I := 1;
  While(SAME)and(I <= length(S1))and(I <= length(S2))
  do begin
    if(S1[I] <> S2[I])then SAME := False;
    inc(I);
  end;
  Result := SAME;
end;

function TfrmMain.SHeight(S : string):integer;
{************************************************
 * Ermittelt die Höhe des Textes einer Struktur *
 * die der Text auf dem Bild imgImage einnimmt  *
 ************************************************}
var
  HeightOneLine, Lines : integer;
  TXT : String;
begin
  TXT := GetTxt(S);
  Lines := CountLines(TXT);
  HeightOneLine := pbxStrukt.Canvas.TextHeight('A');
  Result := Lines * HeightOneLine + Lines * 2;
end;

function TfrmMain.SWidth(S : string):integer;
{**************************************************
 * Ermittelt die Breite des Textes einer Struktur *
 * die der Text auf dem Bild pbxStrukt einnimmt    *
 **************************************************}
var
  MaxWidth, Width, I, PlatzTrennZeichen : integer;
  TextLine : string;
begin
  MaxWidth := 0;
  I := 1;
  PlatzTrennZeichen := 0;
  if(GetNum(S) = 'a')
  then pbxStrukt.Canvas.Font.Style := [fsBold];
  repeat
    if(S[I] = ';')then inc(PlatzTrennZeichen);
    inc(I);
  until(PlatzTrennZeichen = 3);
  delete(S,1,I-1);
  repeat                                  {Maximale Breite ermitteln           }
    TextLine := copy(S,1,pos('%%%',S)-1);
    delete(S,1,pos('%%%',S)+2);
    Width := pbxStrukt.Canvas.TextWidth(TextLine);
    if(MaxWidth < Width)then MaxWidth := Width;
  until(pos('%%%',S) = 0);
  Result := MaxWidth + 20;                 {20 = 2x10 Abstandshalter von den   }
                                           {Rändern                            }
  pbxStrukt.Canvas.Font.Style := [];
  if(Result < 100)then Result := 100;      {Minimale Grösse                    }
end;


function TfrmMain.IFH(DEBUT:integer; var NewI : integer) : integer;
{**************************************************************************
 * Ermittelt die Höhe einer Verzweigung beginnent mit dem Index DEBUT     *
 * und gibt einen Neuen Index aus (NeuerIndex = berechnete Strukturen + 1 *
 **************************************************************************}
var
  HeightTrue, HeightFalse, I, SCount  : integer;
  StruktI, NumI, NumJ : string;
  SameIF, InTrue : boolean;
{****************************************************************
 * HeightTrue  = Höhe vom True  Teil                            *
 * HeightFalse = Höhe vom False Teil                            *
 * StruktI     = Strukturen[I]                                  *
 * NumI, NumJ  = GetNum(Strukturen[I(bzw. J)])                  *
 * SameIF      = Aktuelle Struktur noch im Anfangs IF enthalten *
 * InTrue      = I befindet sich im True Teil des IF's ?        *
 * SCount      = Anzahl der Strukturen - 1                      *
 ****************************************************************}
begin
  I       := DEBUT+1;
  SCount  := slStrukt.Count-1;
  InTrue  := True;
  StruktI := slStrukt[DEBUT+1];
  SameIF  := True;
  NumI    := GetNum(slStrukt[DEBUT]);
  HeightTrue  := 0;
  HeightFalse := 0;
  while(I <= SCount)and(SameIF)
  do begin
    StruktI := slStrukt[I];
    if(GetEMP(StruktI) = '2')then InTrue := false;
    if(InTrue)
    then begin
      Case GetTyp(StruktI)of
        'W','R': inc(HeightTrue,40);               {Kopf = 40 px               }
        'F'    : inc(HeightTrue,60);               {Kopf = 40 px, Fuss = 20px  }
        'Q'    : inc(HeightTrue,SHeight(StruktI)+20);{Inhalt = Lines + Abstände}
                                                   {Abstand Oben + Unten = 20px}
        'I'    : inc(HeightTrue,IFH(I,I));         {Grösse von IF              }
      end;
    end
    else begin
      Case GetTyp(StruktI)of                       {Siehe HeightTrue           }
        'W','R' : inc(HeightFalse,40);
        'F'     : inc(HeightFalse,60);
        'Q'     : inc(HeightFalse,SHeight(StruktI)+20);
        'I'     : inc(HeightFalse,IFH(I,I));
      end;
    end;
    inc(I);
    if(I <= SCount)
    then begin
      NumJ    := GetNum(slStrukt[I]);
      SameIF  := CompareNum(NumI,NumJ);             {Noch immer im selben IF ? }
    end else SameIF := False;                       {Bzw. keine Struktur mehr  }
  end;
  if(HeightTrue > HeightFalse)
  then Result := HeightTrue  + 40                   {40 = Höhe des IF-Kopfes   }
  else Result := HeightFalse + 40;
  NewI := I - 1;
  //ShowMessage(inttostr(result));
end;

procedure TfrmMain.SetMaxWidth(DEBUT,Max,Count:integer;var NewIndex : integer);
{******************************************
 * Anpassen der Strukturen des IF's im IF *
 ******************************************}
var
  IT, SI, SJ : string;
  SAMEIF, Cond1 : boolean;
  I, SCount  : integer;
begin
  I := DEBUT+1;
  SCount := slStrukt.Count-1;
  Cond1 := True;
  IT     := slStrukt[DEBUT+1];
  SAMEIF := True;
  SI := GetNum(slStrukt[DEBUT]);
  while(I <= SCount)and(SAMEIF)
  do begin
    IT := slStrukt[I];
    if(GetEMP(IT) = '2')then Cond1 := false;
    if(Cond1 = False)
    then begin
      if(GetTyp(IT) = 'I')//and(GetEmp(IT) = '2')
      then begin
        ilX2[I] := Max;
        SetMaxWidth(I,ilX2[I],0,I);          {Rekursiver Aufruf bei weiterem IF}
      end
      else ilX2[I] := Max;
    end;
    if(GetTyp(IT) = 'I')
    then SAMEIF := False;
    inc(I);
    if(I <= SCount)and(SAMEIF)
    then begin
      SJ := GetNum(slStrukt[I]);              {Noch im selben IF?}
      SAMEIF := CompareNum(SI,SJ);
    end;
  end;
  NewIndex := I - 1;
end;

function TfrmMain.GetStruktSize(I : integer):integer;
var
  IT, JT : string;
  J, LI, LJ, Size, SCount :integer;
begin
  Size  := 0;
  SCount:= slStrukt.Count - 1;
  J     := I + 1;
  JT    := slStrukt[J];
  IT    := slStrukt[I];
  LI    := length(GetNum(IT));
  LJ    := length(GetNum(JT));
  While(J <= SCount)and(LJ > LI)
  do begin
    JT := slStrukt[J];
    LJ := length(GetNum(JT));
    if(LJ > LI)
    then begin
      Case GetTyp(JT)of
        'Q'     : inc(Size,SHeight(JT)+20);
        'W','R' : inc(Size,40);
        'F'     : inc(Size,60);
        'I'     : inc(Size,IFH(J,J));
      end;
    end;
    inc(J);
  end;
  if(GetTyp(IT)='F')then inc(Size,20);
  Result := Size;
end;

{----------------------------------------------------}
{               Zeichen Prozeduren                   }
{----------------------------------------------------}

procedure TfrmMain.Draw(Canvas : TCanvas);
{*************************************************
 * Prozedur zeichnet Struktogramm auf den Para.  *
 * Canvas, Benutzt: Clipboard(WMF) und pbxStrukt *
 *************************************************}
var
  X1,Y1,X2,Y2, I, MX, MAXX, MAXY : integer;
  StruktI, NumSelected           : string;
  InStruktSelected               : boolean;
begin
  Canvas.Brush.Color := clWhite;             {Canvas 'clearen' (weiss)         }
  Canvas.FillRect(pbxStrukt.ClientRect);     {Grösse der Struktogrammseite     }
  Canvas.Font      := pbxStrukt.Font;        {Gewählte Schriftart übernehmen   }
  InStruktSelected := False;
  for I := 0 to slStrukt.Count-1
  do begin
    if(Canvas is TMetaFileCanvas)            {Koordinaten zwischenlagern       }
    then begin                               {--> Einfache Handhabung          }
      X1 := ilX1[I]-OFSETX;                  {Für MetaFile Kein Offset!        }
      Y1 := ilY1[I]-OFSETY;
      X2 := ilX2[I]-OFSETX;
      Y2 := ilY2[I]-OFSETY;
    end
    else begin
      X1 := ilX1[I];
      Y1 := ilY1[I];
      X2 := ilX2[I];
      Y2 := ilY2[I];
    end;
    StruktI := slStrukt[I];
    if(InStruktSelected)
    then begin
      InStruktSelected := CompareNum(NumSelected,GetNum(StruktI));
    end;
    with Canvas.Brush do
    begin
      if(I = INDEX)or(InStruktSelected)      {Angewählte Struktur              }
      then begin
        if(GetTyp(StruktI) <> 'Q')and(I = INDEX)
        then begin                           {lin. Ablauf keine weiteren Strukt}
          InStruktSelected:= True;           {andere Strukturen können mehrere }
          NumSelected     := GetNum(StruktI);{Strukturen beinhalten --> Gelb!  }
        end;
        if(I = INDEX)or(InStruktSelected)    {Diese Struktur gelb ausmahlen !  }
        then begin
          Style := bsSolid;
          Color := clYellow;
        end;
      end
      else begin                             {Nicht ausgewählte Strukturen     }
        Style := bsClear;                    {normal(weiss) darstellen         }
        Color := clWhite;
      end;
    end;
    if(I = 0)                                {Überschrift Fett + Blau          }
    then begin
      Canvas.Font.Color := clBlue;
      Canvas.Font.Style := [fsBold]
    end
    else begin
      Canvas.Font.Color := clBlack;
      Canvas.Font.Style := [];
    end;
    Case GetTyp(StruktI) of                 {Versch. Strukturen zeichnen       }
      'Q' : DrawSeq   (X1,Y1,X2,Y2,GetTxt(StruktI),Canvas);
      'F' : DrawFor   (X1,Y1,X2,Y2,GetTxt(StruktI),Canvas);
      'R' : DrawRepeat(X1,Y1,X2,Y2,GetTxt(StruktI),Canvas);
      'W' : DrawWhile (X1,Y1,X2,Y2,GetTxt(StruktI),Canvas);
      'I' :
      begin
        if(Canvas is TMetaFileCanvas)      {MX = .....   Übergang True-False im}
        then MX := ilX2[I+1]-OFSETX        {   -> '.' <- Kopf                  }
        else MX := ilX2[I+1];
        DrawIF(X1,Y1,X2,Y2,MX,GetTxt(StruktI),Canvas);
      end;
    end;
  end;
  MAXY := 0;                               {Bestimmen von den Max von X und Y  }
  MAXX := 0;                               {Zum Zeichnen des Rahmen            }
  for I := 0 to slStrukt.Count - 1
  do begin
    if(ilY2[I] > MAXY)then MAXY := ilY2[I];
    if(ilX2[I] > MAXX)then MAXX := ilX2[I];
  end;
  with Canvas
  do begin
    Brush.Style := bsClear;
    Pen.Width := 3;
    if(Canvas is TMetaFileCanvas)
    then Rectangle(0,0,MAXX-OFSETX-1,MAXY-OFSETY-1)
    else Rectangle(OFSETX,OFSETY,MAXX,MAXY+1);
    Pen.Width := 1;
    Brush.Style := bsSolid;
  end;
end;

procedure TfrmMain.DrawSeq(X1,Y1,X2,Y2:integer;Txt:string;Canvas : TCanvas);
{******************************************
 * Zeichnen eines Linearen Ablaufs        *
 ******************************************}
var
  T,TMP : string;
  Y : integer;
  V : integer;
  AffectX, NbrVide : integer;
begin
  V := Canvas.TextHeight('A') + 2;
  Y := Y1 + 10;
  NbrVide := 0;
  with Canvas
  do begin
    TMP := Txt;
    repeat
      T := copy(Txt,1,pos('%%%',Txt)-1);
      delete(Txt,1,pos('%%%',Txt)+2);
      if(T = '')then inc(NbrVide);
    until(pos('%%%',Txt) = 0);
    if(T = '')and(NbrVide > 1)
    then Rectangle(X1,Y1,X2,Y2+2)
    else Rectangle(X1,Y1,X2,Y2);
    Txt := TMP;
    repeat
      T := copy(Txt,1,pos('%%%',Txt)-1);
      delete(Txt,1,pos('%%%',Txt)+2);
      TextOut(X1+10,Y,T);
      if(pos('<-',T)<>0)
      then begin
        AffectX :=X1+10+TextWidth(Copy(T,1,pos('<-',T)-1));
        DrawAffect(AffectX,Y,Canvas);
      end;
      Y := Y + V;
    until(pos('%%%',Txt) = 0);
  end;
end;

procedure TfrmMain.DrawFor(X1,Y1,X2,Y2:integer;Txt:string;Canvas : TCanvas);
{*******************************
 * Zeichnen einer Zählschleife *
 *******************************}
var
  Y, AffectX, PosAffect : integer;
begin
  with Canvas
  do begin
    Rectangle(X1,Y1,X2,Y2);                     {Rahmen                        }
    Rectangle(X1+20,Y1+40,X2,Y2-20);            {Innerer Rahmen                }
    delete(txt,pos('%%%',txt),3);               {Zeilenumbruch im Text löschen }
    Y := Y1+(40-TextHeight(Txt)) div 2 + 1;     {Y des Textes Berechnen        }
    TextOut(X1+10,Y,Txt);                       {Ausgabe des Textes            }
    PosAffect := pos('<-',Txt);                 {Position von evt. Zuweisung   }
    if(PosAffect<>0)                            {Ersetzen von '<-' durch       }
    then begin                                  {gezeichneter Pfeil            }
      AffectX :=X1+10+TextWidth(Copy(Txt,1,PosAffect-1));
      DrawAffect(AffectX,Y,Canvas);
    end;
  end;
end;

procedure TfrmMain.DrawAffect(X,Y:integer;Canvas:TCanvas);
var
  Height, Width : integer;
begin
  with Canvas
  do begin
    Height := TextHeight('A');                      {Höhe des Pfeils           }
    Width := TextWidth('<-');                       {Länge des Pfeils          }
    FillRect(Rect(X,Y,X+Width,Y+Height));           {'<-' übermalen            }
    Pen.Color := Font.Color;
    MoveTo(X+2,Y+Height div 2);                     {Zeichnen des Pfeils       }
    LineTo(X-2+Width,Y+Height div 2 );
    MoveTo(X+2,Y+Height div 2);
    LineTo(X+2+5,Y+Height div 2 + 5);
    MoveTo(X+2,Y+Height div 2);
    LineTo(X+2+5,Y+Height div 2 - 5);
    Pen.Color := clBlack;
  end;
end;

procedure TfrmMain.DrawWhile(X1,Y1,X2,Y2:integer;Txt:string;Canvas : TCanvas);
{********************************************
 * Zeichnen einer Kopfgesteurerten Schleife *
 ********************************************}
var Y : integer;
begin
  with Canvas
  do begin
    Rectangle(X1,Y1,X2,Y2);
    Rectangle(X1+20,Y1+40,X2,Y2);
    delete(txt,pos('%%%',txt),3);
    Y := Y1+(40-SHeight(Txt)) div 2 + 1;
    TextOut(X1+10,Y,Txt);
  end;
end;

procedure TfrmMain.DrawRepeat(X1,Y1,X2,Y2:integer;Txt:string;Canvas : TCanvas);
{********************************************
 * Zeichnen einer fussgesteurerten Schleife *
 ********************************************}
var Y : integer;
begin
  with Canvas
  do begin
    Rectangle(X1,Y1,X2,Y2);
    Rectangle(X1+20,Y1,X2,Y2-40);
    delete(txt,pos('%%%',txt),3);
    Y := Y2-40+(40-SHeight(Txt)) div 2 + 1;
    TextOut(X1+10,Y,Txt);
  end;
end;

procedure TfrmMain.DrawIF(X1,Y1,X2,Y2,MX:integer;Txt:string;Canvas : TCanvas);
{******************************
 * Zeichnen einer Verzweigung *
 ******************************}
var
  X, XP1, XP2 : integer;
  YA : integer;
  OldF : integer;
  Width : integer;
begin
  with Canvas
  do begin
    OldF := Font.Size;
    Font.Size := 10;
    YA := Y1 + 2;
    XP1 := X1 + (MX - X1)div 2;
    XP2 := MX + (X2 - MX)div 2;
    delete(txt,pos('%%%',txt),3);
    Width := TextWidth(txt);
    X := XP1 + (XP2 - XP1 - Width)div 2;
    Rectangle(X1,Y1,X2,Y2+1);
    MoveTo(X1,Y1+1);
    LineTo(MX-1,Y1+39);
    LineTo(X2,Y1+1);
    MoveTo(X1,Y1+40);
    LineTo(X2,Y1+40);
    MoveTo(MX-1,Y1+40);
    LineTo(MX-1,Y2);
    TextOut(X1+4,Y1+40-(TextHeight(BlockLabels[3])),BlockLabels[3]);
    TextOut(X2-(Canvas.TextWidth(BlockLabels[4]))-4,Y1+40-TextHeight(BlockLabels[4]),BlockLabels[4]);
    TextOut(X,YA,Txt);
    Canvas.Font.Size := OldF;
  end;
end;

{----------------------------------------------------}
{              Berechnungs Prozeduren                }
{----------------------------------------------------}

procedure TfrmMain.CalcAndDraw;
var I  : integer;
    txt,tmp: string;
begin
  Calculate;
  Draw(pbxStrukt.Canvas);
  for I := 0 to slStrukt.Count - 1
  do begin
    txt := GetTxt(slStrukt[I]);
    tmp := '%%%';
     While(length(txt) > 2)and(tmp = '%%%')
     do begin
       tmp := copy(txt,length(txt)-2,3);
       if(tmp = '%%%')then delete(txt,length(txt)-2,3);
     end;
     txt := txt + '%%%';
     slStrukt[I] := SetTxt(slStrukt[I],txt);
  end;
end;

procedure TfrmMain.Calculate;
var
  I, J, MAX            : integer;
  OFX, OFY, SIZE, SUP  : integer;
  SCount               : integer;
  StruktI, StruktJ, NumI, NumJ : string;
  SAME, CanAddCoords   : boolean;
  //IF Parameter
  Height, Width, NI    : integer;
begin
  SCount := slStrukt.Count - 1;
  // Init vum Tableau fier dei Maximal Breed, fier dei anner unzepassen
  for I := 0 to SCount do MaxW[I] := -1;
  I      := 0;
  OFY    := OFSETY;
  ilX1.Clear;
  ilX2.Clear;
  ilY1.Clear;
  ilY2.Clear;
  while(I <= SCount)
  do begin
    CanAddCoords := True;
    StruktI    := slStrukt[I];
    SIZE := 0;
    OFX := OFSETX + (length(GetNum(StruktI))-1) * 20;
    J   := 0;
    SUP := 0;
    StruktJ := slStrukt[J];
    NumI  := GetNum(StruktI);
    While(J < I)
    do begin
      StruktJ := slStrukt[J];
      NumJ  := GetNum(StruktJ);
      SAME := CompareNum(NumI,NumJ);
      Case GetTyp(StruktJ) of
        'F' : if(not(SAME))then inc(SUP,20);
        'R' : if(not(SAME))then inc(SUP,40);
        'I' : IFH(J,J);
      end;
      inc(J);
    end;
    case GetTyp(StruktI)of
      'W',
      'R',
      'F': inc(SIZE,GetStruktSize(I));
      'I':
      begin
        CalculateIF(I,OFX,OFY+SUP-1,True,NI,Width,Height);
        inc(OFY,Height);
        I := NI;
        CanAddCoords := False;
      end;
    end;
    if(CanAddCoords)
    then begin
      MaxW[I] := OFX + SWidth(StruktI);
      ilX1.Add( OFX                                       );
      ilY1.Add( OFY + SUP -1                              );
      ilX2.Add( OFX + SWidth (StruktI)                    );
      ilY2.Add( OFY + SHeight(StruktI) + 20 + SIZE + SUP  );
      case GetTyp(StruktI) of
        'W' : inc(OFY,40);
        'F' : inc(OFY,40);
        'Q' : inc(OFY,SHeight(StruktI) + 20);
      end;
    end;
    inc(I);
  end;
  MAX := 0;
  for I := 0 to SCount
  do if(MAXW[I] > MAX)then MAX := MaxW[I];
  for I := 0 to SCount
  do if(MAXW[I] > - 1)then ilX2[I] := MAX;
end;

procedure TfrmMain.CalculateIF(DEBUT,pOFX,pOFY:integer;CanAjust:boolean;var NewI,IFWidth,IFHeight:integer);
var
  I, J, K, S              : integer;
  {* Zählvariablen *}
  OFX, OFY, GRAND, SUP : integer;
  {*******************************************
   * OFX  : Laufender OffsetX
   * OFY  : Laufender OffsetY
   * GRAND: Grösse eines Blocks(W,F,R)
   * SUP  : Zusatz durch vorherige Blöcke(W,R)
   *******************************************}
  SCount, LI, LJ : integer;
  {*******************************************
   * SCount: Anzahl der Blöcke
   * LI,LJ : Länge von S des Blocks(I bzw. J)
   *******************************************}
  IT, JT, SI, SJ, SIBegin : string;
  {*******************************************
   * IT,JT : Block[I bzw. J]
   * SI,SJ : S des Blocks[I bzw.J]
   *******************************************}
  SAME, SAMEIF, CanAddCoords, EMP1, Ajust, InIf : boolean;
  {*******************************************
   * SAME : Ob Block nicht zum Block gehört des aktuellen I
   * SAMEIF : Festellen op Block[I] noch zum IF gehört
   * CHECK : --------
   * EMP1  : EMP1 = True = TrueTeil // else FalseTeil
   * SI,SJ : S des Blocks(I bzw.J)
   *******************************************}
  MAX1, MAX2 : integer;
  {*******************************************
   * MAX1 : Maximale Grösse vom Trueteil
   * MAX2 : Maximale Grösse vom Trueteil
   *******************************************}
  EndCond1, NI : integer;
  {*******************************************
   * EndCond1 : INDEX an dem der Trueteil endet
   * NI : (NewI) um zu NIndex zu springen da
   *      dieser Teil schon berechnet wurde vom
   *      rekursiven Aufruf von CalcIF
   *******************************************}
  H1, H2, Width, Height         : integer;
  {*******************************************
   * H1,H2 : Höhe vom True- bzw. Falseteil
   * Width, Height : Grösse + Höhe vom IF
   *******************************************}
  DIF : integer;
  M                    : TTabWidth;
  MaxW2                : TTabWidth;
begin
  for I := 0 to slStrukt.Count -1
  do begin
    M[I]     := -1;
    MaxW2[I] := -1;
  end;
  JT := slStrukt[DEBUT+1];    //Erster Block dem AnfangsBlock(IF)
  OFX      := pOFX;                 //Aktueller X Offset vor IF
  OFY      := pOFY;                 //Aktueller Y Offset vor IF
  I        := DEBUT + 1;            //Erster Block vom aktuellen IF
  MAX1     := 0;                    //MAX1
  SCount   := slStrukt.Count - 1;
  EndCond1 := 0;
  H1       := 0;
  H2       := 0;
  ilX1.Add(OFX);
  ilY1.Add(OFY);
  ilX2.Add(100);      // Dummy-Definition
  ilY2.Add(OFY + 40); // Dummy-Definition
  OFY := pOFY + 41;             // OFY anpassen da IF 40pix hoch ist
  SAMEIF := True;
  CanAddCoords := true;
  EMP1 := true;
  IFWidth  := 0;
  IFHeight := 0;
  while(I <= SCount)and(SAMEIF)
  do begin
    IT    := slStrukt[I];
    GRAND := 0;
    if(GetEMP(IT)='2')and(EndCond1 = 0)and(I > DEBUT + 1)and(EMP1)
    then begin
      EndCond1 := I-1;
      MAX1      := 0;
      for K := DEBUT+1 to EndCond1
      do begin
        if(M[K] > MAX1)then MAX1 := M[K];
      end;
      for K := DEBUT + 1 to EndCond1
      do begin
        if(M[K] > -1)
        then begin
          ilX2[K] := MAX1;
          if(GetTyp(slStrukt[K]) = 'I')then SetMaxWidth(K,MAX1,0,J);
        end;
      end;
      IFWidth := MAX1;
      OFY := pOFY + 41;
      EMP1 := false;
      IFWidth := MAX1;
    end;
    if(EndCond1 = 0)
    then OFX := pOFX + (length(GetNum(IT))-1-length(GetNum(slStrukt[DEBUT]))) * 20
    else OFX := MAX1 + (length(GetNum(IT))-1-length(GetNum(slStrukt[DEBUT]))) * 20 - 1;
    if(EndCond1 = 0)
    then J := DEBUT+1
    else J := EndCond1+1;
    SUP := 0;
    JT := slStrukt[J];
    SI  := GetNum(IT);
    InIF := False;
    While(J < I)
    do begin
      JT := slStrukt[J];
      if(InIF)
      then begin
        SJ  := GetNum(JT);
        InIf := CompareNum(SIBegin,SJ);
      end;
      if(GetTyp(JT) = 'I')and(InIF = False)
      then begin
        InIF    := True;
        SIBegin := GetNum(slStrukt[J]);
      end;
      SJ  := GetNum(JT);
      K   := 1;
      While(K <= length(SIBegin))and(InIF)
      do begin
        if(SIBegin[K] <> SJ[K])then InIF := False;
        inc(K);
      end;
      SAME := CompareNum(SI,SJ);
      if(not(SAME))and(not InIF)
      then begin
        if(GetTyp(JT)='F')
        then inc(SUP,20)
        else if(GetTyp(JT)='R')then inc(SUP,40);
      end;
      inc(J);
    end;
    //Höhe des True, bzw. des False- Teils bestimmen
    if(EndCond1 = 0)
    then begin
      Case GetTyp(IT)of
        'Q'     : inc(H1,SHeight(IT)+20);
        'W','R' : inc(H1,40);
        'F'     : inc(H1,60);
      end;
    end
    else begin
      Case GetTyp(IT)of
        'Q'     : inc(H2,SHeight(IT)+20);
        'W','R' : inc(H2,40);
        'F'     : inc(H2,60);
      end;
    end;
    // Höhe des Blocks Bestimmen
    case GetTyp(IT)of
      'W','F','R':
      begin
        inc(GRAND,GetStruktSize(I));
      end;
      'I':
      begin
        Ajust := CanAjust and (Emp1 = False);  //Ob If am rechten Rand angepasst werden darf
        Width := 0; Height := 0;
        CalculateIF(I,OFX,OFY+SUP-1,Ajust,NI,Width,Height);
        if(EMP1)
        then M[I] := Width
        else if(Ajust)
             then MaxW[I]  := Width
             else MaxW2[I] := Width;
        I := NI ;
        if(EMP1)then inc(H1,Height) else inc(H2,Height);
        inc(OFY,Height);
        inc(IFHeight,Height);
        CanAddCoords := false;
      end;
    end;
    if(CanAddCoords)
    then begin
      IT := IT;
      if(EndCond1 > 0)and(CanAjust)
      then MaxW[I] := OFX + SWidth(IT)
      else if(EndCond1 > 0)and(CanAjust=False)
           then MaxW2[I] := OFX + SWidth(IT)
           else M[I] := OFX + SWidth(IT);
      ilX1.Add( OFX                                  );
      ilY1.Add( OFY + SUP - 1                        );
      ilX2.Add( OFX + SWidth (IT)                    );
      ilY2.Add( OFY + SHeight(IT) + 20 + GRAND + SUP );
      case GetTyp(IT) of
      'W' : inc(OFY,40);
      'F' : inc(OFY,40);
      'Q' : inc(OFY,SHeight(IT) + 20);
      end;
    end else CanAddCoords := True;
    inc(I);
    if(I <= SCount)
    then begin
      SI := GetNum(slStrukt[DEBUT]);
      SJ := GetNum(slStrukt[I]);
      SAMEIF := CompareNum(SI,SJ);
    end  
  end;
  MAX1 := 0;
  MAX2 := 0;
  I := I - 1;
  for K := EndCond1 to I
  do begin
   if(MaxW [K] > MAX1)then MAX1 := MaxW [K];
   if(MaxW2[K] > MAX2)then MAX2 := MaxW2[K];
  end;
  for K := EndCond1 to I
  do begin
    if(MaxW [K] > 0)
    then ilX2[K] := MAX1;
    if(MaxW2[K] > 0)
    then begin
      ilX2[K] := MAX2;
      if(GetTyp(slStrukt[K]) = 'I')then SetMaxWidth(K,MAX2,0,J);
    end;
  end;
  if(CanAjust)then MAXW[DEBUT] := MAX2;
  if(MAX1 > MAX2)then IFWidth := MAX1 else IFWidth :=MAX2;
  pbxStrukt.Font.Size := 8;
  MAX2 := pOFX + pbxStrukt.Canvas.TextWidth(GetTxt(slStrukt[DEBUT])) * 2 - 10;
  pbxStrukt.Font.Size := 12;
  if(IFWidth < MAX2)then IFWidth := MAX2;
  if(MAXW[DEBUT] < MAX2)and(CanAjust)
  then MAXW[DEBUT] := MAX2;
  if(H1 > H2)
  then begin
    IFHeight := H1+40;
    ilY2[DEBUT] := H1+ilY2[DEBUT];
    J := I;
    if(J > SCount)then J := SCount;
    While(GetTyp(slStrukt[J]) <> 'Q')
    do dec(J);
    IT := slStrukt[J];
    SI := GetTxt(slStrukt[J]);
    DIF := (H1 - H2) div 20;
    if((h1-h2)mod 20 > 10)then inc(DIF);
    for K := 1 to DIF
    do SI := SI + '%%%';
    IT := SetTxt(IT,SI);
    slStrukt[J] := IT;
  end
  else begin
    IFHeight := H2+40;
    ilY2[DEBUT] := H2+ilY2[DEBUT];
    J := EndCond1;
    While(GetTyp(slStrukt[J]) <> 'Q')
    do dec(J);
    IT := slStrukt[J];
    SI := GetTxt(slStrukt[J]);
    DIF := (H2 - H1) div 20;
    if((h2-h1)mod 20 > 10)then inc(DIF);
    for K := 1 to DIF
    do SI := SI + '%%%';
    IT := SetTxt(IT,SI);
    slStrukt[J] := IT;
  end;
  if(DIF > 0)
  then begin
    while(ilX1.Count <> DEBUT)
    do begin
      ilX1.Delete(DEBUT);
      ilY1.Delete(DEBUT);
      ilX2.Delete(DEBUT);
      ilY2.Delete(DEBUT);
    end;
    IFWidth  := 0;
    IFHeight := 0;
    CalculateIF(DEBUT,pOFX,pOFY,CanAjust,J,IFWidth,IFHeight);
  end;
  NewI := I;
end;

{----------------------------------------------------}
{                Functions                           }
{----------------------------------------------------}

function TfrmMain.GetNearest(X,Y:integer):integer;
var
  I, X1,Y1,X2,Y2 : integer;
  tmp : string;
  HasNotFound : boolean;
begin
  Result := -1;
  I := 0;
  HasNotFound := True;
   While (I < slStrukt.Count) and HasNotFound
  do begin
    X1 := ilX1[I];
    Y1 := ilY1[I];
    X2 := ilX2[I];
    Y2 := ilY2[I];
    tmp := slStrukt[I];
    Case GetTyp(tmp) of
      'Q' :
      begin
        if(X >=X1)and(X<=X2)and(Y>=Y1)and(Y<=Y2)
        then begin
          Result := I;
          HasNotFound := false;
        end
        else Result := -1;
      end;
      'F' :
      begin
        if (X >=X1)and(X<=X2)   and(Y>=Y1)and(Y<=Y1+40)
        or (X >=X1)and(X<=X1+20)and(Y>=Y1)and(Y<=Y2)
        or (X >=X1)and(X<=X2)   and(Y>=Y2-20)and(Y<=Y2)
        then begin
          Result := I;
          HasNotFound := false;
        end
        else Result := -1;
      end;
      'R' :
      begin
        if(X >=X1)and(X<=X2)   and(Y>=Y2-40)and(Y<=Y2)
        or(X >=X1)and(X<=X1+20)and(Y>=Y1)   and(Y<=Y2)
        then begin
          Result := I;
          HasNotFound := false;
        end
        else Result := -1;
      end;
      'W' :
      begin
        if(X >=X1)and(X<=X2)and(Y>=Y1)and(Y<=Y1+40)
        or(X >=X1)and(X<=X1+20)and(Y>=Y1)and(Y<=Y2)
        then begin
          Result := I;
          HasNotFound := false;
        end
        else Result := -1;
      end;
      'I' :
      begin
        if(X >= X1)and(X<=X2)and(Y>=Y1)and(Y<=Y1+40)
        then begin
          Result := I;
          HasNotFound := false;
        end;
      end;
    end;
    inc(I);
  end;
end;

{----------------------------------------------------}
{                Event Procedures                    }
{----------------------------------------------------}


procedure TfrmMain.pbxStruktMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  I, P, LI, LJ, J, PTrenn : integer;
  Txt,TMP : string;
  Check : boolean;
  NewS : string;
begin
  INDEX := GetNearest(X,Y);
  if(Mode in [0..1])
  then Draw(pbxStrukt.Canvas);
  if(INDEX > -1)and(not((slStrukt.Count >= 97)and(Mode in[2..6])))
  then begin
    if(Button = mbLeft)
    then begin
      case Mode of
        0 :
        begin
          if(Button = mbLeft)and(Mode = 0)
          then DragIndex := INDEX;
        end;
        1 :
        begin
          with frmText
          do begin
            if(GetTyp(slStrukt[INDEX]) = 'Q'){Q=Mehrzeilig, Andere=Einzeiglig  }
            then begin                       {Mehrzeiliger Dialog mit Text     }
              edtText.Visible := False;      {füllen                           }
              memText.Visible := True;
              memText.Clear;
              Txt := GetTxt(slStrukt[INDEX]);

              While(pos('%%%',Txt) <> 0)     {Solange Trennfolge existiert     }
                and(Txt <> '%%%')
              do begin                       {Zeilen hinzufügen                }
                PTrenn := pos('%%%',Txt);
                TMP := copy(Txt,1,PTrenn - 1);
                delete     (Txt,1,PTrenn + 2);
                memText.Lines.Add(TMP);
              end;
              memText.Font := pbxStrukt.Font;
              if(INDEX = 0)
              then memText.Font.Color := clBlue; {Überschrift = Blau           }
            end
            else begin                        {Einzeiliger Dialog mit Text     }
              edtText.Font := pbxStrukt.Font;
              Txt := GetTxt(slStrukt[INDEX]);
              TMP := copy(Txt,1,pos('%%%',Txt)-1);
              edtText.Text := TMP;
              edtText.Visible := True;
              memText.Visible := False;
              edtText.Text := copy(Txt,1,pos('%%%',Txt)-1);
            end;
            Top  := Y + frmMain.Top  + pbxStrukt.Top; {Dialog an MausPos        }
            Left := X + frmMain.Left + pbxStrukt.Left;
            if(frmText.ShowModal = mrOk)
            then begin
              Undo.PUSH(slStrukt);             {Änderung gemacht! Undo Pushen  }
              MODI := True;                    {Änderungen, evt. speichern     }
              if(GetTyp(slStrukt[INDEX]) = 'Q'){Mehrzeilige Struktur mit Text  }
              then begin                       {aus dem Text Dialog füllen     }
                Txt := '';
                for I := 0 to memText.Lines.Count - 1
                do begin
                  Txt := Txt + memText.Lines[I] + '%%%';
                end;
                if(memText.Lines.Count - 1 = -1)then Txt := '%%%';
                slStrukt[INDEX] := SetTxt(slStrukt[INDEX],Txt);
              end
              else begin                       {Einzeilige Struktur mit Text   }
                Txt := edtText.Text + '%%%';   {aus dem Text Dialog füllen     }
                slStrukt[INDEX] := SetTxt(slStrukt[INDEX],Txt);
              end;
            end;
            MODI := True;
          end;
        end;
        2,3,4,5,6 :                             {2 = Linearer Ablauf           }
        begin                                   {3 = Kopfgesteuerte Schleife   }
          Undo.PUSH(slStrukt);                  {4 = Fussgesteuerte Schleife   }
          TMP := slStrukt[INDEX];               {5 = Zählschleife              }
          I := 0;                               {6 = IF (Verzweigung)          }
          if(GetTyp(TMP) <> 'Q')                {Geklickte Struktur beinhaltet }
          then begin                            {andere Strukturen ?           }
            LI := length(GetNum(TMP));
            LJ := length(GetNum(slStrukt[INDEX+I+1]));
            While((LJ > LI)and((INDEX + I + 1) <= slStrukt.Count - 1))
            do begin                       {Zählen bis Struktur übersprungen   }
                                           {Prinzip: Einfügen hinter der       }
                                           {geklickten Struktur                }
              LJ := length(GetNum(slStrukt[INDEX+I+1]));
              inc(I);
            end;
            if(LJ <= LI)then dec(I);       {Struktur übersprungen --> 1 zu weit}
          end;
          if(GetTyp(TMP) = 'Q')and(INDEX > 0)and(GetTxt(TMP) = '%%%')
            and(frmOptions.chkReplace.Checked)
          then begin                       {Linearer Ablauf löschen falls kein }
            slStrukt.Delete(INDEX);        {Text vorhanden ist und Option gew. }
            dec(I);
            NewS := GetNum(TMP);
            P := length(GetNum(TMP));
            NewS[P] := chr(ord(NewS[P])-1);{Da die geklickte Struktur nicht    }
            TMP := SetNum(TMP,NewS);       {übersprungen wird Num. wieder decr.}
          end;
          case MODE of
            2:                             {Je nach Mode Standard Text einfügen}
            begin                          {welcher sich in der StringListe    }
              TMP := SetTxt(TMP,'%%%');    {BlockLabels befindet               }
              TMP := SetTyp(TMP,'Q');
            end;
            3:
            begin
              TMP := SetTxt(TMP,BlockLabels[2] + ' %%%');
              TMP := SetTyp(TMP,'W');
            end;
            4:
            begin
              TMP := SetTxt(TMP,BlockLabels[1] + ' %%%');
              TMP := SetTyp(TMP,'R');
            end;
            5:
            begin
              TMP := SetTxt(TMP,BlockLabels[0] + ' %%%');
              TMP := SetTyp(TMP,'F');
            end;
            6:
            begin
              TMP := SetTxt(TMP,'%%%');
              TMP := SetTyp(TMP,'I');
            end;
          end;
          Check := True;
          slStrukt.Insert(INDEX+I+1,TMP);
          P := length(GetNum(TMP));
          J := INDEX + I + 1;
          LI := length(GetNum(slStrukt[J]));

          While(J <= slStrukt.Count - 1)and(Check)
          do begin                         {Die Numeration von Strukturen      }
            TMP := slStrukt[J];            {hinter der gewählten anpassen (+1) }
                                           {Nur Strukturen auf gleichem Level  }
            LJ := length(GetNum(slStrukt[J]));  {aa            aa              }
            if(length(GetNum(TMP)) >= P)        {ab <-Hinzu    ab              }
            then begin                          {ac <-Anpassen ac <-Hinzugefügt}
              NewS := GetNum(TMP);              {b             ad <-Angepasst  }
              NewS[P] := chr(ord(NewS[P]) + 1); {              b               }
              TMP := SetNum(TMP,NewS);
              slStrukt[J] := TMP;
            end;
            Check := LI <= LJ;
            inc(J);
          end;
          if(MODE in[3,4,5])               {1 linearer Ablauf für Schleifen    }
          then begin                       {hinzufügen                         }
            TMP := slStrukt[INDEX+I+1];
            TMP := SetTxt(TMP,'%%%');
            TMP := SetTyp(TMP,'Q');
            TMP := SetEMP(TMP,' ');
            TMP := SetNum(TMP,GetNum(TMP) + 'a');
            slStrukt.Insert(INDEX+I+2,TMP);
          end
          else if(MODE = 6)                {2 linearer Abläufe für Verzweigung }
          then begin                       {hinzufügen                         }
            TMP := slStrukt[INDEX+I+1];
            TMP := SetTxt(TMP,'%%%');
            TMP := SetTyp(TMP,'Q');
            TMP := SetEMP(TMP,'1');
            TMP := SetNum(TMP,GetNum(TMP) + 'a');
            slStrukt.Insert(INDEX+I+2,TMP);
            Delete(TMP,pos(';',TMP)-1,1);
            TMP := SetEMP(TMP,'2');
            TMP := SetNum(TMP,GetNum(TMP) + 'b');
            slStrukt.Insert(INDEX+I+3,TMP);
          end;
          MODI := True;                   {Struktogramm geändert (evt. Save)   }
        end;
      end;
    end
    else if(Button = mbRight)
    then begin
      TMP := slStrukt[INDEX];
      if(GetTyp(TMP) in['F','R','W'])    {Schleife?Schleifentyp ändern erlauben}
      then pmmTyp.Visible := True else pmmTyp.Visible := False;
      TX := X;                           {Text ändern per Popup, Pos speichern }
      TY := Y;
    end;
  end;
  if(Mode <> 0)and(INDEX <> -1)or(DragIndex <> INDEX)
  then begin
    INDEX := -1;
    CalcAndDraw;
  end;
  ButtonsEnabled;
end;

procedure TfrmMain.pbxStruktMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  I : integer;
  Check : boolean;
begin
  if(Mode = 0)
  then begin
    INDEX := GetNearest(X,Y);
    if(DragIndex > 0)and(INDEX > 0)    {Drag Drop Aktion?                }
      and(DragIndex <> INDEX)
    then begin
      Check := False;
      if(slCopy.Count > 0)             {Falls die Zwischenablage nicht   }
      then begin                       {leer ist dann zwischenspeichern  }
        Temp := TStringList.Create;    {da Drag & Drop diese benutzt     }
        Temp.Assign(slCopy);
        Check := True;
      end;
      I := INDEX;
      INDEX := DragIndex;
      mmiCopy.Tag := 0;                {slCopy leeren nach einfügen      }
      mmiCopyClick(Sender);
      INDEX := I;                      {Ziel zum Einfügen                }
      mmiPasteClick(Sender);
      {INDEX := I;
      ShowMessage(inttostr(slCopy.Count));
      if(INDEX > DragIndex)
      then INDEX := DragIndex
      else INDEX := INDEX + slCopy.Count + 1;
      ShowMessage(inttostr(INDEX));
      mmiDeleteClick(Sender);    }
      slCopy.Clear;
      if(Check)
      then begin
        slCopy.Assign(Temp);           {Temporäre slCopy widerherstellen }
        Temp.Free;
      end;
      CalcAndDraw;
    end;
  end;
  DragIndex := -1;                       {Drag zurücksetzen                    }
end;

procedure TfrmMain.mmiDeleteClick(Sender: TObject);
var
  I, K, P, LJ, NoEMP2: integer;
  NEWEMP : char;
  INIT, TMP, SJ, NewNum, NEWSEQ, JT : string;
  Check, DELETED : boolean;
begin
  if(INDEX > 0)
  then begin
    Undo.PUSH(slStrukt);                 {Änderung!!! Undo Pushen              }
    TMP := slStrukt[INDEX];
    INIT := TMP;                         {Gelöschte Struktur in TMP+INIT       }
    P := length(GetNum(TMP));            {Länge der Numeration der gelö. Strukt}
    case GetTYP(TMP) of
      'Q':
      begin
        DELETED := CanDelete(INDEX);     {Letzte Struktur in Schleife bzw.     }
        if(DELETED)                      {True, False Teil eines IF's          }
        then slStrukt.Delete(INDEX)      {---> Nur Text löschen                }
        else slStrukt[INDEX] := SetTxt(TMP,'%%%');
      end
      else begin                         {Struktur mit mehreren Strukturen     }
        NEWEMP := GetEMP(TMP);           {---> Alle löschen                    }
        DELETED := True;
        I  := INDEX;
        SJ := GetNum(slStrukt[INDEX+1]);
        While(length(SJ) > P)and(I <= slStrukt.Count - 1)
        do begin
          slStrukt.Delete(INDEX);
          if(I <= slStrukt.Count - 1)
          then SJ := GetNum(slStrukt[I]);
        end;
      end;
    end;
    if(DELETED)                           {Ganze Struktur gelöscht?            }
    then begin                            {Anpassen der Numerierung der        }
      if(INDEX > slStrukt.Count - 1)      {folgenden Strukturen                }
      then  I := slStrukt.Count - 1       {a,b,c(löschen),d(Anpassen)          }
      else begin                          {---> a,b,c(Angepasst)               }
        I := INDEX;
        LJ := length(GetNum(slStrukt[I]));
        if(P <= LJ)and(I <= slStrukt.Count -1)
        then begin
          LJ := length(GetNum(slStrukt[I]));
          While(I <= slStrukt.Count -1)and(P <= LJ)
          do begin
            TMP := slStrukt[I];
            LJ := length(GetNum(slStrukt[I]));
            if(length(GetNum(TMP)) >= P)
            then begin
              NewNum := GetNum(TMP);
              NewNum[P] := chr(ord(NewNum[P]) - 1); {Numeration um 1 decr.     }
              TMP := SetNum(TMP,NewNum);
              slStrukt[I] := TMP;
            end;
            inc(I);
          end;
        end;
      end;
      if(GetEMP(INIT) = '1')      {Struktur im True Teil des IF's ?            }
      then begin
        if(GetEMP(slStrukt[INDEX]) = '2')and(GetTyp(slStrukt[INDEX-1]) = 'I')
        then begin                {Letzte Struktur im True Teil gelöscht?      }
                                  {Neu Struktur einfügen!                      }
          NEWSEQ := SetNum(INIT,GetNum(INIT));
          NEWSEQ := SetEMP(NEWSEQ,'1');
          NEWSEQ := SetTxt(NEWSEQ,'%%%');
          NEWSEQ := SetTyp(NEWSEQ,'Q');
          slStrukt.Add(NEWSEQ);   {Add --> Strukturen sortieren                }
          slStrukt.Sorted := True;{a,b,c,d,b ---> a,b,b,c,d                    }
          slStrukt.Sorted := False;
          I  := INDEX+1;
          LJ := length(GetNum(slStrukt[I]));
          While(I <= slStrukt.Count -1)and(P <= LJ)
          do begin                {Numeration anpassen a,b,b,c,d -> a,b,c,d,e  }
            TMP := slStrukt[I];
            LJ := length(GetNum(slStrukt[I]));
            if(length(GetNum(TMP)) >= P)
            then begin
              NewNum := GetNum(TMP);
              NewNum[P] := chr(ord(NewNum[P]) + 1);
              TMP := SetNum(TMP,NewNum);
              slStrukt[I] := TMP;
            end;
            inc(I);
          end;
        end;
      end
      else if(GetEMP(INIT) = '2')  {Struktur im False Teil gelöscht?           }
      then begin                   {Anzahl der im False Teil enthaltenen       }
        Check := True;             {Strukturen zählen                          }
        K := INDEX;
        While(K <= slStrukt.Count - 1)
         and(length(GetNum(slStrukt[K])) >= length(GetNum(INIT)))
        do inc(K);
        if(K > slStrukt.Count-1)then K := slStrukt.Count - 1;
        if(length(GetNum(slStrukt[K])) < length(GetNum(INIT)))then dec(K);
        NOEMP2 := 0;
        JT := slStrukt[K];
        While(CHECK)
        do begin
         if(length(GetNum(INIT))=length(GetNum(JT)))and(GetEMP(JT) = '2')
         then inc(NOEMP2);
         CHECK := not(length(GetNum(JT)) = length(GetNum(INIT))-1);
         dec(K);
         JT := slStrukt[K];
        end;
        if(NOEMP2 = 0)           {Keine Struktur mehr im False Teil?           }
        then begin               {Eine Struktur hinzufügen                     }
          NEWSEQ := SetNum(INIT,GetNum(INIT));
          NEWSEQ := SetEMP(NEWSEQ,'2');
          NEWSEQ := SetTxt(NEWSEQ,'%%%');
          NEWSEQ := SetTyp(NEWSEQ,'Q');
          slStrukt.Add(NEWSEQ);
          slStrukt.Sorted := True;
          slStrukt.Sorted := False;
        end;
      end
      else begin                 {W,F,R gelöscht? (nicht direkt im True,False) }
        if(I = 0)then I := 1;    {W,F,R beinhaltet keine Struktur?             }
        if(GetTyp(slStrukt[I-1]) in ['W','F','R'])
          and(length(GetNum(slStrukt[I])) <= length(GetNum(slStrukt[I-1])))
          or(I = slStrukt.Count - 1)and(GetTyp(slStrukt[I]) in ['W','F','R'])
        then begin               {Struktur hinzufügen                          }
          NEWSEQ := SetNum(TMP,GetNum(TMP));
          NEWSEQ := SetEMP(NEWSEQ,NEWEMP);
          NEWSEQ := SetTxt(NEWSEQ,'%%%');
          NEWSEQ := SetTyp(NEWSEQ,'Q');
          slStrukt.Add(NEWSEQ);
        end;
      end;
      slStrukt.Sorted := True;
      slStrukt.Sorted := False;
      INDEX := -1;
    end;
    MODI := True;                {Struktogramm verändert !! Evt. speichern     }
  end;
  CalcAndDraw;                   {Neu Berechnen + Zeichnen                     }
  ButtonsEnabled;
end;

procedure TfrmMain.mmiCopyClick(Sender: TObject);
var
  I, LengthNumSelected : integer;
  TMP, NumI, NumJ : string;
  SAME : boolean;
begin
  if(INDEX > 0)                  {Eine Struktur angewählt? (ausser Überschrift)}
  then begin
    I := INDEX;
    TMP := slStrukt[INDEX];
    slCopy.Clear;                {Zwischenablage Stringliste leeren            }
    slCopy.Add(TMP);             {Angewählte Struktur hinzufügen               }
    SAME := True;
    if(INDEX < slStrukt.Count - 1 )
    then begin
      NumI := GetNum(slStrukt[I]);
      inc(I);
      While(SAME)and(I <= slStrukt.Count - 1)
      do begin
        TMP := slStrukt[I];
        NumJ := GetNum(TMP);
        SAME := CompareNum(NumI,NumJ);
        if(SAME)then slCopy.Add(TMP);
        inc(I);
      end;
    end;
    {Löschen der Strukturnumeration :
     aa   =
     aaa  =  a
     aab  =  b
     abschneiden von 'aa'
    }
    LengthNumSelected := length(GetNum(slCopy[0]));
    for I := 0 to slCopy.Count - 1
    do begin
      TMP := slCopy[I];
      delete(TMP,1,LengthNumSelected);
      slCopy[I] := TMP;
    end;
    mmiCopy.Tag := 0;     {Kein löschen von slCopy nach Paste(Einfügen)        }
    ButtonsEnabled;
  end;
end;

procedure TfrmMain.mmiPasteClick(Sender: TObject);
var
  I,LenNumJ,P : integer;
  S, TMP, NewS : string;
  EMP : char;
  Check : boolean;
begin
  if(slCopy.Count > 0)and(INDEX > -1)
    and(slStrukt.Count-1 + slCopy.Count-1 <= 100)
  then begin
    Undo.PUSH(slStrukt);
    I := INDEX;
    S := GetNum(slStrukt[I]);
    if(I <= slStrukt.Count - 1)
    then begin
      P := length(GetNum(slStrukt[I]));
      Check := True;
      TMP := slStrukt[I];
      While(I <= slStrukt.Count - 1)and(Check)
      do begin
        TMP := slStrukt[I];
        LenNumJ := length(GetNum(slStrukt[I]));
        if(length(GetNum(TMP)) >= P)
        then begin
          NewS := GetNum(TMP);
          NewS[P] := chr(ord(NewS[P]) + 1);
          TMP := SetNum(TMP,NewS);
          slStrukt[I] := TMP;
        end;
        Check := P <= LenNumJ;
        inc(I);
      end;
    end;
    TMP := slStrukt[INDEX];
    if(GetTyp(TMP) = 'Q')and(INDEX > 0)and(GetTxt(TMP) = '%%%')
      and(frmOptions.chkReplace.Checked)
    then begin
      slStrukt.Delete(INDEX);
      NewS := GetNum(TMP);
      P := length(GetNum(TMP));
      NewS[P] := chr(ord(NewS[P]) - 1);
      TMP := SetNum(TMP,NewS);
    end;
   // TMP := slStrukt[INDEX];
    EMP := GetEMP(TMP);
    S[length(S)] := char(ord(S[length(S)]));
    for I := 0 to slCopy.Count - 1
    do begin
      TMP := slCopy[I];
      NewS := S + GetNum(TMP);
      TMP := SetNum(TMP,NewS);
      if(I = 0)
      then TMP := SetEMP(TMP,EMP);
      slStrukt.Add(TMP);
    end;
    slStrukt.Sorted := True;
    slStrukt.Sorted := False;
    if(mmiCopy.Tag = 1)
    then begin
      slCopy.Clear;
      ButtonsEnabled;
    end;
    MODI := True;
  end;
  CalcAndDraw;
end;

procedure TfrmMain.tbtnSelectClick(Sender: TObject);
var
  CursorIMAGE : string;
begin
  if(Sender is TAction)
  then begin
    Mode := (Sender as TAction).Tag;
    CursorIMAGE := GetCurrentDir;
    Case Mode of
      0 :
      begin
        tbtnSelect.Down := True;
        CursorIMAGE := '';
      end;
      1 :
      begin
        tbtnText.Down := True;
        CursorIMAGE := CursorIMAGE + '\cursors\crtext.ani';
      end;
      2 :
      begin
        tbtnSequenz.Down := True;
        CursorIMAGE := CursorIMAGE + '\cursors\crseq.ani';
      end;
      3 :
      begin
        tbtnWhile.Down := True;
        CursorIMAGE := CursorIMAGE + '\cursors\crwhile.ani';
      end;
      4 :
      begin
        tbtnRepeat.Down := True;
        CursorIMAGE := CursorIMAGE + '\cursors\crrepeat.ani';
      end;
      5 :
      begin
        tbtnFor.Down := True;
        CursorIMAGE := CursorIMAGE + '\cursors\crfor.ani';
      end;
      6 :
      begin
        tbtnIf.Down := True;
        CursorIMAGE := CursorIMAGE + '\cursors\crif.ani';
      end;
    end;
  end
  else Mode := (Sender as TToolButton).Tag;
  Screen.Cursors[1] := LoadCursorFromFile(pchar(CursorIMAGE));
  pbxStrukt.Cursor:=1;
end;

procedure TfrmMain.pmiForClick(Sender: TObject);
var TMP : string;
begin
  TMP := slStrukt[INDEX];
  pmiFor.Checked := True;
  TMP := SetTyp(TMP,'F');
  slStrukt[INDEX] := TMP;
  CalcAndDraw;
end;

procedure TfrmMain.pmiWhileClick(Sender: TObject);
var TMP : string;
begin
  TMP := slStrukt[INDEX];
  pmiWhile.Checked := True;
  TMP := SetTyp(TMP,'W');
  slStrukt[INDEX] := TMP;
  CalcAndDraw;
end;

procedure TfrmMain.pmiRepeatClick(Sender: TObject);
var TMP : string;
begin
  TMP := slStrukt[INDEX];
  pmiRepeat.Checked := True;
  TMP := SetTyp(TMP,'R');
  slStrukt[INDEX] := TMP;
  CalcAndDraw;
end;

procedure TfrmMain.pmRightClickPopup(Sender: TObject);
begin
  if(INDEX > -1)
  then begin
    case GetTyp(slStrukt[INDEX])
    of
      'W' : pmiWhile.Checked  := True;
      'F' : pmiFor.Checked    := True;
      'R' : pmiRepeat.Checked := True;
    end;
  end;
end;

procedure TfrmMain.pmiTextClick(Sender: TObject);
var Shift : TShiftState;
begin
  Mode := 1;
  pbxStruktMouseUp(Sender,mbLeft,Shift,TX,TY);
end;

procedure TfrmMain.mmiNewClick(Sender: TObject);
var CLEAR_OK : TModalResult;
begin
  CLEAR_OK := mrNo;
  if MODI
  then begin
    CLEAR_OK := Confirm('The file '+ MyFile + ' has changed.'
                        + #13 + 'Do you want to save the changes?');
    if(CLEAR_OK = mrYes)
    then mmiSaveClick(Sender);
  end;
  if CLEAR_OK <> mrCancel
  then begin
    NewFile := True;
    MODI := False;
    slStrukt.Clear;
    slStrukt.Add('a;;Q;Strukt 1%%%');
    MyFile := 'Untitled.str';
    ShowFileNameInTitle(MyFile);
    CalcAndDraw;
    slCopy.Clear;
    Undo.CLEAR;
    tbtnSelect.Click;
    ButtonsEnabled;
  end;
end;

procedure TfrmMain.mmiOpenClick(Sender: TObject);
var CLEAR_OK : TModalResult;
begin
  CLEAR_OK := mrYes;
  if MODI
  then CLEAR_OK := Confirm('You did not save the changes of '+ MyFile + #13 +
                           'Do You really want to continue without saving?');
  if CLEAR_OK = mrYes
  then begin
    dlgOpen.FileName := MyFile;
    if dlgOpen.Execute
    then begin
      MyFile := dlgOpen.FileName;
      slStrukt.LoadFromFile(MyFile);
      ShowFileNameInTitle(MyFile);
      NewFile := False;
      MODI := False;
      ReplaceStruktCaptions;
      CalcAndDraw;
    end;
  end;
end;

procedure TfrmMain.mmiSaveAsClick(Sender: TObject);
begin
  dlgSave.FileName := MyFile;
  dlgSave.InitialDir := ExtractFilePath(Application.ExeName);
  if dlgSave.Execute
  then begin
    MyFile := dlgSave.FileName;
    NewFile := False;
    slStrukt.SaveToFile(MyFile);
    ShowFileNameInTitle(MyFile);
    MODI := false;
  end;
end;

procedure TfrmMain.mmiSaveClick(Sender: TObject);
begin
  if NewFile
  then mmiSaveAsClick(Sender)
  else begin
    slStrukt.SaveToFile(MyFile);
    MODI := false;
    NewFile := False;
  end;
end;

procedure TfrmMain.mmiExportClick(Sender: TObject);
var
 MFC : TMetaFileCanvas;
 W, H : Integer;
begin
 W := ilX2[0]-OFSETX-1;
 H := MaxHeight - OFSETY - 1;
 MF := TMetaFile.Create;
 MF.Inch := Round(W/10/2.54); // 10 cm breit
 MF.Width  := W-1;
 MF.Height := H-1;
 MFC := TMetaFileCanvas.Create(MF,0);
 H := INDEX;
 INDEX := -1;
 Draw(MFC); // MFC ist ein TCanvas
 INDEX := H;
 MFC.Free;
 Clipboard.Assign(MF); // In Zwischenablage
end;

procedure TfrmMain.mmiOptionsClick(Sender: TObject);
begin
  if(frmOptions.ShowModal = mrOk)
  then begin
    OFSETX := strtoint(frmOptions.edtLeft.Text);
    OFSETY := strtoint(frmOptions.edtTop.Text);
    pbxStrukt.Font.Name := frmOptions.cbFont.Text;
    pbxStrukt.Canvas.Font.Name := frmOptions.cbFont.Text;
    CalcAndDraw;
  end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
var
  PARA : TIniFile;
begin
  BlockLabels := TStringList.Create;
  PARA := TIniFile.Create(ExtractFilePath(Application.ExeName)+'strukt.ini');
  // Einlesen der zuletzt gewählten Schriftart
  pbxStrukt.Font.Name := PARA.ReadString('PROGRAM','Font','');
  pbXStrukt.Canvas.Font.Name := pbxStrukt.Font.Name;
  PARA.Free;
  // Erstellen:
  // - Struktogramm StringListe
  // - Zwischenablage StringListe
  // - Koordinaten ilX1,2,Y1,2 IntegerListe
  // - Undo Array von StapelStringlisten
  slCopy   := TStringList.Create;
  slStrukt := TStringList.Create;
  ilX1     := TIntList.Create;
  ilX2     := TIntList.Create;
  ilY1     := TIntList.Create;
  ilY2     := TIntList.Create;
  Undo     := TUndo.Create;
  // Überschrift ( Linearer Ablauf hinzufügen )
  slStrukt.Add('a; ;Q;Strukt 1%%%');
  MyFile := 'Untitled.str';
  ShowFileNameInTitle(MyFile);
  pbxStrukt.Canvas.Brush.Style := bsClear;
  // Gewählte Struktur = -1 = Keine Struktur angewählt
  INDEX := -1;
  // Schriftgrösse festlegen
  pbxStrukt.Font.Size := 12;
  pbxStrukt.Canvas.Font.Size := 12;
  // Standart OffsetX,Y Festlegen auf 20 Pixel
  OFSETX := 20;
  OFSETY := 20;
  // Berechnen + Zeichnen vom Struktogramm (1 Struktur = Überschrift zur Zeit)
  CalcAndDraw;
  // Mode = 0 = Anwählen
  Mode := 0;
  MODI := False;
  NewFile := True;
  ButtonsEnabled;
end;

procedure TfrmMain.mmiPrintClick(Sender: TObject);
{**************************************************************
 * Druckerformualr anzeigen                                   *
 **************************************************************}
begin
  mmiExportClick(Sender);           {Export vom Struktogramm in WMF zum Drucken}
  frmPrint.ShowModal;
end;

procedure TfrmMain.mmiCutClick(Sender: TObject);
{**************************************************************
 * Ausschneiden einer Struktur in die Zwischenablage slCopy   *
 **************************************************************}
begin
  mmiCopyClick(Sender);
  mmiCopy.Tag := 1;                     {Zwischenablage nach Einfügen leeren   }
  mmiDeleteClick(Sender);
end;

procedure TfrmMain.ButtonsEnabled;
{**************************************************************
 * Knöpfe nach je nach Situation Aktivieren bzw. Deaktivieren *
 **************************************************************}
begin
  mmiCut.Enabled     := INDEX > 0;
  pmiCut.Enabled     := mmiCut.Enabled;
  tbtnCut.Enabled    := mmiCut.Enabled;
  mmiCopy.Enabled    := INDEX > 0;
  pmiCopy.Enabled    := mmiCut.Enabled;
  tbtnCopy.Enabled   := mmiCut.Enabled;
  mmiDelete.Enabled  := INDEX > 0;
  pmiDelete.Enabled  := mmiCut.Enabled;
  tbtnDelete.Enabled := mmiCut.Enabled;
  mmiPaste.Enabled   := (slCopy.Count > 0)and(INDEX > 0);
  pmiPaste.Enabled   := mmiPaste.Enabled;
  tbtnPaste.Enabled  := mmiPaste.Enabled;
  mmiUndo.Enabled    := Undo.CanUndo;
end;

procedure TfrmMain.mmiQuitClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
{***********************************************************
 * Schliessen des Programms                                *
 * Änderungen am Struktogramm die nicht gespeichert sind?  *
 * --> Nachfrage op Struktogramm abgespeichert werden soll *
 ***********************************************************}
var
  CONF : TModalResult;
  PARA : TIniFile;
begin
  CanClose := False;
  if(MODI)
  then begin
    CONF := Confirm('You did not save the changes of the file ' + MyFile
                    + chr(13) + 'Do you want to save the changes?') ;
    if(CONF = mrYes)
    then begin
      if(NewFile = False)
      then slStrukt.SaveToFile(MyFile)
      else mmiSaveClick(Sender);
      CanClose := True;
    end
    else if(CONF <> mrCancel)then CanClose := True;
  end
  else CanClose := True;
  if(CanClose)
  then begin
    PARA := TIniFile.Create(ExtractFilePath(Application.ExeName)+'strukt.ini');
    PARA.WriteString('PROGRAM','Language',frmOptions.cbLanguage.Text);
    PARA.WriteString('PROGRAM','Font',pbxStrukt.Font.Name);
    PARA.WriteBool('PROGRAM','Replace',frmOptions.chkReplace.Checked);
    PARA.Free;
  end;
end;

procedure TfrmMain.mmiAboutClick(Sender: TObject);
begin
  frmAbout.ShowModal;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
{*****************************************************
 * Freigeben der zur Laufzeit erstellten Komponenten *
 *****************************************************}
begin
  slCopy.Free;
  slStrukt.Free;
  ilX1.Free;
  ilX2.Free;
  ilY1.Free;
  ilY2.Free;
  Undo.Free;
  BlockLabels.Free;
  MF.Free;
end;

procedure TfrmMain.mmiUndoClick(Sender: TObject);
{************************************************
 * Rückgängig machen der letzten durchgeführten *
 * Aktion                                       *
 ************************************************}
begin
  if(Undo.CanUndo)
  then begin
    slStrukt.Assign(Undo.Pop);
    mmiUndo.Enabled := Undo.CanUndo;
    CalcAndDraw;
  end;
end;

procedure TfrmMain.mmFileMeasureItem(Sender: TObject; ACanvas: TCanvas;
  var Width, Height: Integer);
{*********************************************
 * Durch ersetzen von den Menüitems wird die *
 * Breite falsch berechnet --> Neu berechnen *
 *********************************************}
begin
  Width := ACanvas.TextWidth(mmFile.Caption) - 7;
end;

procedure TfrmMain.FormMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
{******************************************
 * Scrollen auf der Struktogrammseite     *
 ******************************************}
begin
  WheelDelta := - WheelDelta;
  with scbMainBox.VertScrollBar do begin
    case WheelDelta > 0 of
      True:
      begin
        if (Position + WheelDelta) <= Range
        then Position := Position + WheelDelta
        else Position := Range;
      end;
      False:
      begin
        if (Position - WheelDelta) >= 0
        then Position := Position + WheelDelta
        else Position := 0;
      end;
    end;
  end;
end;

procedure TfrmMain.ReplaceStruktCaptions;
{******************************************
 * Ersetzen von den standard caption's    *
 * in die gewählte Sprache                *
 ******************************************}
var
  I, J, K: integer;
  Labels : array[0..29]of TStringList;
  LANG : TIniFile;
  TXT, TMP: string;
begin
  for I := 0 to frmOptions.cbLanguage.Items.Count - 1
  do begin
    LANG := TIniFile.Create(ExtractFilePath(Application.ExeName)+'languages\'+frmOptions.cbLanguage.Items[I]+'.ini');
    Labels[I] := TStringList.Create;
    Labels[I].Add(LANG.ReadString('LANG','For',''));
    Labels[I].Add(LANG.ReadString('LANG','Repeat',''));
    Labels[I].Add(LANG.ReadString('LANG','While',''));
    LANG.Free;
  end;
  for I := 0 to slStrukt.Count - 1
  do begin
    TMP := slStrukt[I];
    for K := 0 to frmOptions.cbLanguage.Items.Count - 1
    do begin
      for J := 0 to 2
      do begin
        TXT := GetTxt(TMP);
        if(pos(Labels[K][J],TXT) = 1)
        then begin
          delete(TXT,1,length(Labels[K][J]));
          insert(BlockLabels[J],TXT,1);
          TMP := SetTxt(TMP,TXT);
        end;
      end;
    end;
    slStrukt[I] := TMP;
  end;
  for I := 0 to frmOptions.cbLanguage.Items.Count - 1
  do Labels[I].Free;
end;

procedure TfrmMain.pbxStruktPaint(Sender: TObject);
{******************************************
 * Neuzeichnen des Struktogramms falls    *
 * es von anderen Fenstern überlappt wird *
 ******************************************}
begin
  Draw(pbxStrukt.Canvas);
end;

end.

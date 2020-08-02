{******************************************************************************}
{* Unit    : UClasses.pas                                                     *}
{* Klassen : TIntList, TUndo                                                  *}
{* TInList : Eine Liste von 200 Integer Werten                                *}
{*           --> Schneller als TStringList da Umwandlungen eingespart werden  *}
{* TUndo   : Stapel von TStringListen (Rückgänig Funktion)                    *} 
{******************************************************************************}

unit UClasses;

interface

uses
  Classes;

type
  TIntList = class
    private
      CUR_POS : integer;
      Items : array[0..199]of integer;
      function  GetValue(I : integer):integer;
      procedure SetValue(I,X : integer);
    public
      property Values[I : integer] : integer read GetValue write SetValue; default;
      function Count : integer;
      procedure Add(X : integer);
      procedure Delete(I : integer);
      procedure CLEAR;
      constructor CREATE;
  end;
  TUndo = class
    private
      DATA : array[1..10]of TStringList;
      CUR_POS : integer;
      MAX_POS : integer;
    public
      function CanUndo : boolean;
      procedure PUSH(X : TStringList);
      function POP: TStringList;
      procedure CLEAR;
      constructor CREATE;
      destructor Destroy;
  end;

implementation

uses UMain;

constructor TIntList.CREATE;
var I : integer;
begin
  for I := 0 to 199               {Initialisieren von den Integerwerten auf -1 }
  do Items[I] := -1;
  CUR_POS := -1;                  {CUR_POS = Aktuelle Position (Add Funktion)  }
end;

function TIntList.GetValue(I : integer):integer;
begin
  Result := Items[I];
end;

procedure TIntList.SetValue(I,X : integer);
begin
  Items[I] := X;
end;

procedure TIntList.Delete(I : integer);
var J : integer;
begin
  for J := I to Count - 1         {Verschieben der IntListe um 1 nach links    }
  do Items[I] := Items[I+1];
  dec(CUR_POS);
end;

function TIntList.Count : integer;
begin
  Result := CUR_POS + 1;          {Anzahl der Integerwerten                    }
end;

procedure TIntList.Add(X : integer);
begin
  if(CUR_POS < 199)               {IntListe nicht voll --> Hinzufügen          }
  then begin
    inc(CUR_POS);
    Items[CUR_POS] := X;
  end;
end;

procedure TIntList.CLEAR;
var I : integer;
begin
  for I := 0 to 199               {Löschen der IntListe                        }
  do Items[I] := -1;
  CUR_POS := -1;
end;

constructor TUndo.CREATE;
var I : integer;
begin
  for I := 1 to 10                {10 StringListen erstellen                   }
  do DATA[I] := TStringList.Create;
  CUR_POS := 0;
  MAX_POS := 0;
end;

function TUndo.CanUndo : boolean;
begin
  Result := CUR_POS > 0;          {Eine Stringliste vorhanden?                 }
end;

procedure TUndo.PUSH(X : TStringList);
var I : integer;
begin
  if(CUR_POS = 10)                {Liste der TStringListen voll?               }
  then begin                      {--> Verschieben um 1 nach links             }
    for I := 1 to 9
    do DATA[I].Assign(DATA[I+1]);
  end;
  if(CUR_POS < 10)then inc(CUR_POS);
  DATA[CUR_POS].Assign(X);
end;

function TUndo.POP : TStringList;
begin
  if(CUR_POS > 0)                 {1 StringListe vorhanden?                    }
  then begin
    POP := (DATA[CUR_POS]);       {Ausgabe                                     }
    dec(CUR_POS);                 {'Virtuelles' entfernen  der ausgegebenen    }
  end                             {StringListe                                 }
  else POP := nil;
end;

procedure TUndo.CLEAR;
begin
  CUR_POS := 0;                   {'Virtuelles' löschen der StringListen       }
end;                              {CUR_POS = 0 = Keine StringListe vorhanden   }

destructor TUndo.Destroy;
var
  I  : integer;
begin
  for I := 1 to 10                {Freigeben der Stringlisten                  }
  do DATA[I].Free;
end;

end.

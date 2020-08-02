unit UPrint;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  StdCtrls, Printers, ExtCtrls, Spin;

type
  TfrmPrint = class(TForm)
    gbPrinter: TGroupBox;
    cbPrinter: TComboBox;
    lblName: TLabel;
    gbPreview: TGroupBox;
    sedtGrand: TSpinEdit;
    Label1: TLabel;
    lblSize: TLabel;
    imgPreview: TImage;
    btnOk: TButton;
    btnCancel: TButton;
    procedure FormShow(Sender: TObject);
    procedure cbPrinterChange(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure sedtGrandChange(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
  private
    StruktRatio : real;
    EWidth, EHeight:integer;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrint: TfrmPrint;

implementation

uses UMain;

{$R *.dfm}

procedure TfrmPrint.FormShow(Sender: TObject);
var
  PageRatio : real;
  BMP   : TBitMap;
begin
  cbPrinter.Items := Printer.Printers;
  if(cbPrinter.Items.Count > 0)
  then begin
    sedtGrand.Value := 50;
    cbPrinter.ItemIndex := 0;
    PageRatio := Printer.PageHeight / Printer.PageWidth;
    EHeight := frmMain.MF.Height;
    EWidth  := frmMain.MF.Width;
    if(EWidth > EHeight)
    then StruktRatio := EHeight / EWidth
    else StruktRatio := EWidth  / EHeight;
    BMP := TBitmap.Create;
    BMP.Width  := imgPreview.Width;
    BMP.Height := round(BMP.Width * PageRatio) ;
    imgPreview.Picture.Bitmap := BMP;
   // sedtGrand.Value := round((imgPreview.Canvas.TextWidth('W') / Printer.Canvas.TextWidth('W'))*BMP.Width);
    with imgPreview.Canvas
    do begin
      Brush.Style := bsSolid;
      FillRect(imgPreview.ClientRect);
      Rectangle(imgPreview.ClientRect);
      Brush.Color := clYellow;
      if(EWidth > EHeight)
      then Rectangle(0,0,round(imgPreview.Width * (sedtGrand.Value / 100)),round(imgPreview.Width * (sedtGrand.Value / 100)*StruktRatio))
      else Rectangle(0,0,round(imgPreview.Height * (sedtGrand.Value / 100)*StruktRatio),round(imgPreview.Height * (sedtGrand.Value / 100)));
      Brush.Color := clWhite;
    end;
    BMP.Free;
  end
  else btnOk.Enabled := False;
end;

procedure TfrmPrint.cbPrinterChange(Sender: TObject);
begin
  Printer.PrinterIndex := cbPrinter.ItemIndex;
end;

procedure TfrmPrint.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmPrint.sedtGrandChange(Sender: TObject);
begin
  with imgPreview.Canvas
  do begin
    FillRect(imgPreview.ClientRect);
    Rectangle(imgPreview.ClientRect);
    Brush.Color := clYellow;
    if(EWidth > EHeight)
    then Rectangle(0,0,round(imgPreview.Width * (sedtGrand.Value / 100)),round(imgPreview.Width * (sedtGrand.Value / 100)*StruktRatio))
    else Rectangle(0,0,round(imgPreview.Height * (sedtGrand.Value / 100)*StruktRatio),round(imgPreview.Height * (sedtGrand.Value / 100)));
    imgPreview.Canvas.Brush.Color := clWhite;
  end;
end;

procedure TfrmPrint.btnOkClick(Sender: TObject);
begin
  with Printer
  do begin
    PrinterIndex := cbPrinter.ItemIndex;
    BeginDoc;
      if(EWidth > EHeight)
      then Canvas.StretchDraw(Rect(0,0,round(PageWidth * (sedtGrand.Value / 100)),round(PageWidth *  (sedtGrand.Value / 100)*StruktRatio)),frmMain.MF)
      else Canvas.StretchDraw(Rect(0,0,round(PageHeight * (sedtGrand.Value / 100)*StruktRatio),round(PageHeight * (sedtGrand.Value / 100))),frmMain.MF);
    EndDoc;
  end;
end;

end.

program GStrukt;

uses
  Forms,
  UMain in 'UMain.pas' {frmMain   },
  UText in 'UText.pas' {frmText   },
  UOptions in 'UOptions.pas' {frmOptions},
  UPrint in 'UPrint.pas' {frmPrint  },
  UAbout in 'UAbout.pas' {frmAbout  },
  UClasses in 'UClasses.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'GStrukt';
  Application.CreateForm(TfrmMain   , frmMain   );
  Application.CreateForm(TfrmText, frmText);
  Application.CreateForm(TfrmPrint, frmPrint);
  Application.CreateForm(TfrmAbout, frmAbout);
  Application.CreateForm(TfrmOptions, frmOptions);
  Application.Run;
end.

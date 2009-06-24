program pMWICTest;

uses
  Forms,
  frmTest in 'frmTest.pas' {Form1},
  uMWICIntf in 'uMWICIntf.pas',
  uALFac in 'uALFac.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

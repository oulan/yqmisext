unit frmTest;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  uALFac;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  Caption := ALFInit;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Caption := ALFRead;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  S: String;
begin
  S       := Edit1.Text;
  Caption := ALFWrite(0, '', Length(S), PChar(S));
end;

end.

unit receive_Win_Message;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs;

type
  TMyform = class(TForm)
  private
    { Private declarations }
  public
    { Public declarations }
    procedure CopyData(var Msg : TWMCopyData);Message WM_COPYDATA;
  end;

var
  MyForm: TMyForm;

implementation

{$R *.dfm}

{ TMyform }

procedure TMyform.CopyData(var Msg: TWMCopyData);
var
  str : String;
begin
  if IsIconic(Application.Handle) then
  begin
    Application.Restore;
  end;
  str := Pchar(Msg.CopyDataStruct.lpData);
  showmessage(str);
end;

end.

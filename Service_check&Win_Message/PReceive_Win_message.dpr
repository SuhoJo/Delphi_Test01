program PReceive_Win_message;

uses
  Vcl.Forms,
  receive_Win_Message in 'receive_Win_Message.pas' {Myform};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMyform, Myform);
  Application.Run;
end.

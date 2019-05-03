unit Svc;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  WinSvc, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    Timer1: TTimer;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function ServiceGetStatus(sMachine, sService : Pchar): DWORD;
    function ServiceRunning(sMachine,sService :pchar):Boolean;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
//  if ServiceRunning(nil,'MSSQL$BMPOS') then
//  begin
//    ShowMessage('MSSQL$BMPOS Service Running');
//  end
//  else
//  begin
//    ShowMessage('MSSQL$BMPOS Service Not Running');
//    memo1.Lines.Add('@@@');
//  end;
  if (ServiceRunning(nil,'MSSQL$BMPOS')=false) then
  begin
    memo1.Lines.Add(' MSSQL$BMPOS Service Not Running');
    if Timer1.Enabled = False then
    begin
      Timer1.Enabled := True;
    end
    else
    begin
      exit;
    end;
  end
  else
  begin
    memo1.Lines.Add(' MSSQL$BMPOS Service Running');
    Timer1.Enabled := False;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  LStr : String;
  hwnd : THandle;
  LDataStruct : CopyDataStruct;
begin
  hwnd := FindWindow('TMyForm',nil);
  LStr :='Test!';
  Caption := Format('%d', [LStr.Length * SizeOf(Char), length(LStr) + 1]);

  if hwnd <> 0 then
  begin
    LDataStruct.dwData := 0;
    LDataStruct.cbData := length(LStr) + 1;
    LDataStruct.lpData := PChar(LStr);
    SetForegroundWindow(hwnd);
    SendMessage(hwnd,wm_CopyData, Form1.Handle, @LDataStruct)
  end;
end;

function TForm1.ServiceGetStatus(sMachine, sService: Pchar): DWORD;
var
  SCManHandle, SvcHandle : SC_Handle;
  SS : TServiceStatus;
  dwStat : DWORD;
begin
  dwStat := 0;
  SCManHandle := OpenSCManager(sMachine, nil, SC_MANAGER_CONNECT);
  if (SCManHandle > 0) then
  begin
    SvcHandle := OpenService(SCManHandle, sService, SERVICE_QUERY_STATUS);
    if (SvcHandle > 0) then
    begin
      if (QueryServiceStatus(SvcHandle, SS)) then
      begin
        dwStat := ss.dwCurrentState;
      end;
      CloseServiceHandle(SvcHandle);
    end;
    CloseServiceHandle(SCManHandle);
  end;
  Result := dwStat;
end;

function TForm1.ServiceRunning(sMachine, sService: pchar): Boolean;
begin
  Result := SERVICE_RUNNING = ServiceGetStatus(sMachine,sService);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  memo1.Lines.Add('Timer_on');
  button1.Click;
end;

end.

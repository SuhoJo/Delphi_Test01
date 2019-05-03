 unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Registry, Vcl.Grids;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    Label1: TLabel;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    RootKey : String;
  end;

var
  Form1: TForm1;

implementation
  const Rootkey = HKEY_CURRENT_USER;
  const Path    = 'NicePos\Settings' ;
{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  MyReg : TRegistry;
  strs  : TStrings;
  i     : Integer;
  svStr : TStrings;
begin
    MyReg := TRegistry.Create;
    myreg.RootKey := HKEY_CURRENT_USER;
    if(MyReg.OpenKey(Path,false))then
    begin
        memo1.Lines.Add('keyOpen_ok');
        strs := TStringList.Create;
        strs.Clear;
        svStr := TStringList.Create;
        try
          label1.Caption := myreg.CurrentPath;
          myreg.GetValueNames(strs);
          for i := 0 to strs.Count -1 do
          begin
            if myreg.ValueExists(strs[i]) then
            begin
              memo1.Lines.Add(strs[i]+':');
              Case myreg.GetDataType(strs[i]) of
                rdUnknown      :
                begin
                  memo1.Lines.Add('Type : rdUnknown, '     + 'Value : ' + myreg.GetDataAsString(strs[i])+#13#10);
                  svStr.Add(strs[i]+',0,'+myreg.GetDataAsString(strs[i]));
                end;
                rdString       :
                begin
                  memo1.Lines.Add('Type : rdString, '      + 'Value : ' + myreg.GetDataAsString(strs[i])+#13#10);
                  svStr.Add(strs[i]+',1,'+myreg.GetDataAsString(strs[i]));
                end;
                rdExpandString :
                begin
                  memo1.Lines.Add('Type : rdExpandString, '+ 'Value : ' + myreg.GetDataAsString(strs[i])+#13#10);
                  svStr.Add(strs[i]+',2,'+myreg.GetDataAsString(strs[i]));
                end;
                rdInteger      :
                begin
                  memo1.Lines.Add('Type : rdInteger, '     + 'Value : ' + myreg.GetDataAsString(strs[i])+#13#10);
                  svStr.Add(strs[i]+',3,'+myreg.GetDataAsString(strs[i]));
                end;
                rdBinary       :
                begin
                  memo1.Lines.Add('Type : rdBinary,  '     + 'Value : ' + myreg.GetDataAsString(strs[i])+#13#10);
                  svStr.Add(strs[i]+',4,'+myreg.GetDataAsString(strs[i]));
                end;
              End;
            end
            else
            begin
              memo1.Lines.Add(strs[i]+'No_Value');
            end;
          end;
        finally
          svStr.SaveToFile('.\test.txt');
          strs.Free;
          svStr.Free;
        end;
    end
    else
    begin
        memo1.Lines.Add('Key_no');
    end;
    myReg.CloseKey;
    myReg.Free;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  MyReg : TRegistry;
  LStr  : TStrings;
  WStr  : TStrings;
  i     : Integer;
  str   : String;
begin
    myreg := TRegistry.Create;
    myreg.RootKey := HKEY_CURRENT_USER;
    if ( myreg.KeyExists(path)) then
    begin
      memo1.Lines.Add('KeyExist');
      exit;
    end;
    Myreg.Access := Key_Write;
    if(MyReg.OpenKey(Path,true))then
    begin
        memo1.Lines.Add('Key_Create_ok');
        LStr := TStringList.Create;
        WStr := TStringList.Create;
        try
          Myreg.Access := Key_Write;
          LStr.LoadFromFile('.\test.txt');
          for i := 0 to LStr.Count -1 do
          begin
            WStr.Clear;
            Wstr.CommaText := LStr.Strings[i];
            str := WStr[1];
            case StrToInt(WStr[1]) of
              0 :
              begin
                memo1.Lines.Add('rdUnknown type');
              end;
              1 :
              begin
                Myreg.WriteString(WStr[0],WStr[2]);
              end;
              2 :
              begin
                Myreg.WriteExpandString(WStr[0],WStr[2]);
              end;
              3 :
              begin
                Myreg.WriteInteger(WStr[0],StrToInt(WStr[2]));
              end;
              4 :
              begin
                memo1.Lines.Add('rdBinary type');
//                Myreg.wInteger(WStr[0],StrToInt(WStr[2]));
              end;
            end;
            memo1.Lines.Add(IntToStr(i)+ WStr[0]+'Write_ok');
          end;
        finally
          memo1.Lines.Add(IntToStr(myreg.LastError));
          if myreg.LastError = 0 then
          begin
            memo1.Lines.Add('복원 완료.');
          end;
          LStr.Free;
          WStr.Free;
        end;
    end
    else
    begin
        memo1.Lines.Add('key_no');
    end;
    myreg.CloseKey;
    MyReg.Free;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  Reg : TRegistry;
  KeyFileName : String;
begin
   KeyFileName := 'C:\temp\tempReg';
  if FileExists(KeyFileName) then
  begin
    DeleteFile(KeyFileName);
  end;
  Reg := TRegistry.Create(KEY_ALL_ACCESS);
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    Reg.OpenKey('NicePos',true);
    if Reg.SaveKey('NicePos', KeyFileName) then
    begin
      ShowMessage('BACKUP_OK');
    end
    else
    begin
      ShowMessage('BACKUP_ERROR: ' + Reg.LastErrorMsg + '!');
    end;
  finally
    Reg.Free;
  end;

end;

procedure TForm1.Button4Click(Sender: TObject);
var
  MyReg : TRegistry;
begin
  MyReg := TRegistry.Create;
  MyReg.Access := KEY_WRITE;
  Myreg.RootKey := HKEY_CURRENT_USER;
  if not Myreg.KeyExists(path) then
  begin
    memo1.Lines.Add(path + ' key not Exist');
    exit;
  end;
  if Myreg.DeleteKey(path) then
  begin
    memo1.Lines.Add(path + '_key Delete_ok');
  end
  else
  begin
    memo1.Lines.Add(path + '_key Delete_Fail');
  end;

  if Myreg.DeleteKey('NicePos') then
  begin
    memo1.Lines.Add('NicePos' + '_key Delete_ok');
  end
  else
  begin
    memo1.Lines.Add('NicePos' + '_key Delete_Fail');
  end;

  MyReg.Free;
end;

end.

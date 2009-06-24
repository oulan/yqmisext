unit uALFac;

interface

const
  DEFAULTPWD = '';

function ALFInit(port: Integer = 0; Pwd: String = DEFAULTPWD; Size: Integer = 0; Data: PChar=nil): PChar;
function ALFRead(port: Integer = 0; Pwd: String = DEFAULTPWD; Size: Integer = 0): PChar;
function ALFWrite(port: Integer = 0; Pwd: String = DEFAULTPWD; Size: Integer = 0; Data: PChar=nil): PChar;

implementation

uses
  uMWICintf;

const
  MWDEFAULTPWD = #255#255#255;
  USERDEFPWD   = #79#76#72;
  BUFFSIZE     = 224;
  DEFAULTOFF   = 32;

type
  _TCallProc = function (icdev: LongInt; Size: Integer; Data: PChar = nil): PChar;

var
  buff: array[0..BUFFSIZE] of char;

function _Caller(port: Integer; Pwd: String; Size: Integer; Data: PChar; Callee: _TCallProc; PCStage: Integer=0): PChar;
var
  icdev: LongInt;
  baud, state, status: Integer;
  p: array[0..2] of char;
begin
  baud   := 9600;
  icdev  := auto_init(port, baud);
  if icdev < 0 then begin
    Result := '-端口错误！';
    Exit;
  end;
  try
    status := 0;
    state  := get_status(icdev, @status);
    if state <> 0 then begin
      Result := '-读卡器状态错误！';
      Exit;
    end else if status = 1 then
      Result := '+读卡器中有卡！'
    else begin
      Result := '-读卡器中无卡！';
      Exit;
    end;

    p[0] := MWDEFAULTPWD[1];
    p[1] := MWDEFAULTPWD[2];
    p[2] := MWDEFAULTPWD[3];
    if PCStage = 2 then begin
      if Pwd = '' then begin
        p[0] := USERDEFPWD[1];
        p[1] := USERDEFPWD[2];
        p[2] := USERDEFPWD[3];
      end else if Length(Pwd) < 3 then
        Exit
      else begin
        p[0] := Pwd[1];
        p[1] := Pwd[2];
        p[2] := Pwd[3];
      end;
    end;
    if PCStage > 0 then begin
      state := csc_4442(icdev, 3, p);
      if state <> 0 then begin
        Result := '-密码错误！';
        Exit
      end else
        Result := '+密码检查正确！';
    end;

    Result := Callee(icdev, Size, Data);
  finally
    ic_exit(icdev);
  end;
end;

function _init(icdev: LongInt; Size: Integer; Data: PChar = nil): PChar;
var
  state, SL: Integer;
  p: PChar;
begin
  // 更改密码为
  state := wsc_4442(icdev, 3, USERDEFPWD);
  if state <> 0 then begin
    Result := '-卡密更换错误！';
    Exit;
  end;
  // 初始化应用数据区，自offset32开始，至256共224个字节
  if Data <> nil then
    p := Data
  else begin
    FillChar(buff, BUFFSIZE, 0);
    p := buff;
  end;
  SL := Size;
  if Size = 0 then SL := BUFFSIZE;
  state := swr_4442(icdev, DEFAULTOFF, SL, p);
  if state <> 0 then
    Result := '-卡初始化失败！'
  else
    Result := '+卡初始化OK！';
end;

function ALFInit(port: Integer; Pwd: String; Size: Integer; Data: PChar): PChar;
begin
  Result := _Caller(port, Pwd, Size, Data, _init, 1);
end;

function _read(icdev: LongInt; Size: Integer; Data: PChar): PChar;
var
  state, SL: Integer;
begin
  FillChar(buff, BUFFSIZE, 0);
  SL    := Size;
  if SL = 0 then SL := BUFFSIZE;
  state := srd_4442(icdev, DEFAULTOFF, SL, buff);
  if state <> 0 then
    Result := '-读卡错误！'
  else
    Result := buff;
end;

function ALFRead(port: Integer; Pwd: String; Size: Integer): PChar;
begin
  Result := _Caller(port, Pwd, Size, nil, _read, 0);
end;

function _write(icdev: LongInt; Size: Integer; Data: PChar): PChar;
var
  state, SL: Integer;
begin
  Result := '-写入数据为空！';
  if Data = nil then Exit;
  if Size = 0 then Exit;
  state := swr_4442(icdev, DEFAULTOFF, Size, Data);
  if state <> 0 then
    Result := '-数据写入错误！'
  else
    Result := '+数据写入OK！';
end;

function ALFWrite(port: Integer; Pwd: String; Size: Integer; Data: PChar): PChar;
begin
  Result := _Caller(port, Pwd, Size, Data, _write, 2);
end;

end.

library mwintfyf;

uses
  SysUtils, Windows, Classes, uALFac;

{$R *.res}


// 定义雅奇MIS接口函数
// AB
// A 端口
// 明华卡的波特率为9600，没有必要自定义，端口需要指定
// 0-COM1, 2-COM3...
// B I, R, W
// W CCCD...
// CCC长度
function YAQiFunction(call: PChar): PChar; stdcall;
var
  icdev: LongInt;
  port, baud, status, state, count, offset, len: Integer;
  fid: char;
  sizeStr: String;
begin
  Result := '-指令错误！';
  if strlen(call) < 2 then Exit;
  port := Ord(call[0]) - Ord('0');
  case call[1] of
    'I', 'i': Result := ALFInit(port);
    'R', 'r': Result := ALFRead(port);
    'W', 'w': begin
      if strlen(call) < 5 then Exit;
      SetLength(sizeStr, 3);
      sizeStr[1] := call[2];
      sizeStr[2] := call[3];
      sizeStr[3] := call[4];
      Result := '-写入长度错误！';
      try
        len    := StrToInt(sizeStr);
        Result := ALFWrite(port, '', len, call + 5);
      except
        Exit;
      end;
    end;
  end;
end;

exports
  YAQiFunction;
  
end.

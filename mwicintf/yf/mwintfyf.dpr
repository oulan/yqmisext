library mwintfyf;

uses
  SysUtils, Windows, Classes, uALFac;

{$R *.res}


// ��������MIS�ӿں���
// AB
// A �˿�
// �������Ĳ�����Ϊ9600��û�б�Ҫ�Զ��壬�˿���Ҫָ��
// 0-COM1, 2-COM3...
// B I, R, W
// W CCCD...
// CCC����
function YAQiFunction(call: PChar): PChar; stdcall;
var
  icdev: LongInt;
  port, baud, status, state, count, offset, len: Integer;
  fid: char;
  sizeStr: String;
begin
  Result := '-ָ�����';
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
      Result := '-д�볤�ȴ���';
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

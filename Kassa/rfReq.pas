unit rfReq;


interface
uses Windows, Classes, SysUtils, rfUnit;

procedure ListFiles;
procedure ReadFile(FN: String);
function MoveFile(FN: String): Boolean;
procedure ProcessFiles;
procedure ProcessRequest;

function GetArgNum(Cmd: String): Integer;
function GetNextArg(var Cmd: String): String;


procedure prServicePay(Cmd: String);
procedure prProgramGoods(Cmd: String);
procedure prComment(Cmd: String);
procedure prDoSale(Cmd: String);
procedure prDoPay(Cmd: String);
procedure prFolders(Work: String;Move: String);

var
   FileList,
   CurrFile: TStringList;
   WorkFolder : String = 'C:\RFBILLS\';
   MoveFolder : String = 'C:\RFBILLS\ARCHIVE\';
   LentaFolder : String = 'C:\RFBILLS\Lenta\';
   chrSep: Char = '$';
   maxSum: Integer = 100000; // 1000 ���
   startproc : Integer = 1;

implementation

procedure prFolders(Work: String;Move: String);
begin
  WorkFolder:=Work;
  MoveFolder:=Move;
end;


procedure ListFiles;
var
    FindResult: integer;
    SearchRec : TSearchRec;
begin
 FileList.Clear;
 FindResult := FindFirst(WorkFolder + '*.*', faAnyFile - faDirectory, SearchRec);
 while FindResult = 0 do
 begin
   FileList.Add(SearchRec.Name);
   FindResult := FindNext(SearchRec);
 end;
 FindClose(SearchRec);
 FileList.Sort;
end;

function MoveFile(FN: String): Boolean;
var
     c, NN: Char;
begin
     if not DirectoryExists(MoveFolder) then
          MkDir(MoveFolder);
     if FileExists(MoveFolder+FN) then
     begin
          NN := '!';
          for c := '0' to '9' do
              if Not FileExists(MoveFolder+FN+'.'+c) then
              begin
                   NN := c;
                   Break;
              end;
          if NN='!' then RaiseError('MVF: ������� ����� ������ ������ � ������ '+FN) else
          LogText(' * ���� � ������ ��� ����������, ��������������� � '+MoveFolder+FN+'.'+NN);
          Result := (Windows.MoveFile(PAnsiChar(WorkFolder+FN), PAnsiChar(MoveFolder+FN+'.'+NN)));
     end
     else
          Result := (Windows.MoveFile(PAnsiChar(WorkFolder+FN), PAnsiChar(MoveFolder+FN)));
end;

procedure ReadFile(FN: String);
var
    T: Text;
    S: String;
begin
     LogText('[*]������ ����: '+FN);
     Assign(T, WorkFolder+FN);
     Reset(T);
     CurrFile.Clear;
     while not EOF(T) do
     begin
          ReadLn(T, S);
          S := Trim(S);
          if S<>'' then CurrFile.Add(S);
     end;
     Close(T);
end;

procedure ProcessRequest;
var
    i: Integer;
    S: String;
begin
     LogCRLF;
     LogCRLF;
     LogText(' * ��������� �����:');
     for i := 0 to CurrFile.Count - 1 do
     begin
          S := CurrFile.Strings[i];
          LogCRLF;
          LogText(' * ��������� �������: "'+S+'"');


          case S[1] of
              '9': prServicePay(S);
              'Z': ;
              'X': ;
              'I': ;
              'J': ;
              '0': if S[2] = '$' then rfOpenRegister;
              'P': prProgramGoods(S);
              '@': prComment(S);
              '!': prDoSale(S);
              '2': prDoPay(S);
              else
                   RaiseError('PRQ: ���������� �������: "'+S+'"'); 
          end;
     end;
end;

procedure prServicePay(Cmd: String);
var
    S, Arg: String;
    ASum: String;
    ACom: String;
    M: Char;
begin
     if (GetArgNum(Cmd) < 3) or (GetArgNum(Cmd) > 4) then RaiseError('RSP: ������������ ���������� ����������');
     S := Cmd;
     Arg := GetNextArg(S);  // 9
     Arg := GetNextArg(S);  // 0 | 1
     if (Length(Arg)<>1) or ( not (Arg[1] in [srvGet, srvPut] ) ) then RaiseError('RSP: ������������ �������� 2');
     M := Arg[1];
     Arg := GetNextArg(S);
     ASum := Arg;
     if (GetArgNum(Cmd) = 4) then
     begin
      Arg := GetNextArg(S);
      ACom := Arg;
     end else ACom := ' ';
//     if ASum > maxSum then raise Exception.Create('RSP: ��������� ������������ �����');
     rfServicePay(M, ASum, ACom);
end;

function GetArgNum(Cmd: String): Integer;
var
    i, t: Integer;
begin
     if Length(Cmd) = 0 then
     begin
          Result := 0;
          Exit;
     end;
     t := 1;
     for i := 1 to Length(Cmd) do
         if Cmd[i] = chrSep then Inc(t);
     Result := t;
end;

function GetNextArg(var Cmd: String): String;
var
    i, l: Integer;
    S: String;
begin
     if Length(Cmd) = 0 then RaiseError('R01: ���������� � ������ ������, ��� ���������');

     S := '';
     i := 1;
     l := Length(Cmd);
     while (i <= l) and (Cmd[i] <> '$')  do
     begin
          S := S + Cmd[i];
          Inc(i);
     end;
     if i>l then Cmd := '' else Delete(Cmd, 1, i);
     Result := S;
end;


procedure prProgramGoods(Cmd: String);
var
     S, Arg, Nm: String;
     Code,
     Tid,
     Oid,
     Did,
     Gid,
     Gcd,
     Qty,
     Price:
            Integer;
begin
     S := Cmd;
     if GetArgNum(S) <> 10 then RaiseError('PRG: ������������ ���������� ����������');
     Arg := GetNextArg(S); // P

     Arg := GetNextArg(S); // ��� ������
     Code := StrToInt(Arg);
     if (Code < 1) or (Code > 8000) then RaiseError('PRG: ������������ �������� 2');

     Arg := GetNextArg(S); // ��� ������ ������
     Tid := StrToInt(Arg);
     if not (Tid in [1, 2, 3]) then RaiseError('PRG: ������������ �������� 3');

     Arg := GetNextArg(S); // �������� �������/������
     Oid := StrToInt(Arg);
     if not (Oid in [0, 8]) then RaiseError('PRG: ������������ �������� 4');

     Arg := GetNextArg(S); // ��������� �����
     Did := StrToInt(Arg);
     if not (Did in [0, 1, 2]) then RaiseError('PRG: ������������ �������� 5');

     Arg := GetNextArg(S); // �������� ������
     Gid := StrToInt(Arg);
     if (Gid <> 0) then RaiseError('PRG: ������������ �������� 6');

     Arg := GetNextArg(S); // ���������� ���
     Gcd := StrToInt(Arg);
     if (Gcd <> 1) then RaiseError('PRG: ������������ �������� 7');

     Arg := GetNextArg(S); // ������������
     Nm := Trim(Arg);
     if (Length(Nm) >20) then RaiseError('PRG: ������������ �������� 8');

     Arg := GetNextArg(S); // ����������
     Price := StrToInt(Arg);

     Arg := GetNextArg(S); // ����
     Qty := StrToInt(Arg);

     rfProgramGoods(Code, Tid, Oid, Did, Gid, Gcd, Qty, Price, Nm);
end;

procedure prComment(Cmd: String);
var
    S, Arg: String;
begin
     S := Cmd;
     if GetArgNum(S) <> 2 then RaiseError('CMT: ������������ ���������� ����������');
     Arg := GetNextArg(S); // @

     Arg := GetNextArg(S); // �����������
     if Length(Arg) > 24 then RaiseError('CMT: ������ ������� �������');
     rfComment(Arg);
end;

procedure prDoSale(Cmd: String);
var
    S, Arg: String;
    Code, Qty: Integer;
begin
     S := Cmd;
     if GetArgNum(S) <> 3 then RaiseError('DSL: ������������ ���������� ����������');
     Arg := GetNextArg(S); // !

     Arg := GetNextArg(S); // ���
     Code := StrToInt(Arg);

     Arg := GetNextArg(S); // ����������
     Qty := StrToInt(Arg);

     rfDoSale(Code, Qty);
end;

procedure prDoPay(Cmd: String);
var
    S, Arg, Oid: String;
    Sum: Integer;
begin
     S := Cmd;
     if GetArgNum(S) <> 3 then RaiseError('DPY: ������������ ���������� ����������');
     Arg := GetNextArg(S); // 2

     Arg := GetNextArg(S); // 2
     Sum := StrToInt(Arg);
     Arg := GetNextArg(S); // 2
     Oid := Arg;
     if (Oid = '4') then rfDoPay(0, Oid) else rfDoPay(Sum, Oid);
end;

procedure ProcessFiles;
begin
     ListFiles; // �������� ������ ������
     if FileList.Count > 0 then // ��������� ���-��
     begin // ���������� ������ �� ������ ����
          ReadFile(FileList.Strings[0]);
          if MoveFile(FileList.Strings[0]) then
              ProcessRequest
          else
              RaiseError('�� ���� ��������� ���� � ����� ��� ������������ ������.');
     end;
startproc := 0;
end;

end.

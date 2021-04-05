program test;

{$APPTYPE CONSOLE}

uses
  windows,
  SysUtils,
  uLkJSON in 'uLkJSON.pas';

var
  js:TlkJSONobject;
  xs:TlkJSONbase;
  i,j,k: Integer;
  ws: String;
begin
  js := TlkJSONobject.Create;
  k := GetTickCount;
  for i := 0 to 5000 do
    begin
      ws := 'param'+inttostr(i);
      js.add(ws,TlkJSONstring.Generate(ws));
      ws := 'int'+inttostr(i);
      js.add(ws,TlkJSONnumber.Generate(i));
    end;
  k := GetTickCount-k;
  writeln('records inserted:',js.count);
  writeln('time for insert:',k);
  writeln('hash table counters:');
  writeln(js.ht.counters);
  k := GetTickCount;
  ws := TlkJSON.GenerateText(js);
  writeln('text length:',length(ws));
  k := GetTickCount-k;
  writeln('time for gentext:',k);
  k := GetTickCount;
  xs := TlkJSON.ParseText(ws);
  k := GetTickCount-k;
  writeln('time for parse:',k);
  writeln('press enter...');
  readln;
  writeln(ws);
  writeln('press enter...');
  readln;
  if assigned(xs) then FreeAndNil(xs);
  js.Free;
end.

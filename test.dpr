// i improve test for version 0.94 - add random part to names of fields;
// it smaller decrease speed of generation, but much better for testing
//
// Leon, 27/03/2007

program test;

{$APPTYPE CONSOLE}

uses
  windows,
  SysUtils,
  uLkJSON in 'uLkJSON.pas';

var
  js:TlkJSONobject;
  xs:TlkJSONbase;
  i,j,k,l: Integer;
  ws: String;
begin
  Randomize;
  js := TlkJSONobject.Create;
  k := GetTickCount;
  for i := 0 to 5000 do
    begin
      l := random(9999999);
      ws := 'param'+inttostr(l);
      js.add(ws,TlkJSONstring.Generate(ws));
      ws := 'int'+inttostr(l);
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
  writeln('approx speed of parse (th.bytes/sec):',length(ws) div k);
  writeln('press enter...');
  readln;
  writeln(ws);
  writeln('press enter...');
  readln;
// works in 0.94 only!
  js := TlkJSONobject(xs);
  for i := 1 to 10 do
    begin
      writeln('field ',i,' is ',js.NameOf[i]);
      writeln('type of field ',i,' is ',js.FieldByIndex[i].SelfTypeName);
      writeln('value of field ',i,' is ',js.FieldByIndex[i].Value);
      writeln;
    end;
  writeln('press enter...');
  readln;
  if assigned(xs) then FreeAndNil(xs);
  js.Free;
end.

// Sample 2: how to get child type and subobject fields
//
// Leonid Koninin, 02/03/2007

program sample2;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  uLkJSON in 'uLkJSON.pas';

var
  js,xs:TlkJSONobject;
  ws: TlkJSONstring;
  s: String;
  i: Integer;
begin
  s := '{"string1":"one","string2":"two",'+
    '"childobject":{"objstr1":"Oone","objstr2":"Otwo"}}';
  writeln(s);
// restore object (parse text)
  js := TlkJSON.ParseText(s) as TlkJSONobject;
  writeln('parent self-type name: ',js.SelfTypeName);
// how to obtain type of child
  if not assigned(js) then
    begin
      writeln('error: xs not assigned!');
      readln;
      exit;
    end
  else
    begin
      if js.Field['childobject'] is TlkJSONnumber then writeln('type: xs is number!');
      if js.Field['childobject'] is TlkJSONstring then writeln('type: xs is string!');
      if js.Field['childobject'] is TlkJSONboolean then writeln('type: xs is boolean!');
      if js.Field['childobject'] is TlkJSONnull then writeln('type: xs is null!');
      if js.Field['childobject'] is TlkJSONlist then writeln('type: xs is list!');
      if js.Field['childobject'] is TlkJSONobject then writeln('type: xs is object!');
    end;
// the other way (0.93+)
  case js.Field['childobject'].SelfType of
    jsBase : writeln('other type: xs is base');
    jsNumber : writeln('other type: xs is number');
    jsString : writeln('other type: xs is string');
    jsBoolean : writeln('other type: xs is boolean');
    jsNull : writeln('other type: xs is null');
    jsList : writeln('other type: xs is list');
    jsObject : writeln('other type: xs is object');
  end;
  writeln('self-type name: ',js.Field['childobject'].SelfTypeName);
// and get string back
  xs := js.Field['childobject'] as TlkJSONobject;
// we know what xs chilren are strings
  ws := xs.Field['objstr1'] as TlkJSONstring;
  writeln(ws.value);
  ws := xs.Field['objstr2'] as TlkJSONstring;
  writeln(ws.value);
//
  readln;
  js.Free;
end.


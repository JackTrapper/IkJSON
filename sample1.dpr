// Sample 1: how to generate text of an object and obtain object from text;
// how to add an field to object and get it back.
//
// Leonid Koninin, 02/03/2007

program sample1;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  uLkJSON in 'uLkJSON.pas';

var
  js:TlkJSONobject;
  ws: TlkJSONstring;
  s: String;
  i: Integer;
begin
  js := TlkJSONobject.Create;
  js.add('namestring', TlkJSONstring.Generate('namevalue'));
// get the text of object
  s := TlkJSON.GenerateText(js);
  writeln(s);
  js.Free;
// restore object (parse text)
  js := TlkJSON.ParseText(s) as TlkJSONobject;
// and get string back
  ws := js.Field['namestring'] as TlkJSONstring;
  s := ws.Value;

  writeln(s);

  readln;
  js.Free;
end.
